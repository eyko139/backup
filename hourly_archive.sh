#!/bin/bash

##### Hourly Tar archives ######
################################


#Setting config file

config_file=/home/s/biblestuff/files_to_backup_hourly

#Base destination

basedir=/home/s/biblestuff/archive/

#Gather time

year=$(date +%Y)
month=$(date +%b)
time=$(date +%0k:%M)
day=$(date +%d)

#creating the necesarry directories

mkdir -p $basedir/$year/hourly/$month/$day

#creating archive destination

destination=$basedir$year/hourly/$month/$day/archive$time.tar.gz

######Archiving (equivalent to daily_archive.sh) ##########
###########################################################

if [ -f $config_file ]
then
  echo
else
  echo "$config_file does not exist."
  echo "Backup failed due to missing config file"
  echo "Exiting..."
  exit
fi

#Build the files that are to be backed up

file_no=1
exec 0< $config_file
read file_name

while [ $? -eq 0 ]
do
  if [ -f $file_name -o -d $file_name ]
  then
    file_list="$file_list $file_name"
  else
    echo "$file_name does not exist, check the config file or the directory"
    echo "Continuing to build archive"
  fi
  file_no=$[$file_no + 1]
  read file_name
done

printf "\nBuilding archive\n"

tar -czf $destination $file_list 2> /dev/null

printf "Success, the resulting archive is: $destination\n"
exit
