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

local cmpe = os.clock()
print(("[BYTECODE]: %fs"):format(cmpe - cmps))

local tps = os.clock()

local native = Bloxfudge.Transpile(bytecode)

local tpe = os.clock()
print(("[TRANSPILE]: %fs"):format(tpe - tps))

local runs = os.clock()

Bloxfudge.Run(native)

local rune = os.clock()
print(("[RUN]: %fs"):format(tpe - tps))

--output:
--[[
	[BYTECODE]: 0.000110s
	[TRANSPILE]: 0.000062s
	[RUN] 0.000062s
]]
```