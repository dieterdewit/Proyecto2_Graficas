#!/bin/sh
bindir=$(pwd)
cd /home/kamiryu/Documents/Universidad/2019_1/Graficas por Computadora/CAT/Proyectos/Proyecto2/Proyecto2/proyecto2/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "xYES" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		/usr/bin/gdb -batch -command=$bindir/gdbscript --return-child-result /home/kamiryu/Documents/Universidad/2019_1/Graficas\ por\ Computadora/CAT/Proyectos/Proyecto2/Proyecto2/build/proyecto2_assimp 
	else
		"/home/kamiryu/Documents/Universidad/2019_1/Graficas\ por\ Computadora/CAT/Proyectos/Proyecto2/Proyecto2/build/proyecto2_assimp"  
	fi
else
	"/home/kamiryu/Documents/Universidad/2019_1/Graficas\ por\ Computadora/CAT/Proyectos/Proyecto2/Proyecto2/build/proyecto2_assimp"  
fi
