#!/bin/bash


echo "Adding Repositories and installing programs.
Please type your password!"

#enable username on panel
gsettings set com.canonical.indicator.session show-real-name-on-panel true

#get regular scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal

#stop Nautilus
killall nautilus

#adding repo's
sudo add-apt-repository -y ppa:ubuntu-wine/ppa
#sudo add-apt-repository -y ppa:stebbins/handbrake-releases 
sudo add-apt-repository -y ppa:tualatrix/ppa 
sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder

#Update repo list
sudo apt-get update

#install programs
sudo apt-get -y install audacity simplescreenrecorder compizconfig-settings-manager vlc conky virtualbox unity-tweak-tool griffith filezilla gksu flashplugin-installer ubuntu-restricted-extras clementine pidgin asunder icedtea-7-plugin openjdk-7-jre wine1.7

#not working in Saucy yet
# handbrake-gtk

#uninstall programs
sudo apt-get -y autoremove rhythmbox empathy firefox

#these are disabled to test if they are needed when Ubuntu is installed with 3rd party software.
#gstreamer0.10-plugins-ugly gstreamer0.10-ffmpeg libxine1-ffmpeg gxine mencoder libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321

#Checking OS architecture
if [ $var=x64 ]
then

#Getting install files for Chrome, Steam, Dropbox and Handbrake 64-bit
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb http://media.steampowered.com/client/installer/steam.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb https://launchpad.net/~stebbins/+archive/handbrake-releases/+files/handbrake-gtk_0.9.9ppa1~raring1_amd64.deb

else
#Getting install files for Chrome, Steam, Dropbox and Handbrake 32-bit
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb http://media.steampowered.com/client/installer/steam.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_i386.deb https://launchpad.net/~stebbins/+archive/handbrake-releases/+files/handbrake-gtk_0.9.9ppa1~raring1_i386.deb
fi

#Installing packages
sudo dpkg -i *.deb
sudo apt-get -f -y install
rm *.deb

#get griffith to work properly
wget http://www.strits.dk/files/validators.py
sudo mv validators.py /usr/share/griffith/lib/validators.py

#fix Griffiths Export PDF to create a better PDF
wget http://www.strits.dk/files/PluginExportPDF.py
sudo mv PluginExportPDF.py /usr/shar/griffith/lib/plugins/export/PluginExportPDF.py

#enable DVD playback
sudo /usr/share/doc/libdvdread4/install-css.sh

#remove unwanted lenses
sudo apt-get -y autoremove unity-lens-shopping

#disable guest session
sudo sh -c 'echo "allow-guest=false" >> /etc/lightdm/lightdm.conf'

#start Nautilus again
nautilus &

echo "Programs installed succesfully:
Handbrake (not in saucy yet)
Audacity
Simplescreenrecorder
Compiz
VLC Media Player
Conky
Virtualbox
Unity Tweak Tool
Griffith
Filezilla
Flash Player
Restricted Extras
Clementine
Java Plugin
Chrome
Dropbox
Steam
Wine 1.7
Video and DVD plugins"

echo "Programs uninstalled succesfully:
Rhythmbox
Empathy
Firefox"

#echo "Remember to install Wine1.7, Dropbox and Steam after this installation"
