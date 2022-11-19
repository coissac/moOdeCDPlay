#!/bin/bash

echo "Install V-EC2 moOdeCDPlay files in moOde."

# moOdeCDPlay V0.2 script
if [ ! -f /var/www/inc/mpd.php ]; then
    echo
    echo "I'm sorry, Dave, I'm afraid I can't do that."
    echo "In case you didn't notice, this doesn't look like a moOde installation."
    exit 1
fi

sudo apt -y install libcdio-dev \
                    libcdio-utils \
                    python3-musicbrainzngs \
                    python3-cdio \
                    python3-requests \
                    python3-libdiscid \
                    swig 

sudo pip3 install -U python-mpd2

sudo cp addaudiocd.sh /usr/local/bin/addaudiocd.sh
sudo cp remaudiocd.sh /usr/local/bin/remaudiocd.sh
sudo cp moodecdplayer.py /usr/local/bin/moodecdplayer
sudo cp addaudiocd.service /etc/systemd/system/addaudiocd.service
sudo cp remaudiocd.service /etc/systemd/system/remaudiocd.service
sudo cp 99-srX.rules /etc/udev/rules.d/99-srX.rules
sudo chmod +x /usr/local/bin/addaudiocd.sh
sudo chmod +x /usr/local/bin/remaudiocd.sh
sudo chmod +x /usr/local/bin/moodecdplayer

if [[ ! -f /var/www/inc/mpd.php.ori ]] ; then
    sudo cp /var/www/inc/mpd.php /var/www/inc/mpd.php.ori
fi

sudo cp /var/www/inc/mpd.php.ori /var/www/inc/mpd.php
sudo patch /var/www/inc/mpd.php < mpd.php.patch


sudo mkdir -p /var/lib/moode_cd_library/default_cd
sudo cp icon-cd-5.jpg /var/lib/moode_cd_library/default_cd/default_cd.jpg

echo "Done - please reboot moOde to complete installation."
