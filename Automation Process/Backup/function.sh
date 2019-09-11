type_select(){ # Select the type of backup. Full, Incremental and Partial
        echo -e "\nSelect the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
        read bkup_opt
        case $bkup_opt in
                'A' | 'B' | 'C' | 'a' | 'b' | 'c' )
                        if [ "$bkup_opt" = 'A' -o "$bkup_opt" = 'a' ]
                        then
                                echo -e "\nFull Backup Selected. . ."
                                opt=""
                        elif [ "$bkup_opt" = 'B' -o "$bkup_opt" = 'b' ]
                        then
                                echo -e "\nIncremental Backup Selected. . ."
                                opt=""
                        else [ "$bkup_opt" = 'C' -o "$bkup_opt" = 'c' ]
                                echo -e "\nPartial Backup Selected. . ."
                                opt=""
                        fi
                        ;;
                *)
                        echo -e "\nIncorrect Option. Select a correct backup type."
                        type_select
        esac
}

################## Actual backup functions ####################

lfbkup(){ #Local Full backup, Just copying everything to local drive.
	echo -e "Backup in progress. . ."
        cp -rfp $src_loc/ $dest_loc
        #archive and extraction concept
	size=`du -sh $dest_loc`
	set "$size"
        echo -e "Backup process completed. . .\nBackedup $1 files to the destination folder."
}

libkup(){ #Local Incremental backup, Sync'ing the files in the folders  using rsync
        echo -e "Backup in progress. . ."
        #rsync
        echo -e "Backup process completed. . .\n"
}

lpbkup(){ #Local Partial backup, Selected type of contents and as by date last accessed or modified using amc-time
        echo -e "Backup in progress. . ."
        #only the type of contents or date modified.
        echo -e "Backup process completed. . .\n"
}


cfbkup(){ #Cloud Full backup, Just copying everything to local drive.
        echo -e "Backup in progress. . ."
        cp -rfp $src_loc/ $dest_loc
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
	case $strg_type in
		'A' | 'a' )
			echo -e "\nEnter device location: \c"
			read dest_loc
			echo -e "\nSelected storage type is 'Local Storage'. Device location is '$dest_loc'.\nThis method overwrites the previous duplicate files. Type 'YES' to continue: \c"
			read ans
			case $ans in
				'YES' | 'Yes' | 'yes' )
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
					echo -e "\nWrong Input\n"
					backup_loc
					;;
			esac
			;;

		'B' | 'b' )
			echo -e "\nEnter device location: \c"
                        read dest_loc
                        echo -e "\nSelected storage type is 'Local Storage'. Device location is '$dest_loc'.\nThis method overwrites the previous duplicate files. Type 'YES' to continue: \c"
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
			echo "\nSelect a valid option."
			;;
		esac
}

location_select(){ ##Source path selection to take backup.
	echo -e "\nSpecify source path: \c"
	read src_loc
	ls $src_loc >>/dev/null 2>&1
	if [ "$?" -eq 0 ]
	then
	echo -e "\nSpecfied path is: '$src_loc'\nType 'YES' to continue or press any key to re-specify the location again: \c"
	read loc_opt
	case $loc_opt in
		'YES' | 'Yes' | 'yes' )
			echo -e "Backup process continuing. . ."
			backup_loc
			;;
		* )
			echo -e "\nSpecify the location again."	
			location_select
			;;
	esac
	else
		echo -e "\nPath does not exist or Root privilages required. Specify the correct path or run with root privilages."
		location_select
	fi
}
