#!/bin/bash

#Version 1.5
#This script will download between 85 MB and 660 MB's of data depending on your OS.
#Tested on Ubuntu 14.10, Lubuntu 14.10, Xubuntu 14.10, Kubuntu 14.10, Linux Mint 17, Manjaro Linux and Elementary OS Freya.

#Defining variables
os=$(cat /etc/issue | grep '\n' | awk '{print $1,$2}')

#checking os
if [[ "$os" == "elementary OS" ]]
	then
	echo "Found Elementary OS"
		elif [[ "$os" == "Linux Mint" ]]
		then
		echo "Found Linux Mint"
			elif [[ "$os" == "Manjaro Linux" ]]
			then
			echo "Found Manajaro Linux"
				elif [ -d /usr/share/lubuntu ]
				then
				echo "Found Lubuntu"
					elif [ -d /usr/share/xubuntu ]
					then
					echo "Found Xubuntu"
						elif [ -d /usr/share/kubuntu-default-settings ]
						then
						echo "Found Kubuntu"
	else
	echo "Found Ubuntu"
fi

if [[ $os == "Manjaro Linux" ]]
	then
	echo "Installing programs."
	echo "Please type your password!"
	sudo pacman -Syu
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
#There is a bug right now, keeping IcedTea-7-plugin to install properly on 14.10 based OS's.
if [[ $os == "elementary OS" ]]
	then
	echo "Installing extra packages to Elementary OS"
	sudo apt-get -y install audacity firefox kazam geany thunderbird vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine pidgin steam asunder deluge wine1.7 libreoffice libreoffice-gtk handbrake
		elif [[ $os == "Linux Mint" ]]
		then
		echo "Installing extra packages to Linux Mint"
		sudo apt-get -y install audacity kazam geany conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine steam asunder deluge wine1.7 handbrake
			elif [[ $os == "Manjaro Linux" ]]
			then
			echo "Installing extra packages to Manjaro Linux"
			sudo pacman -S --noconfirm audacity apache virtualbox geany conky filezilla easytag youtube-dl clementine asunder deluge wine handbrake evince
			yaourt -S --noconfirm dropbox griffith kazam
				elif [ -d /usr/share/lubuntu ]
				then
				echo "Installing extra packages to Lubuntu"
				sudo apt-get -y install audacity geany kazam thunderbird vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine steam asunder deluge wine1.7 libreoffice libreoffice-gtk handbrake
					elif [ -d /usr/share/xubuntu ]
					then
					echo "Installing extra packages to Xubuntu"
					sudo apt-get -y install audacity kazam geany vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine steam asunder deluge wine1.7 libreoffice libreoffice-gtk handbrake
						elif [ -d /usr/share/kubuntu-default-settings ]
						then
						echo "Installing extra packages to Kubuntu"
						sudo apt-get -y install audacity kazam geany vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine steam asunder deluge handbrake
	else
	echo "Installing extra packages to Ubuntu"
	sudo apt-get -y install audacity kazam geany compizconfig-settings-manager unity-tweak-tool vlc conky virtualbox griffith filezilla gksu flashplugin-installer easytag curl ubuntu-restricted-extras youtube-dl git-gui hddtemp lm-sensors clementine pidgin steam asunder deluge wine1.7 handbrake
fi

#uninstall programs
if [[ $os == "elementary OS" ]]
	then
	echo "Removing unwanted packages from Elementary OS"
	sudo apt-get -y autoremove empathy totem noise scratch-text-editor geary midori-granite
		elif [[ $os == "Linux Mint" ]]
		then
		echo "Removing unwanted packages from Linux Mint"
		sudo apt-get -y autoremove transmission-common transmission-gtk banshee totem 
			elif [[ $os == "Manjaro Linux" ]]
			then
			echo "Removing unwanted packages from Manjaro Linux"
			sudo pacman -Rs --noconfirm gimp xnoise raktpdf
				elif [ -d /usr/share/lubuntu ]
				then
				echo "Removing unwanted packages from Lubuntu"
				sudo apt-get -y autoremove leafpad audacious transmission-common transmission-gtk sylpheed abiword gnumeric gnome-mplayer
					elif [ -d /usr/share/xubuntu ]
					then
					echo "Removing unwanted packages from Xubuntu"
					sudo apt-get -y autoremove transmission-common transmission-gtk gmusicbrowser parole abiword gnumeric mousepad 
						elif [ -d /usr/share/kubuntu-default-settings ]
						then
						echo "Removing inwanted packages from Kubuntu"
						sudo apt-get -y autoremove amarok ktorrent kmail kaddressbook kmix dragonplayer kmousetool kate knotes
	else
	echo "Removing unwanted packages from Ubuntu"
	sudo apt-get -y autoremove rhythmbox empathy totem transmission-common transmission-gtk
fi

#making temporary download folder
mkdir /tmp/script-files/

if [[ $os == "Manjaro Linux" ]]
	then
	echo "Manjaro Linux has Laptop Mode Tools installed by default, so will not install TLP."
	else
	#Checking if the computer is a laptop and installing TLP if it is
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

#Checking OS architecture
	if [ $MACHTYPE = x86_64-pc-linux-gnu ]
		then

		#Getting install file for Dropbox 64-bit
		wget -P /tmp/script-files/ https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.2_amd64.deb

		else
		#Getting install file for Dropbox 32-bit
		wget -P /tmp/script-files/ https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.2_i386.deb
	fi

	#Installing packages
	sudo dpkg -i /tmp/script-files/*.deb
	sudo apt-get -f -y install
	rm /tmp/script-files/*.deb

fi

#get griffith to work properly
wget -P /tmp/script-files/ http://www.strits.dk/files/validators.py
sudo mv /tmp/script-files/validators.py /usr/share/griffith/lib/db/validators.py

#fix Griffiths Export PDF to create a better PDF
wget -P /tmp/script-files/ http://www.strits.dk/files/PluginExportPDF.py
sudo mv /tmp/script-files/PluginExportPDF.py /usr/share/griffith/lib/plugins/export/PluginExportPDF.py

#fix griffiths IMDB plugin
wget -P /tmp/script-files/ http://www.strits.dk/files/PluginMovieIMDB.py
sudo mv /tmp/script-files/PluginMovieIMDB.py /usr/share/griffith/lib/plugins/movie/PluginMovieIMDB.py

if [[ $os == "Manjaro Linux" ]]
	then
	echo "DVD playback is already enabled in Manjaro Linux, remember to setup hddtemp!"
	else
	#enable DVD playback
	sudo /usr/share/doc/libdvdread4/install-css.sh

	#enable hddtemp to run as daemon
	sudo sed -i 's/RUN_DAEMON="false"/RUN_DAEMON="true"/g' /etc/default/hddtemp
fi

#deleting temporary download folder
echo "Cleaning up after script..."
rm -rf /tmp/script-files/
