#!/bin/bash

#Version 1.7
#This script will download between 90 MB and 660 MB's of data depending on your OS.
#Tested on Ubuntu 15.10, Linux Mint 17.2, Arch Linux and Elementary OS Freya.

#Defining variables
os=$(cat /etc/issue | grep '\n' | awk '{print $1,$2}')

#checking os
if [[ $os == "elementary OS" ]]
	then
	echo "Found Elementary OS"
		elif [[ $os == "Linux Mint" ]]
		then
		echo "Found Linux Mint"
			elif [[ $os == "Manjaro Linux" ]]
			then
			echo "Found Manjaro Linux"
				elif [[ $os == "Arch Linux" ]]
				then
				echo "Found Arch Linux"
					else
echo "Found Ubuntu"
fi

if  [[ $os == "Arch Linux" ]]
		then
		echo "Installing programs."
		echo "Please type your password"
		sudo pacman -Syu
		sudo pacman -S wget
		mkdir ~/tmp-packages
		cd ~/tmp-packages
		wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
		tar -xvf package-query.tar.gz
		cd package-query
		makepkg -s
		sudo pacman -U ~/tmp-packages/package-query/package-query*pkg.tar.xz
		cd ..
		wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
		tar -xvf yaourt.tar.gz
		cd yaourt
		makepkg -s
		sudo pacman -U ~/tmp-packages/yaourt/yaourt*pkg.tar.xz
		cd ..
		rm -rf ~/tmp-packages/
		yaourt -Syu
			else
echo "Adding Repositories and installing programs."
echo "Please type your password!"

#adding repo's
sudo add-apt-repository -y ppa:ubuntu-wine/ppa

#Update repo list and current software
sudo apt-get update
sudo apt-get -y dist-upgrade
fi

#install programs
if [[ $os == "elementary OS" ]]
	then
	echo "Installing extra packages to Elementary OS"
	sudo apt-get -y install audacity chromium-browser kazam geany thunderbird vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine pidgin steam asunder deluge libreoffice libreoffice-gtk handbrake wine1.8
		elif [[ $os == "Linux Mint" ]]
		then
		echo "Installing extra packages to Linux Mint"
		sudo apt-get -y install audacity chromium-browser kazam geany conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine steam asunder deluge handbrake wine1.8
				elif [[ $os == "Arch Linux" ]]
				then
				echo "Installing extra packages to Arch Linux"
				sudo pacman -S --noconfirm audacity chromium virtualbox simplescreenrecorder geany audacious conky filezilla easytag youtube-dl clementine asunder deluge wine wine_gecko wine-mono handbrake evince baobab soundconverter vorbis-tools hddtemp gnu-netcat
				yaourt -Sa --noconfirm teamviewer9 pamac-aur dropbox griffith
					else
echo "Installing extra packages to Ubuntu"
sudo apt-get -y install audacity chromium-browser kazam geany compizconfig-settings-manager unity-tweak-tool vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine pidgin steam asunder deluge handbrake wine1.8
fi

#uninstall programs
if [[ $os == "elementary OS" ]]
	then
	echo "Removing unwanted packages from Elementary OS"
	sudo apt-get -y autoremove empathy totem noise scratch-text-editor geary midori-granite
		elif [[ $os == "Linux Mint" ]]
		then
		echo "Removing unwanted packages from Linux Mint"
		sudo apt-get -y autoremove transmission-common transmission-gtk banshee totem firefox
				elif [[ $os == "Arch Linux" ]]
				then
				echo "No unwanted packages on Arch Linux"
					else
echo "Removing unwanted packages from Ubuntu"
sudo apt-get -y autoremove rhythmbox empathy totem transmission-common transmission-gtk firefox
fi

#making temporary download folder
mkdir /tmp/script-files/

#Checking if the computer is a laptop and installing TLP if it is
if [[ $os == "Arch Linux" ]]
		then
		if [ -d /sys/class/power_supply/BAT* ]
			then
			echo "Installing TLP power management"
			sudo pacman -S tlp
				else
			echo "Battery not found. Will not install TLP"
	if [ -d /sys/class/power_supply/BAT* ]
		then
		echo "Installing TLP power management"
		sudo add-apt-repository -y ppa:linrunner/tlp
		sudo apt-get update
		sudo apt-get -y install tlp
		sudo service tlp start
		else
	echo "Battery not found. Will not install TLP"
	fi
fi

	#Checking OS architecture
	if [ $MACHTYPE = x86_64-pc-linux-gnu ]
		then

		#Getting install file for Dropbox 64-bit
		wget -P /tmp/script-files/ https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb

		else
	#Getting install file for Dropbox 32-bit
	wget -P /tmp/script-files/ https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_i386.deb
	fi

	#Installing packages
	sudo dpkg -i /tmp/script-files/*.deb
	sudo apt-get -f -y install
	rm /tmp/script-files/*.deb

fi

#get griffith to work properly
wget -P /tmp/script-files/ https://www.strits.dk/files/validators.py
sudo mv /tmp/script-files/validators.py /usr/share/griffith/lib/db/validators.py

#fix Griffiths Export PDF to create a better PDF
wget -P /tmp/script-files/ https://www.strits.dk/files/PluginExportPDF.py
sudo mv /tmp/script-files/PluginExportPDF.py /usr/share/griffith/lib/plugins/export/PluginExportPDF.py

if [[ $os == "Arch Linux" ]]
	then
	echo " "
	else
		#fix griffiths IMDB plugin
		wget -P /tmp/script-files/ https://www.strits.dk/files/PluginMovieIMDB.py
		sudo mv /tmp/script-files/PluginMovieIMDB.py /usr/share/griffith/lib/plugins/movie/PluginMovieIMDB.py
fi

if [[ $os == "Arch Linux" ]]
	then
	sudo systemctl --system daemon-reload
	sudo systemctl enable hddtemp
	sudo systemctl start hddtemp
	sudo systemctl enable teamviewerd
	sudo systemctl start teamviewerd
	else
#enable DVD playback
sudo /usr/share/doc/libdvdread4/install-css.sh

#enable hddtemp to run as daemon
sudo sed -i 's/RUN_DAEMON="false"/RUN_DAEMON="true"/g' /etc/default/hddtemp
fi

if [ -d /sys/class/power_supply/BAT* ]
	then
	echo "Applying Conky script optimized for laptops."
	wget -P /tmp/script-files/ www.strits.dk/files/backup/conkyrc_laptop
	cp /tmp/script-files/conkyrc_laptop ~/.conkyrc

	else
echo "Applying Conky script for desktop PC."
wget -P /tmp/script-files/ www.strits.dk/files/backup/conkyrc_desktop
cp /tmp/script-files/conkyrc_desktop ~/.conkyrc
fi

#deleting temporary download folder
echo "Cleaning up after script..."
rm -rf /tmp/script-files/

echo "Script completed!"
