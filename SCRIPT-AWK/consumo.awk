BEGIN{
print "%CPU   %RAM   PROCESS"
}
{
a = $1
b = $2
c = $3
d = $4
e = $5
f = $6
g = $7
h = $8
cpu = $9
ram = $10
m = $11
name = $12


if ( $12=="ns"  )
	print ( $9"    " $10"     "$12  );	
}
END {
printf ("Eseguito correttamente");
}



