echo "ENTER A FILE NAME:\c"
read name
if [ -f $name ]
then
	if [ -w $name ]
	then
		echo "ENTER TEXTS TO ENTER AND PRESS CTRL+D."
		cat >> $name
	else 
		echo "File does not have write permission."
	fi
else echo "ENTER A VALID FILE NAME."
fi
