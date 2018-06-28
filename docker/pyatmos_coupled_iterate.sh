#!/bin/bash

temp_path='PHOTOCHEM/INPUTFILES/TEMPLATES/'
temp_path2='CLIMA/IO/TEMPLATES/'
temp_path3='CLIMA/IO/'

# clear
# echo "This script imports PHOTOCHEM & CLIMA templates from a template file."
# echo "You will need to be in your top folder for atmos, not a subfolder."
# echo "Your current folder is $(pwd)."
# echo "Your PHOTOCHEM has these templates:"
# ls $temp_path
true_path=$(pwd)
# echo -n "Enter the folder title (NOT THE PATH) and press [ENTER]: "
# read folder

folder='ModernEarth'

folder_path=$temp_path$folder
folder_path2=$temp_path2$folder

# Enable coupling between photochem and clima in the photochem input
perl -pi -e 's/ICOUPLE=   0/ICOUPLE=   1/g' PHOTOCHEM/INPUTFILES/input_photchem.dat

# cd $folder_path
# cp 'in.dist' '../../..' && echo "Copied in.dist from $(pwd ../../..)"
# cp 'input_photchem.dat' '../..' && echo "Copied input_photchem.dat from $(pwd ../..)"
# cp 'reactions.rx' '../..' && echo "Copied reactions.rx from $(pwd ../..)"
# cp 'parameters.inc' '../..' && echo "Copied parameters.inc from $(pwd ../..)"
# cp 'species.dat' '../..' && echo "Copied species.dat from $(pwd ../..)"
# cp 'PLANET.dat' '../..' && echo "Copied PLANET.dat from $(pwd ../..)"
# echo 'Finished copying photochem templates over'
# cd $true_path
# pwd

# echo -e '\n'
# echo -n 'Would you like to compile PHOTOCHEM (y/n)?:'
 # read recompile
recompile='y'
  if [ "$recompile" == "y" -o "$recompile" == 'Y' ]
   then
       make '-f' 'PhotoMake' 'clean'
       make '-f' 'PhotoMake'
  fi
# echo -e '\n'
# echo -n 'Would you like to run PHOTOCHEM (y/n)?:'
  # read run_photo
run_photo='y'
  if [ "$run_photo" == "y" -o "$run_photo" == 'Y' ]
   then
       ./'Photo.run'
  fi
# echo -e '\n'
# echo -n 'Would you like to recompile CLIMA (y/n)?:'
# read recompile
recompile='y'
 if [ "$recompile" == "y" -o "$recompile" == 'Y' ]
 then
     make '-f' 'ClimaMake' 'clean'
     make '-f' 'ClimaMake'
 fi
# echo -e '\n'
# echo -n 'Would you like to run CLIMA (y/n)?:'
# read run_clima
run_clima='y'
if [ "$run_clima" == "y" -o "$run_clima" == 'Y' ]
then
    cd $true_path
    echo "folder path is $folder_path2"
    if [ -d "$folder_path2" ]; then
	cd $folder_path2
	echo "folder path is now $(pwd)"
	cp 'input_clima.dat' '../..' && echo "Copied input_clima.dat from $(pwd)"
	if [ "$run_photo" == "n" -o "$run_photo" == 'N' ]
	then
         echo "NOTE: You did not run photo but you want to run Clima. Copying stored Clima coupling files."
         cp 'coupling_params.out' '../../../../COUPLE/' && echo "Copied coupling_params.out from $(pwd)"
         cp 'fromPhoto2Clima.dat' '../../../../COUPLE/' && echo "Copied fromPhoto2Clima.dat from $(pwd)"
         cp 'hcaer.photoout.out' '../../../../COUPLE/' && echo "Copied hcaer.photoout.out from $(pwd)"
         cp 'mixing_ratios.dat' '../../../../COUPLE/' && echo "Copied mixing_ratios.dat from $(pwd)"
         cp 'time_frak_photo.out' '../../../../COUPLE/' && echo "Copied time_frak_photo.out from $(pwd)"
	fi
    fi


        cd $true_path
    if [ ! -d "$folder_path2" ]; then
	echo "folder path is now $(pwd)"
	cd $temp_path3
	echo "!!WARNING!!: no clima template exists for $folder. Copying GENERIC version."
	echo "This will *probably* cause problems for you. Check the file manually to see if you want the options set in it."
	cp 'DEFAULT_input_clima.dat' 'input_clima.dat' && echo "Copied GENERIC input_clima.dat to  $(pwd ../..)"
    fi
    #cp 'mixing_ratios.dat' '../../../../COUPLE/' && echo "Copied mixing_ratios.dat $(pwd ../../../../COUPLE/)"
    #cp 'mixing_ratios.dat' '../..' && echo "Copied mixing_ratios.dat $(pwd ../..)"
    #cp 'time_frak_photo.out' '../../../../COUPLE/' && echo "Copied time_frak_photo.out to $(pwd ../../../../COUPLE/)"
    #cp 'hcaer.photoout.out' '../../../../COUPLE/' && echo "Copied hcaer.photoout.out to $(pwd ../../../../COUPLE/)"
    echo 'Finished copying clima templates over'
    cd $true_path
    pwd

  ./'Clima.run'
fi
