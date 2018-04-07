# Formatting
printf '\e[8;24;118t'
clear

# Help function for usability and syntax
Help()
{
	echo "Usage: bash backup [-f OR -d] [Source Location] [Backup Location]";
	echo "Example: bash backup -f /home/user/Desktop/kitten.jpg /home/billy/Pictures/SecretStash/"
	echo
	echo "-f                     Single File Backup";
	echo "-d                     Directory(folder) Backup";
	echo "[Source Location]      Location of file/folder you want to backup";
	echo "[Backup Location]      Location where you want the backup to go";
}

# Second Parameter Checks

#SecondParam()
#{
#	
#}

# Simple echo based menu
Menu()
{
	# Menu
	echo "                              =========================================================";
	echo "                                                         MENU";
	echo "                              =========================================================";
	echo "                                         ===================================";
	echo "                                                   SELECT AN OPTION";
	echo "                                         ===================================";
	echo;
	echo;
	echo "                                       1. Create backup of a file.";
	echo "                                       2. Create backup of a directory(folder)";
	echo "                                       3. Exit";
}

# Loop to check for correct input - then runs chosen protocol
UserChoice()
{
	while true; do
	read -p "Choose an option then press ENTER: " choice
	case $choice in

		# File Backup Protcol
		[1]* ) clear;
			echo "                              =========================================================";
			echo "                                                      FILE BACKUP";
			echo "                              =========================================================";
			echo;
			echo;
			# Select source file
			echo "Please choose a file to backup.";
			echo;
			fileLocation=$(zenity --file-selection --filename=$HOME/);
			# echo "You chose $fileLocation";

			# Select destination location
			echo "Please choose the backup destination.";
			echo;
			destFileLocation=$(zenity --file-selection --directory --filename=$HOME/);

			# Select a name for the backup
			echo "Finally choose a name for the backup file.";
			read backUpFileName;
			combinedFile=$destFileLocation/$backUpFileName;
			cp "$fileLocation" "$combinedFile";
			echo "Copying...";

			# Check if worked
			if [ -f "$combinedFile" ]
			then
				echo -e "\e[1;92m";
				echo "                              =========================================================";
				echo "                                                       SUCCESS";
				echo "                              =========================================================";
				echo -e "\e[0m";
				Sleep;
				clear;
				Menu;
				UserChoice;
			else
				echo -e "\e[1;91m";
				echo "                              =========================================================";
				echo "                                          "SOMETHING WENT WRONG" - MICROSOFT";
				echo "                              =========================================================";
				echo -e "\e[0m";
				Sleep;
				clear;
				Menu;
				UserChoice;
			fi

			break;;

		# Directory Backup Protocol
		[2]* ) clear;
			echo "                              =========================================================";
			echo "                                                      FILE BACKUP";
			echo "                              =========================================================";
			echo;
			echo;
			# Select source file
			echo "Please choose a file to backup.";
			echo;
			folderLocation=$(zenity --file-selection --directory --filename=$HOME/);
			# echo "You chose $fileLocation";

			# Select destination location
			echo "Please choose the backup destination.";
			echo;
			destFolderLocation=$(zenity --file-selection --directory --filename=$HOME/);

			# Select a name for the backup
			echo "Finally choose a name for the backup file.";
			read backUpFolderName;
			combinedFolder=$destFolderLocation/$backUpFolderName;
			cp -r "$folderLocation" "$combinedFolder";
			echo "Copying...";

			# Check if worked
			if [ -d "$combinedFolder" ]
			then
				echo -e "\e[1;92m";
				echo "                              =========================================================";
				echo "                                                       SUCCESS";
				echo "                              =========================================================";
				echo -e "\e[0m";
				Sleep;
				clear;
				Menu;
				UserChoice;
			else
				echo -e "\e[1;91m";
				echo "                              =========================================================";
				echo "                                          "SOMETHING WENT WRONG" - MICROSOFT";
				echo "                              =========================================================";
				echo -e "\e[0m";
				Sleep;
				clear;
				Menu;
				UserChoice;
			fi

			break;;

		[3]* ) exit;;

		* ) echo "Please enter either 1, 2 or 3 and press ENTER";;
	esac
	done
}

Sleep()
{
	echo "Going back to main menu in: "
	secs=$((1 * 5))
		while [ $secs -gt 0 ]; do
   		echo -ne "$secs\033[0K\r"
   		sleep 1
   		: $((secs--))
	done
}

# Checks for Parameters for quick backups
case $1 in

	[]* )
		Menu;
	;;
	[help]* )
		Help;
	;;
	[-help]* )
		Help;
	;;
	[-f]* )
		secondParamFile=$2;
		thirdParamFile=$3;
		SecondParamFile;
		ThirdParamFile;
	;;
	[-d]* )
		secondParamFolder=$2;
		thirdParamFolder=$3;
		SecondParamFolder;
		ThirdParamFolder;
	;;

esac

# Executes Functions
Menu
UserChoice
