echo "ENTER A CHARACTER: \c"
read var
case $var in
[a-z])
	echo "YOU ENTERED A SMALL CASE CHARACTER."
	;;
[A-Z])
	echo "YOU ENTERED A UPPER CASE CHARACTER."
;;
[0-9])
	echo "YOU ENTERED A NUMBER."
;;
?)
	echo "YOU ENTERED A SPECIAL CHARACTER."
;;
*)
	echo "TRY AGAIN."
;;
esac
