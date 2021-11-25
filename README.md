# set-proxysettings

Hello everyone,

here is a small script file with which you can set proxy settings.

First of all, the proxy settings are set in / etc / environment. In order for this to take effect, you must log out and log in. Therefore, please always run the script first if you need proxy settings.

Then the proxy settings for the package manager are stored.
Script works with packet managers: apt, pacman and yum.

How to Install:
1. Download set-proxy-v1.sh to a directory of your choice.
2. Open console
3. Change username in line 182 to your user. *
4. type chmod + x /directory/set-proxy-v1.sh

* If you don't know what your user is, enter "whoami" (without "") in the console.

How to use:
1. Open console
2. type source or bash /directory/set-proxy-v1.sh

The script is written in such a way that it queries everything. Here you have to fill out everything that is needed.

I am grateful for any suggestions for improvement.
I hope you enjoy it. 
