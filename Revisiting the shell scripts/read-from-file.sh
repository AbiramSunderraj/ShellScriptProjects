echo "Enter a file name:"    #asking the file and store it in a variable
read fname
if [ -z "$fname" ]           #check whether the file is empty or not, if it is empty file it exits the shell
then
    exit
fi

terminal=`tty`               #Grabbing the current user terminal using "tty" command
exec < $fname                #manipulate the input type  using "exec" command

while read n                 #reading the content of the file
do
     useradd $n              #creating the user and assigning the passwd
     echo -e "$n\n$n" | `passwd $n`
done
sleep 1
echo "All users are added."
exec < $terminal            #Finally switch back to default input type that is tty




#Feature enhancement: Giving several options like adding the users in which type of shell, modification of users etc.. etc..
