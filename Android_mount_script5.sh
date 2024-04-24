#!/bin/bash
echo "This script will mount yors Android phone using go-mtpfs."
echo " Firstly install go-mtpfs, MTP protocol, then make dir called AndroidDevice in yours /home/user_name catalog."
IsGomtpfsPresent=$(which go-mtpfs &>/dev/null; echo $?)
if ! [ "$IsGomtpfsPresent" == '0' ]
    then
    echo -e "Go-mtpfs not installed. Please, install it for using this script. We will install it."
    sudo apt-get update
    sudo apt-get install go-mtpfs
fi
IsGomtpfsPresent=$(which go-mtpfs &>/dev/null; echo $?)
if ! [ "$IsGomtpfsPresent" == '1' ]
    then
    echo -e "Go-mtpfs installed successfully."
    else
    echo -e "Go-mtpfs is not installed, installed install it manually."
fi

if [ -d $HOME/AndroidDevice ]
    then
    ANS=A
    echo "Mount point exist."
    else
    echo "Make dir AndroidDevice in your home catalog? [Y]es/[N]o" 
    read ANS
fi
    
if [[ $ANS == "Y" || $ANS == "y" || $ANS == "Yes" || $ANS == "yes" ]] 
        then 
            mkdir $HOME/AndroidDevice
            echo "Mount point is created." 
fi

if [[ $ANS == "N" || $ANS == "n" || $ANS == "No" || $ANS == "no" ]] 
        then 
            echo -e "We do not create mount point."
        exit 2
fi

go-mtpfs ~/AndroidDevice & 
# Note: If go-mtpfs is not ran in the background (with & at the end), another console will be needed to browse the device and unmount the device (when finished).
echo "Device is mounted." 
echo "Do you wish unmount it? Yes=press Y key"
read B
fusermount -u ~/AndroidDevice
echo " Unmount is Ok."
# When the device is unmount, go-mtpfs will quit. 
exit 3