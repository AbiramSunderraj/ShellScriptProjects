#Know the user logon details.
echo "Enter the username: "      ##Reading input from the user
read uname

cat /etc/passwd | grep $uname >> /dev/null ##Checking weather the user really exists or not, /dev/null is used to dump the unwanted  messages shown in terminal
if [ $? -eq 0 ]
then
  echo "Please wait a moment . . ."
  sleep 1

  while true            ##If user exists and logged in alredy then grab the user details and wait
  do
    w | grep "$uname" > /dev/null
    if [ $? -eq 0 ]
    then
       set `w | grep "$uname"`
       echo "User $1 logged in at $4 and uses $2 Terminal"
       ctime=`date -u +%R`
       echo "$ctime"
       break
    else   ##If the user exists and not logged in then wait until user logs in, the script continously checks for every 5 seconds
       echo "The user has not login yet. Monitoring for user login."
       sleep 5
    fi
   done

else    ## If the user name does not exist, then show the message and exist
   echo "No user is available in the name of $uname"
fi


##next improvement will be log the difference of user login and some extra functionalities
