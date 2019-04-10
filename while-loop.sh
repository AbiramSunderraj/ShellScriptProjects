echo "ENTER A NUMBER: \c"
read num
while [ $num -le 10 ]
do 
echo "$num "
num=`expr $num + 1`
done
