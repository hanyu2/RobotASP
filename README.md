# RobotASP
---
Knowledge representation and resoning project.
Use ASP to help multi-robots find path in an environment.
Use python @getLinkage get link to current position, @link_exists to know connection between two positions, @barrier_exsits to check barrier positions.

Use such command to execute in a 6 positions envirionment:
clingo robotASP.lp -C maxstep=6 map.txt getLinkage.py
