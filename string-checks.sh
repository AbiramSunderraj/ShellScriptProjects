str1="I love linux"
str2="I am going to be a threat analyst"
str3=

[ "$str1" =  "$str2" ]
echo $?

[ "$str1" != "$str2" ]
echo $?

[ -n "$str3" ]
echo $?

[ -z "$str3" ]
echo $?
