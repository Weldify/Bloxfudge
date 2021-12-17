# Bloxfudge
Bloxfudge is an esoteric programming language which is derived from Brainf--k and implemented in Luau.
___
# Specifications
```
you are given 1000 cells, each cell holds the value of 0

commands:
< -- shift left
> -- shift right

+ -- increment the current cell
- -- decrement the current cell

^ -- push cell to the output buffer
! -- print and clear the output buffer

[ -- start loop, remains active while the current cell is not equal to 0
] -- end loop
```
___
# "Hello World" Example
```
+++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++^+++++++++++++++++
++++++++++++^+++++++^^+++^-------------------
---------------------------------------------
---------------^+++++++++++++++++++++++++++++
++++++++++++++++++++++++++^++++++++++++++++++
++++++^+++^------^--------^------------------
---------------------------------------------
----^!
```
```
Hello World!
```
___
# Benchmark
```lua
-- benchmark for the hello world program
-- code:
local btcTimes = {}
local trplTimes = {}
local runTimes = {}

for i = 1, 100 do
	task.wait()
	
	local cmps = os.clock()
	local bytecode = Bloxfudge.Bytecode([[
		+++++++++++++++++++++++++++++++++++++++++++++
		+++++++++++++++++++++++++++^+++++++++++++++++
		++++++++++++^+++++++^^+++^-------------------
		---------------------------------------------
		---------------^+++++++++++++++++++++++++++++
		++++++++++++++++++++++++++^++++++++++++++++++
		++++++^+++^------^--------^------------------
		---------------------------------------------
		----^!
	]])
	table.insert(btcTimes, os.clock() - cmps)
	
	task.wait()
	
	local tps = os.clock()
	local native = Bloxfudge.Transpile(bytecode)
	table.insert(trplTimes, os.clock() - tps)
	
	task.wait()

	local runs = os.clock()
	Bloxfudge.Run(native)
	table.insert(runTimes, os.clock() - runs)
end

local function Avg(t)
	local n = 0
	for i, v in ipairs(t) do
		n += v
	end
	
	return n / #t
end

print(("[BYTECODE]: %.8fs"):format(Avg(btcTimes)))
print(("[TRANSPILE]: %.8fs"):format(Avg(trplTimes)))
print(("[RUN]: %.8fs"):format(Avg(runTimes)))

--output on my machine:
	[BYTECODE]: 0.00011561s
  	[TRANSPILE]: 0.00005262s
  	[RUN]: 0.00023638s
```