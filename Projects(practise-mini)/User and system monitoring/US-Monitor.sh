#code for displaying specified user and system details

echo "Enter a username: \c"

#Asking for the username and checking weather the name is exists or not
uname_pass()
{
read uname
grep $uname /etc/passwd >> /dev/null
a=$?
}

uname_pass

#Main execution.
login_dtls(){
	echo "Checking.\c"
        sleep 1s
	a=2
        while [ $a -gt 0 ] #little time delay for checking dot(.)
        do
               echo " .\c"
               a=`expr $a - 1`
               sleep 1s
        done
	set `who | grep $uname`
	echo "\nLogin user name is = $1" ; sleep 1s
	echo "Login date is $3 at $4 hr's." 
	exit
}

#Asking weather to check with othernames, if the previous one fails.
rntr_uname()
{
echo "Incorrect username. Do you want to try again[Y/N]: \c"
read ans
	if [ $ans = "Y" -o $ans = "y" ]
	then
		sleep 1s
		echo "Re-enter username: \c"
	else
		echo "Abort"
		exit
	fi
}

if [ $a -eq 0 ]
then
	login_dtls
else
        until [ $a -eq 0 ]
	do 
		rntr_uname
		uname_pass
		if [ $a -eq 0 ]
		then
			login_dtls
		fi
	done
fi
