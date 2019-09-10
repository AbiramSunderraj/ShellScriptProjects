backup_loc(){
	echo -e "\nSelect storage type.\nA. Local Storage(Device attached to this PC)\nB. Cloud Storage(To another server/storage devices.)"
	echo -e "\nOption[A/B]: \c"
	read strg_type
	case $strg_type in
		'A' | 'a' )
			echo -e "\nEnter device location: \c"
			read dest_loc
			#echo "Source Location is $src_loc"
			echo -e "\nSelected storage type is 'Local Storage'. Device location is '$dest_loc'.Type 'YES' to continue: \c"
			read ans
			case $ans in
				'YES' | 'Yes' | 'yes' )
					echo "Backup Starting. . ."
					rsync -azh $src_loc/ $dest_loc
					#archive and extraction concept
					echo "Backup Finished. . ."
					;;
				* )
					backup_loc
					;;
			esac
			#some command - while writing - rsync and archive | next time - archive and rsync.(rsync && tar)
			;;
		'B' | 'b' )
			echo -e "\nEnter device location: \c"
			read dev_loc
			echo -e "\nSelected storage type is 'Cloud Storage'\nDevice location is '$dev_loc'. Type 'YES' to continue: \c"
			;;
		*)
			echo "\nSelect a valid option."
			;;
		esac
}











type_select(){
	echo -e "\nSelect the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
	read opt
        case $opt in
                'A' | 'B' | 'C' | 'a' | 'b' | 'c' )
                        if [ "$opt" = 'A' -o "$opt" = 'a' ]
                        then
                                echo -e "\nFull Backup Selected, Script is now continuing. . ."
				opt=""
                        elif [ "$opt" = 'B' -o "$opt" = 'b' ]
                        then
                                echo -e "\nIncremental Backup Selected, Script is now continuing. . ."
				opt=""
                        else [ "$opt" = 'C' -o "$opt" = 'c' ]
                                echo -e "\nPartial Backup Selected, Script is now continuing. . ."
				opt=""
                        fi
                        ;;
                *)
                        echo -e "\nIncorrect Option. Select a correct backup type."
			type_select
        esac
}

location_select(){
	echo -e "\nSpecify path to backup: \c"
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
