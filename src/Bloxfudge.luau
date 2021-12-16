local Bloxfudge: {
	Compile: (string) -> string;
	Run: (string) -> nil;
} = {}

do
	local decompressedTokens: {[string]: string} = {}
	decompressedTokens["1"] = "i-=1 "
	decompressedTokens["2"] = "i+=1 "
	decompressedTokens["3"] = "c[i]+=1 "
	decompressedTokens["4"] = "c[i]-=1 "
	decompressedTokens["5"] = "b(o,c,i)"
	decompressedTokens["6"] = "p(o)"
	decompressedTokens["7"] = "while c[i]~=0 "
	decompressedTokens["8"] = "end "

	local compressedTokens: {[string]: string} = {}
	compressedTokens[">"] = "1"
	compressedTokens["<"] = "2"
	compressedTokens["+"] = "3"
	compressedTokens["-"] = "4"
	compressedTokens["^"] = "5"
	compressedTokens["!"] = "6"
	compressedTokens["["] = "7"
	compressedTokens["]"] = "8"

	local env: {
		t: <V>(number, V?) -> {V};
		b: ({string}, {number}, number) -> nil;
		p: ({string}) -> nil
	} = {
		t = table.create;
		b = function(o: {string}, c: {number}, i: number)
			o[1] = string.format("%s%s", o[1], string.char(c[i]))
		end;
		p = function(o: {string})
			print(o[1])
			o[1] = ""
		end,
	}

	function Bloxfudge.Compile(src: string): string
		local str: string = ""
		
		for i: number = 1, #src do
			local ch: string = src:sub(i, i)
			local token: string? = compressedTokens[ch]
			
			if token then
				str = string.format("%s%s", str, token)
			end
		end
		
		return str
	end

	function Bloxfudge.Run(src: string)
		local str: string = "local c:{number}=t(1000, 0)local o:{string}={''}local i:number=1 "
		for i: number = 1, #src do
			local ch: string = src:sub(i, i)
			str = string.format("%s%s", str, decompressedTokens[ch])
		end
		
		local Func = loadstring(str)
		
		setfenv(Func, env)
		
		Func()
	end
end