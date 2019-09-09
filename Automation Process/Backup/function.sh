type_select(){
	echo -e "Select the type of backup\nA. Full Backup\nB. Incremental Backup\nC. Partial Backup\n\nOption[A/B/C]:\c"
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
                        echo -e "Incorrect Option. Select a correct option [A/B/C]: \c"
			type_select
        esac
}

location_select(){
	echo -e "\nSpecify a path to backup: \c"
	read loc
	echo -e "\nSpecfied path is: '$loc'\nType 'YES' to continue: \c"
	read loc_opt
	case $loc_opt in
		'YES' | 'Yes' | 'yes' )
			echo -e "Backup process continuing. . ."
			;;
		* )
			echo "Incorrect Option. Enter the locatiot
			n once again."
			location_select
			;;
	esac	
}
