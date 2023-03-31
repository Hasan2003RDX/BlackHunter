#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright ©2018 by RDX_201😈😈. All rights reserved.  🌎 🌍 🌏 🌐 🗺
#
#####################################################################

red='\033[1;31m'
yellow='\033[1;33m'
blue='\033[1;34m'
reset='\033[0m'

    echo " #---------------------------------#"
    echo " #      Coding By RDX_201😈😈      #"
    echo " #---------------------------------#"
pre_cleanup() {
    fine $HOME -name "RDX*" -type d -exec rm -rf {} \; || : 
}

post_cleanup() {
    find $HOME -name "BlackHat*" -type f -exec rm -rf {} \ ; || :
}

setchroot() {
    chroot = full
}

unknownarch() {
    printf "$red"
    echo "[*] Unknown Architecture :("
    printf "$reset"
    exit
}

checksysinfo() {
	printf "$blue [*] Checking host architecture ..."
	case $(getprop ro.product.cpu.abi) in
		arm64-v8a)
			SETARCH=arm64
			;;
		armeabi|armeabi-v7a)
			SETARCH=armhf
			;;
		*)
			unknownarch
			;;
	esac
}

heckdeps() {
	printf "${blue}\n"
	echo " [*] Updating apt cache..."
	apt update -y &> /dev/null
	echo " [*] Checking for all required tools..."

	for i in proot tar axel; do
		if [ -e $PREFIX/bin/$i ]; then
			echo "  • $i is OK"
		else
			echo "Installing ${i}..."
			apt install -y $i || {
				printf "$red"
				echo " ERROR: check your internet connection or apt\n Exiting..."
				printf "$reset"
				exit
			}
		fi
	done
	apt upgrade -y
}

seturl() {
	URL="https://images.kali.org/nethunter/kalifs-${SETARCH}-${chroot}.tar.xz"
}

gettarfile() {
	printf "$blue [*] Getting tar file...$reset\n\n"
	DESTINATION=$HOME/RDX-${SETARCH}
	seturl
    cd $HOME
    rootfs="kalifs-${SETARCH}-${chroot}.tar.xz"
    if [ ! -f "$rootfs" ]; then
        axel ${EXTRAARGS} --alternate "$URL"
    else
        printf "${red}[!] continuing with already downloaded image, if this image is corrupted or half downloaded then delete it manually to download a fresh image.$reset\n\n"
    fi
}

getsha() {
	printf "\n${blue} [*] Getting SHA ... $reset\n\n"
    if [ -f kalifs-${SETARCH}-${chroot}.sha512sum ]; then
        rm kalifs-${SETARCH}-${chroot}.sha512sum
    fi
	axel ${EXTRAARGS} --alternate "https://images.kali.org/nethunter/kalifs-${SETARCH}-${chroot}.sha512sum" -o kalifs-${SETARCH}-${chroot}.sha512sum
}

checkintegrity() {
	printf "\n${blue} [*] Checking integrity of file...\n"
	echo " [*] The script will immediately terminate in case of integrity failure"
	printf ' '
	sha512sum -c kalifs-${SETARCH}-${chroot}.sha512sum || {
		printf "$red Sorry :( to say your downloaded linux file was corrupted or half downloaded, but don't worry, just rerun my script\n${reset}"
		exit 1
	}
}

extract() {
	printf "$blue [*] Extracting... $reset\n\n"
	proot --link2symlink tar -xf $rootfs -C $HOME 2> /dev/null || :
}

createloginfile() {
	bin=${PREFIX}/bin/startkali
	cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/bash -e
unset LD_PRELOAD
if [ ! -f $DESTINATION/root/.version ]; then
    touch $DESTINATION/root/.version
fi
user=RDX
home="/home/\$user"
LOGIN="sudo -u \$user /bin/bash"
if [[ ("\$#" != "0" && ("\$1" == "-r")) ]]; then
    user=BlackHunter
    home=/\$user
    LOGIN="/bin/bash --login"
    shift
fi

cmd="proot \\
    --link2symlink \\
    -0 \\
    -r ${DESTINATION} \\
    -b /dev \\
    -b /proc \\
    -b $DESTINATION\$home:/dev/shm \\
    -b /sdcard \\
    -b $HOME \\
    -w \$home \\
    /usr/bin/env -i \\
    HOME=\$home TERM="\$TERM" \\
    LANG=\$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin \\
    \$LOGIN"

args="\$@"
if [ "\$#" == 0 ]; then
    exec \$cmd
else
    \$cmd -c "\$args"
fi
EOM
	chmod 700 $bin
}

printline() {
	printf "${blue}\n"
	echo " #---------------------------------#"
    echo " #      Coding By RDX_201😈😈      #"
    echo " #---------------------------------#"
}

clear
EXTRAARGS=""
if [[ ! -z $1 ]]; then
    EXTRAARGS=$1
    if [[ $EXTRAARGS != "--insecure" ]]; then
		EXTRAARGS=""
    fi
fi

printf "\n${yellow} You are going to install BlackHunter In Termux Without Root ;) Cool\n\n"

pre_cleanup
checksysinfo
checkdeps
setchroot
gettarfile
getsha
checkintegrity
extract
createloginfile
post_cleanup

printf "$blue [*] Configuring BlackHunter For You ..."

# Utility function for resolv.conf
resolvconf() {
	#create resolv.conf file 
	printf "\nnameserver 8.8.8.8\nnameserver 8.8.4.4" > ${DESTINATION}/etc/resolv.conf
} 
resolvconf

finalwork() {
	[ -e $HOME/finaltouchup.sh ] && rm $HOME/finaltouchup.sh
	echo
	axel -a https://raw.githubusercontent.com/Hasan2003RDX/BlackHunter/master/finaltouchup.sh
	DESTINATION=$DESTINATION SETARCH=$SETARCH bash $HOME/finaltouchup.sh
} 
finalwork

printline
printf "\n${yellow} Now you can enjoy BlackHuter in your Termux :)\n Don't forget to like my hard work for termux and many other things\n"
printline
printline
printf "$blue [*] My official email:${yellow} hasan.rdx.2022@gmail.com\n"
printf "$blue [*] My GitHub:${yellow}		https://github.com/Hasan2003RDX\n"
printf "$blue [*] My WhatsApp:${yellow}	https://wa.me/qr/CSP32ANEJW6ME1\n"
printline
printf "$reset"
    echo " #---------------------------------#"
    echo " #      Coding By RDX_201😈😈      #" 
    echo " #---------------------------------#"
