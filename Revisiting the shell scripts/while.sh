echo "Enter a minimum value:"      #Asks and read min value
read min_val
echo "Enter a maximum value:"      #Asks and read max value
read max_val
while [ $min_val -le $max_val ]    #Condition to check value is less than, equal or greater than
do
     echo $min_val                 #Display the current min value
     min_val=`expr $min_val + 1`   #Incrementing the min value by 1
done
