echo "Enter a file name: \c"
read fname
if [ -z "$fname" ]
then
	exit
fi
terminal=`tty`
exec < $fname
lino=1
while read line
do
	echo $lino.$line
	lino=`expr $lino + 1`
	sleep 2s
done
exec < $terminal
