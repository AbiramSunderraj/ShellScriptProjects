echo "Enter file name: \c"
read fname
if [ -z "$fname" ]
then
	exit
fi

terminal=`tty`
exec < $fname
nos=0
now=0
while read lines
do
	nos=`expr $nos + 1`
	set $lines
	now=`expr $now + $#`
done
echo $now
echo $nos
