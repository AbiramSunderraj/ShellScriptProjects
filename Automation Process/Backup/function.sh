type_select(){ # Select the type of backup. Full, Incremental and Partial
        echo -e "\nSelect the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
        read bkup_opt
        case $bkup_opt in
                'A' | 'B' | 'C' | 'a' | 'b' | 'c' )
                        if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                        then
                                echo -e "\nSelected Backup Type: FULL"
                                opt=""
				backup_loc				
                        elif [ "$bkup_opt" = 'B' -o "$bkup_opt" = 'b' ]
                        then
                                echo -e "\n Selected Backup Type: INCREMENTAL"
                                opt=""
				backup_loc
                        else [ "$bkup_opt" = 'C' -o "$bkup_opt" = 'c' ]
                                echo -e "\nSelected Backup Type: PARTIAL"
                                opt=""
				backup_loc
                        fi
                        ;;
                *)
                        echo -e "\nError : Incorrect Option. Select a correct backup type."
                        type_select
        esac
}

#################### Actual backup functions ####################

lfbkup(){ #Local Full backup, Just copying everything to local drive.
	echo -e "\nBackup in progress. . .\n"
        cp -rfp $srcpath/ $destpath >> bkup.log 2&>1
	set `tail -n 2 bkup.log`
        echo -e "\nTransfered $2 $3 and the\c"
        ddsize=`du -sh $destpath`
        set $ddsize
        echo -e "The disk contains $1 of data.\n\nBye Bye.\n"

}

libkup(){ #Local Incremental backup, Sync'ing the files in the folders using rsync by last modified and accessed time
        echo -e "Backup in progress. . ."
        rsync -aphz --stats $srcpath/ $destpath >> bkup.log  2>&1
	set `tail -n 2 bkup.log`
        echo -e "\nTransfered $2 $3 and the\c"
	ddsize=`du -sh $destpath`
	set $ddsize
	echo -e "The disk contains $1 of data.\n\nBye Bye.\n"
}

pbkup(){
	#depending upon time and depending upon file type.
	echo -e "Select an otpion from below.\n\nA. Backup by Date.\nB. Backup by File type.\nC. Backup by File size(greater than).\nD. Backup by File size(lesser then).\nE. Backup by Owner name.\n\nEnter Option[A/B/C/D/E] : \c"
	read opt
	case $opt in 
		'a' | 'A' | 'b' | 'B' | 'c' | 'C' | 'd' | 'D' | 'e' | 'E' )
			echo -e "Type 'OK' to continue: \c"
			read copt
				if [ "$copt" = "OK" -o "$copt" = "ok" -o "$copt" = "Ok" ]
				then
					case $opt in
						'a' | 'A' )
							echo -e "Backup by date.\n"
							;;
						'b' | 'B' )
							echo -e "Backup by file type.\n"
							;;
						'c' | 'C' )
							echo -e "Backup by file size greater than.\n"
							;;
						'd' | 'D' )
							echo -e "Backup by file size lesser than.\n"
							;;
						'e' | 'E' )
							echo -e "Backup by Owner name. \n"
							;;
					esac
				else
					echo "\nSelect a valid option."
					pbkup
				fi
			;
		* )
			echo -e "\nError : Select a valid option.\n"
			pbkup
			;;
	esac
}



lpbkup(){ #Local Partial backup, Selected type of contents and as by date last accessed or modified using amc-time
        echo -e "Backup in progress. . ."
	pbkup
        #partial backup, depends up on time and file type
	cp $srcloc/*.sh $destloc
}


cfbkup(){ #Cloud Full backup, Just copying everything to local drive.
        echo -e "Backup in progress. . ."
        cp -rfp $srcpath/ $destpath
        #archive and extraction concept
        echo -e "Backup process completed. . .\n"
}

cibkup(){ #Cloud Incremental backup, Sync'ing the files in the folders using rsync
        echo -e "Backup in progress. . ."
        #rsync
        echo -e "Backup process completed. . .\n"
}

cpbkup(){ #Cloud Partial backup, Selected type of contents and as by date last accessed or modified using amc-time
        echo -e "Backup in progress. . ."
        #only the type of contents or date modified.
        echo -e "Backup process completed. . .\n"
}


backup_loc(){  ##Backup location selection, Local or cloud.
	echo -e "\nSelect storage type.\nA. Local Storage(Device attached to this PC)\nB. Cloud Storage(To another server/storage devices.)"
	echo -e "\nOption[A/B]: \c"
	read strg_type
	srcloc
	destloc
	case $strg_type in
		'A' | 'a' )
			echo -e "\nSelected storage type is 'Local Storage'.\nSource location is '$srcpath'\nDestination location is '$destpath'.\n\nType 'OK' and press Enter: \c"
			read ans
			case $ans in
				'OK' | 'Ok' | 'ok' )
					if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                        		then
						lfbkup
                        		elif [ "$bkup_opt" = 'B' -o "$bkup_opt" = 'b' ]
                        		then
						libkup
                                	else [ "$bkup_opt" = 'C' -o "$bkup_opt" = 'c' ]
						lpbkup
                        		fi
					;;
				* )
					echo -e "\nError : Wrong Input\n"
					backup_loc
					;;
			esac
			;;

		'B' | 'b' )
			echo -e "\nEnter device location: \c"
                        read destpath
                        echo -e "\nSelected storage type is 'LOCAL STORAGE'. Device location is '$destpath'.\nType 'YES' to continue: \c"
                        read ans
                        case $ans in
                                'YES' | 'Yes' | 'yes' )
                                        if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                                        then
                                                cfbkup
                                        elif [ "$bkup_opt" = 'B' -o "$bkup_opt" = 'b' ]
                                        then
                                                cibkup
                                        else [ "$bkup_opt" = 'C' -o "$bkup_opt" = 'c' ] 
                                                cpbkup
                                        fi
                                        ;;
                                * )
                                        backup_loc
                                        ;;
                        esac
                        ;;
		*)
			echo -e "\nSelect a valid option."
			backup_loc
			;;
		esac
}

srcloc(){ ##Source path selection to take backup.
	echo -e "\nSpecify source path: \c"
	read srcpath
	ls $srcpath >>/dev/null 2>&1
	if [ "$?" -eq 0 ]
	then
		echo -e "\nSource path is: '$srcpath'\nType 'YES' to continue or press any key to re-specify the location again: \c"
	read loc_opt
	case $loc_opt in
		'YES' | 'Yes' | 'yes' )
			echo -e "\nSpecify Destination Path: \c"
			;;
		* )
			echo -e "\nSpecify the location again."	
			srcloc
			;;
	esac
	else
		echo -e "\nError : Path does not exist, try with different path."
		srcloc
	fi
}


destloc(){
        read destpath
        ls $destpath >>/dev/null 2>&1
        if [ "$?" -eq 0 ]
        then
                echo -e "\nDestintion path is: '$destpath'\nType 'YES' to continue or press any key to re-specify the location again: \c"
        read loc_opt
        case $loc_opt in
                'YES' | 'Yes' | 'yes' )
                        echo -e "\nOK . . ."
                        ;;
                * )
                        echo -e "\nSpecify the location again."
			destloc
                        ;;
        esac
        else
                echo -e "\nError : Path does not exist, try with different path.\n\nSpecfiy destination path again: \c"
                destloc
        fi
}














#PTR

#1. Implement path checking for destination location.
#2. Implement previous records saving.(can think about array and later pass the datas to pssql.)
#3. 
