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
----^-----------------------^!
```
___