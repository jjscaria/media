# Media Manager Installation Script for Debian PC
# By: Jithin Scaria
# Email: admin@jjscaria.com
# Download this file: wget https://raw.githubusercontent.com/jjscaria/media/master/media_manager_installer.sh

# Download PIA from https://www.privateinternetaccess.com/helpdesk/guides/linux/install-2/linux-systemd-installing-the-pia-app

# Init
sudo apt update && sudo apt upgrade -y

# Repos
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
echo "deb http://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt-get update

# Core Applications
sudo apt-get install git-core python python-setuptools tzdata jq filezilla qbittorrent teamviewer -y

# Tautulli - http://localhost:8181
sudo git clone https://github.com/Tautulli/Tautulli.git /opt/Tautulli/
sudo mkdir /opt/TautulliData
sudo chown tautulli:tautulli -R /opt/Tautulli
sudo chown tautulli:tautulli -R /opt/TautulliData
sudo addgroup tautulli && sudo adduser --system --no-create-home tautulli --ingroup tautulli
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/jjscaria/media/master/tautulli.service
wget -P /etc/opt/ https://raw.githubusercontent.com/jjscaria/media/master/config.ini
sudo systemctl daemon-reload
sudo systemctl enable tautulli.service
sudo systemctl start tautulli.service

# Radarr - http://localhost:7878
sudo apt install mono-devel curl mediainfo
curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
tar -xvzf Radarr.develop.*.linux.tar.gz
mv Radarr /opt
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/jjscaria/media/master/radarr.service
sudo systemctl daemon-reload
sudo systemctl enable tautulli.service
sudo systemctl start tautulli.service
rm -f *.gz

# Sonarr - http://localhost:8989
sudo apt install nzbdrone
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/jjscaria/media/master/sonarr.service
sudo systemctl daemon-reload
sudo systemctl enable tautulli.service
sudo systemctl start tautulli.service

# Jackett - http://localhost:9117
jackettver=$(curl https://api.github.com/repos/Jackett/Jackett/releases/latest -s | jq .name -r)
wget https://github.com/Jackett/Jackett/releases/download/$jackettver/Jackett.Binaries.LinuxAMDx64.tar.gz
tar -xvf Jackett*
sudo ./Jackett/install_service_systemd.sh
rm -f *.gz

# Files
wget -P ~/.config/qBittorrent/ https://raw.githubusercontent.com/jjscaria/media/master/qBittorrent.conf
wget -P ~/.config/filezilla/ https://raw.githubusercontent.com/jjscaria/media/master/filezilla.xml
wget -P ~/.config/filezilla/ https://raw.githubusercontent.com/jjscaria/media/master/sitemanager.xml
wget -P ~/.config/filezilla/ https://raw.githubusercontent.com/jjscaria/media/master/trustedcerts.xml
wget https://raw.githubusercontent.com/jjscaria/media/master/bookmarks.json
