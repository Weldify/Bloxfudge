local Bloxfudge: {
	Bytecode: (string) -> string;
	Transpile: (string) -> string;
	Run: (string) -> nil;
} = {}

do
	local decompressedTokens: {[string]: string} = {
		["q"] = "i-=";
		["w"] = "i+=";
		["e"] = "c[i]+=";
		["r"] = "c[i]-=";
		["t"] = "b(o,c,i)";
		["y"] = "p(o)";
		["u"] = "while(c[i]~=0)do ";
		["i"] = "end "
	}
	
	local compressedTokens: {[string]: string} = {
		["<"] = "q";
		[">"] = "w";
		["+"] = "e";
		["-"] = "r";
		["^"] = "t";
		["!"] = "y";
		["("] = "u";
		[")"] = "i"
	}
	
	local concattableTokens: {[string]: boolean} = {
		["q"] = true;
		["w"] = true;
		["e"] = true;
		["r"] = true;
	}

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

	function Bloxfudge.Bytecode(src: string): string
		local str: string = ""
		
		local concatNum: number = 1
		for i: number = 1, #src do
			local ch: string = src:sub(i, i)
			local nextCh: string? = src:sub(i + 1, i + 1)
			local token: string? = compressedTokens[ch]

			if token then
				local concattable: boolean? = concattableTokens[token]
				if concattable and nextCh == ch then
					concatNum += 1
					continue
				elseif concattable then
					local prevToken: string = compressedTokens[ch]
					token = ("%s%s"):format(prevToken, if concatNum > 1 then tostring(concatNum) else "")

					concatNum = 1
				end
				
				str = ("%s%s"):format(str, token)
			end
		end

		return str
	end
	
	function Bloxfudge.Transpile(bytecode: string)
		local native: string = ""
		
		local curToken: string = bytecode:sub(1, 1)
		local numStr: string = ""
		for i: number = 2, #bytecode + 1 do
			local token: string = bytecode:sub(i, i)
			
			if tonumber(token) ~= nil then
				numStr = ("%s%s"):format(numStr, token)
			else
				local decTok: string = decompressedTokens[curToken]
				local tokStr: string = if numStr == "" then (if concattableTokens[curToken] then ("%s%s"):format(decTok, "1 ") else decTok) else ("%s%s "):format(decTok, numStr)
				native = ("%s%s"):format(native, tokStr)
				
				curToken = token
				numStr = ""
			end
		end
		
		return native
	end

	function Bloxfudge.Run(native: string)
		local lua: string = ("local c:{number}=t(1000, 0)local o:{string}={''}local i:number=1 %s"):format(native)

		local Func = loadstring(lua)

		setfenv(Func, env)

		Func()
	end
end

return Bloxfudge