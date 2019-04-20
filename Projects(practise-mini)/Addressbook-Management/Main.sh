#addressbook management with search, edit, manipulate and preview features.

new_entry()
{
echo "Enter Username, Mobile number & E-mail id:"
echo "Name: \c"
read uname
echo "Mobile Number: \c"
read mnum
echo "E-mail: \c"
read mid
}

modify_entry()
{
echo "Enter 'A' for modify username.\nEnter 'B' for modify phone number.\nEnter 'C' for modify e-mail address."
echo "Option [A/B/C]: \c"
read opt
case $opt in
A)
	echo "Enter username: \c"
	read uname
	;;
B)
	echo "Enter Phone number: \c"
	read mnum
	;;
C)
	echo "Enter E-mail: \c"
	read mid
	;;
*)	echo "Please try again"
	;;
esac
}

main_option(){
read opt
case $opt in
1)
	echo "Add new Entry"
	new_entry
	;;
2)	
	echo "Enter name or Phone number or E-mail id of the user or even a single phrase: \c"
	read phrasee
	;;
3)	
	echo "Enter username to edit: \c"
	read unamee
	;;
esac
}


echo "Hai welcome to the Addressbook, here you can able to add, search and update the details of user. Select an option to continue.\nOption '1' for new entry.\nOption '2' search in the addressbook.\nOption '3' for edit an entry.\n\nEnter an option [1/2/3]: \c"
main_option
#cat >> userdetails
#$uname	$mnum	$mid
