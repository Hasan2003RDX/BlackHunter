# BlackHunter-In-Termux
This is a script by which you can install BlackHunter (Linux) in your termux application without rooted phone 

### Steps For Installation
1. Download script in **HOME** `curl -LO https://raw.githubusercontent.com/Hasan2003RDX/BlackHunter/master/BlackHunter`
2. Give execution permission `chmod +x BlackHunter`
3. Run script `./BlackHunter`

### Usage 
1. Use command `startBlackHunter` to start nethunter. Default user is __BlackHunter__ and default password is also __kali__.
2. if you want to start nethunter as a root user then use command `startBlackHunter -r`.

### VNC Guide
1. To start a vnc session `vnc start`
2. To stop a vnc session `vnc stop`
3. To check status ( Display and port number) of vnc session `vnc status`
4. If user is __BlackHunter__ then by default `vnc start` will start vncserver with `DISPLAY=:2` & `PORT=5902` and for root user `DISPLAY=:1` & `PORT=5901`


### In Case Of SSL error: certificate verify failed
Rerun script with extra parameter `--insecure` or copy paste this command `./BlackHunter --insecure`
