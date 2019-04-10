echo "enter two numbers seperated by space."
read a b
if [ $a -gt $b ]
then
	echo "NUM 1 GREATER"
elif  [ $b > $a ]
then
	echo "NUM 2 GREATER"
else
	echo "BOTH NUMBERS ARE EQUAL."
fi
