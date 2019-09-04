#ARRAY PRACTISE

#    ARRAY_NAME[INDEX_NUM]=VALUE

country=('India' 'Japan' 'United States of America' 'Russia' 'United Kingdom'); #Values seperated by space NOT COMMA OR SEMI-COLAN
country=("${country[@]}" "UAE" "Australia" 'Netherlands') #Concatenation of array with extra values
#index[0]=India
#index[1]=Japan
#index[2]=China
#index[3]=Bhutan

for i in ${country[*]}    #For loop to display all the values
do
	echo -e "$i"
	#i=`expr $i + 1` -- No need of incrementing the i value here, it will automatically increment the value for for loop.
done
echo " "

#echo ${country[@]/Russia/Ukrine}

echo ${country[2]}        #To view the specfic value

##############################      Removing an array element.

echo "Enter the position of an element to be deleted."        #Getting the value of the position
read pos
country=("${country[@]:0:$pos}" "${country[@]:$(($pos + 1))}") #Concatenating the next element in the array with previous elements before the specfic position
echo ${country[@]}

sleep 3  #Just some time delay

echo "Add array elements one by one and press 'ctrl+d' to save."

while read input         #reading input and storing in array
do
	colors=("${colors[@]}" "$input")  #Concatenating elements with previous elements
done

echo ${colors[@]}


#echo ${index[0]}
#echo ${index[2]}
#echo ${index[1]}
#echo ${index[3]}
