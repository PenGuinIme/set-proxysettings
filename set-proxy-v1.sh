#!/usr/bin/ bash
# Sets proxy settings.
# Run using `source` command. apt-get proxy settings requires sudo privileges.

#Query
read -s -n 1 -p"Proxy y/n:
" response
if [ "$response" == "y" ];

then
echo -n "Host: "
read PROXY_HOST
echo -n "Port: "
read PROXY_PORT

#For Proxys with Login
read -s -n 1 -p"With Login for Proxy y/n:
" response
if [ "$response" == "y" ];

then
echo -n "Username: "
read PROXY_USER
echo -n "Password: "
read -s PROXY_PASSWORD

PROXY_STRING_LOGIN="\"http://$PROXY_USER:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT/\""

#Set environment variables
env_conf_proxy_login="
http_proxy=$PROXY_STRING_LOGIN
HTTP_PROXY=$PROXY_STRING_LOGIN
https_proxy=$PROXY_STRING_LOGIN
HTTPS_PROXY=$PROXY_STRING_LOGIN
ftp_proxy=$PROXY_STRING_LOGIN
FTP_PROXY=$PROXY_STRING_LOGIN
socks_proxy=$PROXY_STRING_LOGIN
SOCKS_PROXY=$PROXY_STRING_LOGIN
all_proxy=$PROXY_STRING_LOGIN
ALL_PROXY=$PROXY_STRING_LOGIN
"
echo "$env_conf_proxy_login" | sudo tee /etc/environment > /dev/null

elif [ "$response" == "n" ];
then
PROXY_STRING_ENVIRONMENT="\"http://$PROXY_HOST:$PROXY_PORT/\""

#Set environment variables
env_conf_proxy="
http_proxy=$PROXY_STRING_ENVIRONMENT
HTTP_PROXY=$PROXY_STRING_ENVIRONMENT
https_proxy=$PROXY_STRING_ENVIRONMENT
HTTPS_PROXY=$PROXY_STRING_ENVIRONMENT
ftp_proxy=$PROXY_STRING_ENVIRONMENT
FTP_PROXY=$PROXY_STRING_ENVIRONMENT
socks_proxy=$PROXY_STRING_ENVIRONMENT
SOCKS_PROXY=$PROXY_STRING_ENVIRONMENT
all_proxy=$PROXY_STRING_ENVIRONMENT
ALL_PROXY=$PROXY_STRING_ENVIRONMENT
"
echo "$env_conf_proxy" | sudo tee /etc/environment > /dev/null
fi

#Select PackageManager
read -s -n 1 -p"With PackageManager y/n:
" response
if [ "$response" == "y" ];
then
#For APT PackageManager
read -s -n 1 -p"APT y/n:
" response
if [ "$response" == "y" ];
then

PROXY_STRING_PKG="http://$PROXY_HOST:$PROXY_PORT/"
NO_PROXY_STRING_PKG=" "

#Set apt proxy settings
apt_conf_proxy="
Acquire::http::Proxy $PROXY_STRING_PKG;
Acquire::https::Proxy $PROXY_STRING_PKG;
Acquire::ftp::Proxy $PROXY_STRING_PKG;
"
echo "$apt_conf_proxy" | sudo tee /etc/apt/apt.conf > /dev/null
echo "Proxy enabled."

elif [ "$response" == "n" ];
then
#For Pacman PackageManager
read -s -n 1 -p "Pacman y/n:
" response
if [ "$response" == "y" ];
then
#Set Pacman proxy settings
sed -i -e 22c"XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u" /etc/pacman.conf
echo "Proxy enabled."

elif [ "$response" == "n" ];
then
#For YUM PackageManager
read -s -n 1 -p "YUM y/n:
" response
if [ "$response" == "y" ];
then
#Set yum proxy settings
yum_conf_proxy="
proxy=http://$PROXY_STRING_PKG
proxy_username=$PROXY_USER
proxy_password=$PROXY_PASSWORD
"
echo "$rpm_conf_proxy" | sudo tee /etc/yum.conf > /dev/null
echo "Proxy enabled."
fi
fi
fi

elif [ "$response" == "n" ];
then
#Set no apt proxy settings
apt_conf_proxy="
$NO_PROXY_STRING_PKG
$NO_PROXY_STRING_PKG
$NO_PROXY_STRING_PKG
"
echo "$apt_conf_proxy" | sudo tee /etc/apt/apt.conf > /dev/null
echo "Proxy for PackageManager not aktivated."
fi

elif [ "$response" == "n" ];
then
NO_PROXY_STRING_ENVIRONMEN=" "
NO_PROXY_STRING_PKG=" "
#Set environment variables for no Proxy
no_proxy="
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
$NO_PROXY_STRING_ENVIRONMEN
"
echo "$no_proxy" | sudo tee /etc/environment > /dev/null

#For set off Proxy for APT PackageManager
read -s -n 1 -p"APT y/n:
" response
if [ "$response" == "y" ];
then
apt_conf_proxy="
$NO_PROXY_STRING_PKG
$NO_PROXY_STRING_PKG
$NO_PROXY_STRING_PKG
"
echo "$apt_conf_proxy" | sudo tee /etc/apt/apt.conf > /dev/null
echo "Proxy disabled."

elif [ "$response" == "n" ];
then
#For set off Proxy for YUM PackageManager
read -s -n 1 -p "YUM y/n:
" response
if [ "$response" == "y" ];
then
#Set yum proxy settings
yum_conf_proxy="
"
echo "$rpm_conf_proxy" | sudo tee /etc/yum.conf > /dev/null
echo "Proxy disabled."
fi
fi
fi

#Logout Command
read -s -n 1 -p"Log out is required please press: \"q\" for cancel pres: \"crlt+c\"
" response
if [ "$response" == "q" ];
then
echo "Logout" | sudo pkill -u username
fi
