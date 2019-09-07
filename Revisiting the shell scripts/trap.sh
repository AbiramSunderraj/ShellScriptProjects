set -x #Used to verbos the output with corresponding line(s) of execution, good for debugging
trap "echo system has detected interrup signals >> log" 0 2 3 15 #Trapping interrupt signals
echo "PID for this process is $$" #getting current process(script) PID
set +x #Removing the verbos output
count=10
while [ $count -ge 0 ]   #A loop that prints from 10 to 0
do
	echo $count
	count=`expr $count - 1`
	sleep 3
done
