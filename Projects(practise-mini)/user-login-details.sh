echo "Enter a username: \c"

func()
{
read uname
grep $uname /etc/passwd >> /dev/null
}

funt()
{
echo "Incorrect username\nDo you want to try again[Y/N]: \c"
read ans
	if [ $ans = "Y" -o $ans = "y" ]
	then
		sleep 1s
		echo "Re-enter username: \c"
	else
		echo "Abort"
		exit
	fi
func
}

func

if [ $? -eq 0 ]
then
	continue
else
	funt
fi

while [ $? -eq 0 ]
do
	echo "Checking\c"
         sleep 1s
         a=3
         while [ $a -gt 0 ]
         do
                echo " .\c"
                a=`expr $a - 1`
                sleep 1s
         done
	set `who | grep $uname`
	echo "\nLogin user name is = $1" ; sleep 1s
	echo "Login date is $3 at $4 hr's." 
	exit
done
