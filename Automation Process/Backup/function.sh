str_loc(){  ##Backup location selection, Local or cloud.
        echo -e "\nSelect storage type.\nA. Local Storage(Device attached to this PC)\nB. Cloud Storage(To another server/Network storage devices.)"
        echo -e "\nOption[A/B]: \c"
        read strg_type
        case $strg_type in
                'A' | 'a' )
                        echo -e "\nSelected backup method is 'LOCAL backup'."
                        bmeth="Local"
			bkup_type
                        ;;
                'B' | 'b' )
                        echo -e "\nSelected backup method is 'CLOUD backup'."
                        bmeth="Cloud"
			cauth
			bkup_type
                        ;;
                *)
                        echo -e "\nError: Incorrect Option. Choose a correct backup method."
                        str_loc
                        ;;
                esac
}

cauth(){ #Cloud auth details
echo -e "Enter server/network storage IP address: \c"
read ipaddr #check wheather the host is up or not and use exit status to determine.
echo -e "\n\nEnter username to login: \c"
read cuname
echo -e "\n\nEnter user password to connect: \c"
}


bkup_type(){ # Select the type of backup. Full, Incremental and Partial
        echo -e "\nSelect the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
        read bkup_opt
        case $bkup_opt in
                'A' | 'B' | 'C' | 'a' | 'b' | 'c' )
                        if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                        then
                                echo -e "\nSelected Backup Type is FULL."
				bopt="Full"
				src_loc
                                opt=""
				if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        	then
                                	LFB
                        	else
                                	CFB
                        	fi
                        elif [ "$bkup_opt" = 'B' -o "$bkup_opt" = 'b' ]
                        then
                                echo -e "\nSelected Backup Type is INCREMENTAL."
				bopt="Incremental"
				src_loc
                                opt=""
				if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        	then
                                	LIB
                        	else
                                	CIB
                        	fi
                        else [ "$bkup_opt" = 'C' -o "$bkup_opt" = 'c' ]
                                echo -e "\nSelected Backup Type is PARTIAL."
				bopt="Partial"
				part_bkup
                        fi
                        ;;
                *)
                        echo -e "\nError: Incorrect Option. Choose a correct backup type."
                        bkup_type
        esac
}


part_bkup(){
	echo -e "\nChoose an option from below.\nA. Backup by Date.\nB. Backup by File type.\nC. Backup by File size.\nD. Backup by user name.\n\nEnter Option[A/B/C/D] : \c"
        read opt
	case $opt in
                'a' | 'A' )
                        echo -e "\nBackup by date.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
			then
				LPD
			else
				CPD
			fi
                        ;;
                'b' | 'B' )
                        echo -e "\nBackup by file type.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPT
                        else
                                CPT
                        fi
                        ;;
                'c' | 'C' )
                        echo -e "\nBackup by file size.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPS
                        else
                                CPS
                        fi
                        ;;
                'd' | 'D' )
                        echo -e "\nBackup by user name.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPN
                        else
                                CPN
                        fi
                        ;;
		* )
			echo -e "\nError: Incorrect option."
			part_bkup
        esac
}

src_loc(){ ##Source path selection to take backup.
        echo -e "\nSpecify source path: \c"
        read srcpath
        ls $srcpath >> /dev/null 2>&1
        if [ "$?" -eq 0 ]
        then
                dest_loc
        else
                echo -e "\nError: Path does not exist, try with different path."
                src_loc
        fi
}

dest_loc(){
        echo -e "\nSpecify destination path: \c"
        read destpath
        ls $destpath >> /dev/null 2>&1
        if [ "$?" -eq 0 ]
        then
		echo -e "\nSource path is '$srcpath'\nDestintion path is '$destpath'\n\nType 'YES' to continue or any other key to re-specify the location(s) again: \c"
        read loc_opt
        case $loc_opt in
                'YES' | 'Yes' | 'yes' )
			sleep 1
                        echo -e "\nLocations verified. . .\n"
                        dschk
                        ;;
                * )
                        echo -e "Specify the destination location again."
                        src_loc
                        ;;
        esac
        else
                echo -e "\nError: Path does not exist, try with different path.\n\n"
                dest_loc
        fi
}


##Actual functions

LFB(){ #Local full backup
set `find $srcpath -type f -iname "*" -exec du -ch {} + | grep total$`
tfsize=$1
echo -e "Total file size to be transfered $1 (approx.)\n"
read -n1 -p "Press any key to continue..."
echo -e "\nBackup in progress. . .\n"
cp -rfp $srcpath/ $destpath
echo -e "\n\nBackup successfully completed.\n\n"
bkup_info
}

LIB(){ #Local Incremental Backup
set `find $srcpath -type f -iname "*" -exec du -ch {} + | grep total$`
tfsize=$1
echo -e "Total file size to be transfered is $1 (approx.)" 
read -n1 -p "Press any key to continue..."
echo -e "\nBackup in progress. . .\n"
rsync -raphz --progress $srcpath/ $destpath 
echo -e "Backup successfully completed.\n\n"
bkup_info
}

LPT(){ #Local Partial backup by Type
echo -e "Enter the extension of a file (Example: doc,docx,pdf): \c"
read fext
find $srcpath -type f -iname "*.$fext" -exec rsync -raphz --progress {} $destpath \;
echo -e "Backup successfully completed.\n\n"
}

LPN(){
echo -e "Enter a username to begin backup: \c" 
read uname
find $srcpath -user "$uname" -exec rsync -raphz --progress {} $destpath \;
echo -e "\nBackup successfully completed.\n\n"
}

LPS(){
echo -e "Enter the file size (Example: +10M for files greater than 10 MB or -10M fsize lesser than 10 MB): \c"
read fsize
case $fsize in
	+*k | +*M | +*G | -*k | -*M | -*G)
		find $srcpath -size $fsize -exec rsync -raphz --progress {} $destpath \;
		echo -e "\nBackup successfully completed. . .\n\n"
	;;
*)
		echo -e "\nError: Incorrect option.\n"
		LPS
esac
}

LPD(){ #Local partial backup by modifed date.
echo -e "\nEnter number of days to take backup from: \c"
read days
find $srcpath -type f -ctime -$days -exec rsync -raphz --progress {} $destpath \;
echo -e "\nBackup successfully completed. . .\n\n"
}

CFB(){
echo -e "Backup in progress. . .\n"
rsync -raphz --progress ssh $srcpath/ $uname@$ipaddr:$destpath #>bkup.log 2>&1
echo -e "Backup successfully completed.\n\n"
}

CIB(){
 echo -e "\nOK.."

}

CPT(){
 echo -e "\nOK.."

}

CPO(){
 echo -e "\nOK.."

}

CPS(){
 echo -e "\nOK.."

}

CPD(){
 echo -e "\nOK.."
}



dschk(){
dss=`df -h $destpath`
set `echo -e "$dss" | tail -n 1`
echo -e "\nAvailable disk space in destination path is $4"
}

bkup_info(){
ls bkup.info >>bkup.log 2>&1
if [ "$?" -ne 0 ]
then
	touch bkup.info
	echo "S.No;Backup_method;Backup_option;Date;Time;Source;Destination;Backup_size" | column -t >> bkup.info
	count=0
bkup_info
else
	sno=`expr $count + 1`
	cdate=`date "+%b-%d-%Y"`
	ctime=`date "+%H:%M:%S"`
	echo "$sno;$bmeth;$bopt;$cdate;$ctime;$srcpath;$destpath;$tfsize" | column -t >> bkup.info
fi
}
