#addressbook management with search, edit, manipulate and preview features.

IFS=":"

main_option(){          #Options
echo "Select an option to continue.\nOption '1' for new entry.\nOption '2' search in the addressbook.\nOption '3' for edit an entry. \n\nEnter an option [1/2/3]: \c"
read opt
case $opt in
1)
        echo "Add new Entry"
        new_entry
        input_conformation
        ;;
2)
        search
        ;;
3)
        modify_Entry
        ;;
*)
	sleep 1s
        echo "Exiting. . ."
        ;;
esac
}

new_entry()		#For new user, creates a new row for a user.
{
echo "Enter Username, Mobile number & E-mail id:"
echo "First name: \c"
read fname
echo "Last name : \c"
read lname
echo "Mobile no : \c"
read mnum
echo "E-mail id : \c"
read mid
}

input_conformation()	#Conforming the details after entry.
{
sleep 1s
echo "\nSelect Y|y to continue or any other character to re-enter the detais: \c"
echo "Successfully added."
read conf
if [ "$conf" = "Y" -o "$conf" = "y" ]
then
	set `wc -l userdetails`
	echo $0
        echo "$1:$fname:$lname:$mnum:$mid" >> userdetails
	echo "\n"
else
        new_entry
fi
}

search(){		#Searching the user details in the file
echo "Enter name or Phone number or E-mail id of the user or even a single phrase: \c"
read search_item
column -s":" -t userdetails | grep -i "$search_item"
echo "\n"
main_option
}

modify_entry()		#To modify the previously entered informations
{
echo "Enter user's serial number: \c"
read unum
echo "Enter 'A' for modify username.\nEnter 'B' for modify phone number.\nEnter 'C' for modify e-mail address."
echo "Option [A/B/C]: \c"
read opt
case $opt in
A)
	echo "First name: \c"
	read uname
	;;
B)	echo "Last name : \c"
	read lname
	;;
c)
	echo "Mobile no : \c"
	read mnum
	;;
D)
	echo "E-mail id : \c"
	read mid
	;;
*)	echo "Please try again"
	;;
esac
}

delete_entry()
{
echo "Enter"

}

echo "Hai welcome to the Addressbook, here you can able to add, search and update the details of user."

main_option
