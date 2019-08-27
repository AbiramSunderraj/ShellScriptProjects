#FOR LOOP
echo "enter path of the directory you need."

read path
for i in $path/*
do
	if [ -d $i ]
	then
		IFS=/
		set $i
		echo $i
	fi
done
