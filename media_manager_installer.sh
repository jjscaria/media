# Media Manager Installation Script for Debian PC
# By: Jithin Scaria
# Email: admin@jjscaria.com
# Download this file: wget

# Download PIA from https://www.privateinternetaccess.com/helpdesk/guides/linux/install-2/linux-systemd-installing-the-pia-app

# Init
sudo apt update && sudo apt upgrade -y

# Repos
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
echo "deb http://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list

sudo apt-get update

# File Downloads



# Core Applications
sudo apt-get install git-core python python-setuptools tzdata filezilla qbittorrent teamviewer -y

# Tautulli
sudo git clone https://github.com/Tautulli/Tautulli.git /opt/Tautulli/
mkdir /opt/TautulliData
sudo chown tautulli:tautulli -R /opt/Tautulli
sudo chown tautulli:tautulli -R /opt/TautulliData
sudo addgroup tautulli && sudo adduser --system --no-create-home tautulli --ingroup tautulli
wget -P /lib/systemd/system/ https://raw.githubusercontent.com/jjscaria/media/master/tautulli.service
wget -P /etc/opt/ https://raw.githubusercontent.com/jjscaria/media/master/config.ini
systemctl daemon-reload
systemctl enable tautulli.service
systemctl start tautulli.service

