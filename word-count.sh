echo "ENTER SOMETHING:\c"
read var
if [ `echo $var | wc -c` -ne 0 ]
then
	echo "YOU'VE ENTERED SOMETHING."
else
	echo "PLEASE ENTER SOMETHING."
fi
