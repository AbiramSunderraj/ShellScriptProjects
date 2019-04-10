echo "Enter a username: \c"
read uname
IFS=":"
set `grep $uname /etc/passwd`
for i in $*
do
	echo "$i"
done

