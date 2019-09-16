str_loc(){  ##Backup location selection, Local or cloud.
        echo -e "\nSelect storage type.\nA. Local Storage(Device attached to this PC)\nB. Cloud Storage(To another server/Network storage devices.)"
        echo -e "\nOption[A/B]: \c"
        read strg_type
        case $strg_type in
                'A' | 'a' )
                        echo -e "\nSelected backup method is 'LOCAL backup'."
			bkup_type
                        ;;
                'B' | 'b' )
                        echo -e "\nSelected backup method is 'CLOUD backup'."
			bkup_type
                        ;;
                *)
                        echo -e "\nError : Incorrect Option. Choose a correct backup method."
                        str_loc
                        ;;
                esac
}

bkup_type(){ # Select the type of backup. Full, Incremental and Partial
        echo -e "\nSelect the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
        read bkup_opt
        case $bkup_opt in
                'A' | 'B' | 'C' | 'a' | 'b' | 'c' )
                        if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                        then
                                echo -e "\nSelected Backup Type is FULL."
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
				part_bkup
                        fi
                        ;;
                *)
                        echo -e "\nError : Incorrect Option. Choose a correct backup type."
                        bkup_type
        esac
}


part_bkup(){
	echo -e "Choose an option from below.\n\nA. Backup by Date.\nB. Backup by File type.\nC. Backup by File size(greater than).\nD. Backup by File size(lesser then).\nE. Backup by Owner name.\n\nEnter Option[A/B/C/D/E] : \c"
        read opt
	case $opt in
                'a' | 'A' )
                        echo -e "Backup by date.\n"
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
                        echo -e "Backup by file size greater than.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPS
                        else
                                CPS
                        fi
                        ;;
                'd' | 'D' )
                        echo -e "Backup by file size lesser than.\n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPS
                        else
                                CPS
                        fi
                        ;;
                'e' | 'E' )
                        echo -e "Backup by user name. \n"
			src_loc
			if [ "$strg_type" = 'A' -o "$strg_type" = 'a' ]
                        then
                                LPN
                        else
                                CPN
                        fi
                        ;;
		* )
			echo -e "\nError : Incorrect option."
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
                echo -e "\nError : Path does not exist, try with different path."
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
			sleep 2
                        echo -e "\nLocation verified. . .\n"
                        ;;
                * )
                        echo -e "\nSpecify the destination location again."
                        dest_loc
                        ;;
        esac
        else
                echo -e "\nError : Path does not exist, try with different path.\n\n"
                dest_loc
        fi
}


##Actual functions

LFB(){ #Local full backup
echo -e "\nBackup in progress. . .\n"
cp -rfp $srcpath/ $destpath > bkup.log 2>&1
set `tail -n 2 bkup.log`
echo -e "\nTransfered $2 $3 and\c"
ddsize=`du -sh $destpath`
set $ddsize
echo -e "the disk contains $1 of data.\n\nBackup successfully completed."
}

LIB(){ #Local Incremental Backup
echo -e "Backup in progress. . ."
rsync -aphz --stats $srcpath/ $destpath >bkup.log 2>&1
set `tail -n 2 bkup.log`
echo -e "\nTransfered $2 $3 and \c"
ddsize=`du -sh $destpath`
set $ddsize
echo -e "the disk contains $1 of data.\n\nBackup successfully completed."
}

LPT(){ #Local Partial backup by Time
echo -e "Enter the extension of a file (Example: doc,docx,pdf): \c"
read fext
find $srcpath -type f -iname "*.$fext" > .filelog
set `wc -l .filelog`
echo -e "Total $fext files found $1. Backup is running.\n\n"
find $srcpath -type f -iname "*.$fext" -exec cp -r {} $destpath \;
ddsize=`du -sh $destpath`
set $ddsize
echo -e "the disk contains $1 of data.\n\nBackup successfully completed.\n\n"
}

LPN(){
echo -e "Enter a particular username to begin backup: \c" 
read uname
find $srcpath -user "$uname" -exec cp -r {} $destpath \;ddsize=`du -sh $destpath`
set $ddsize
echo -e "the disk contains $1 of data.\n\nBackup successfully completed.\n\n"
}


LPS(){
 echo -e "\nOK.."

}

LPD(){
 echo -e "\nOK.."

}

CFB(){
 echo -e "\nOK.."

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
