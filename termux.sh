#!/bin/bash

# Colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
background='\033[0;30;47m'
gray='\033[0;37m'
grayb='\033[5;37m'
rest='\033[0m'

# Check Dependencies build
check_dependencies_build() {
    local dependencies=("curl" "wget" "git" "golang")

    for dep in "${dependencies[@]}"; do
        if ! dpkg -s "${dep}" &> /dev/null; then
            echo -e "${gray}${dep} is not installed. Installing...${rest}"
            pkg install "${dep}" -y
        fi
    done
}

# Check Dependencies
check_dependencies() {
    local dependencies=("curl" "openssl-tool" "wget" "unzip")

    for dep in "${dependencies[@]}"; do
        if ! dpkg -s "${dep}" &> /dev/null; then
            echo -e "${gray}${dep} is not installed. Installing...${rest}"
            pkg install "${dep}" -y
        fi
    done
}

#Installing
install() {
    if command -v warp &> /dev/null || command -v usef &> /dev/null; then
        echo -e "${green}Warp is already installed.${rest}"
        return
    fi

    echo -e "${red}*********************************${rest}"
    echo -e "${gray}Installing Warp...${rest}"
    pkg update -y && pkg upgrade -y
    pacman -Syu openssh = apt update; apt full-upgrade -y; apt install -y openssh
    check_dependencies

    if wget https://github.com/bepass-org/warp-plus/releases/download/v1.2.4/warp-plus_android-arm64.zip &&
        unzip warp-plus_android-arm64.zip &&
        mv warp-plus warp &&
        chmod +x warp &&
        cp warp "$PREFIX/bin/usef" &&
        cp warp "$PREFIX/bin/warp-plus" &&
        cp warp "$PREFIX/bin/warp"; then
        rm "README.md" "LICENSE" "warp-plus_android-arm64.zip"
        echo "================================================"
        echo -e "${green}Warp installed successfully.${rest}"
        socks
    else
        echo -e "${red}Error installing Warp.${rest}"
    fi
}

# Install arm
install_arm() {
    if command -v warp &> /dev/null || command -v usef &> /dev/null; then
        echo -e "${green}Warp is already installed.${rest}"
        return
    fi
    
    echo -e "${red}*********************************${rest}"
    echo -e "${green}Installing Warp...${rest}"
    pkg update -y && pkg upgrade -y
    pacman -Syu openssh = apt update; apt full-upgrade -y; apt install -y openssh
    check_dependencies

    # Determine architecture
    case "$(dpkg --print-architecture)" in
        i386) ARCH="386" ;;
        amd64) ARCH="amd64" ;;
        armhf) ARCH="arm5" ;;
        arm) ARCH="arm7" ;;
        aarch64) ARCH="arm64" ;;
        *) echo -e "${red}Unsupported architecture.${rest}"; return ;;
    esac

    WARP_URL="https://github.com/bepass-org/warp-plus/releases/download/v1.2.4/warp-plus_linux-$ARCH.zip"

    if wget "$WARP_URL" &&
        unzip "warp-plus_linux-$ARCH.zip" &&
        mv warp-plus warp &&
        chmod +x warp &&
        cp warp "$PREFIX/bin/usef" &&
        cp warp "$PREFIX/bin/warp-plus" &&
        cp warp "$PREFIX/bin/warp"; then
        rm "README.md" "LICENSE" "warp-plus_linux-$ARCH.zip"
        echo -e "${red}================================================${rest}"
        echo -e "${red}================================================${rest}"
        echo -e "Warp installed successfully."
        socks
    else
        echo -e "${red}Error installing Warp.${rest}"
    fi
}

# Get socks config
socks() {
   echo ""
   echo -e "${cyan}Copy this Config to ${red}V2ray${green} Or ${red}Nekobox ${cyan}and Exclude Termux${rest}"
   echo ""
   echo -e "${green}socks://Og==@127.0.0.1:8086#warp_(usef)${rest}"
   echo "or"
   echo -e "${green}Manually create a SOCKS configuration with IP ${red}127.0.0.1 ${green}and port${red} 8086..${rest}"
   echo -e "${blue}================================================${rest}"
   echo -e "${cyan}To run again, type:${green} warp ${rest}or${green} usef ${rest}or${green} ./warp ${rest}or${green} warp-plus ${rest}"
   echo -e "${blue}================================================${rest}"
   echo -e "${green} If you get a 'Bad address' error, run ${yellow}[Arm]${rest}"
   echo -e "${blue}================================================${rest}"
   echo -e "${blue}================================================${rest}"
   echo ""
}

# Gool (warp in warp)
gool() {
    if ! command -v warp &> /dev/null || ! command -v usef &> /dev/null; then
        echo -e "${red}*********************************${rest}"
        echo -e "Please install Warp first."
        return
    fi
    
    echo -e "${red}*********************************${rest}"
    echo -e "This option changes your current location to the nearest and best location."
    echo -e "${red}*********************************${rest}"

    while true; do
        echo -e "${green}Choose an option: ${red}*${rest}"
        echo -e "${green}                  *${rest}"
        echo -e "[1] ${gray}IPV4${red}          *${rest}"
        echo -e "[2] ${gray}IPV6${red}          *${rest}"
        echo -e "${red}[3] ${background}Back to Menu${red}  *${rest}"
        echo -e "${red}*******************${rest}"

        echo -en "${background}Please Choose: ${rest}"
        read -r option

        case $option in
            1)
                echo -e "${red}Running Warp with IPV4...${rest}"
                warp --gool -4
                ;;
            2)
                echo -e "${red}Running Warp with IPV6...${rest}"
                warp --gool -6
                ;;
            3)
                echo -e "${background}Back to Menu.${rest}"
                menu
                ;;
            *)
                echo -e "${red}Invalid option.${rest}"
                ;;
        esac
    done
}

# Psiphon
psiphon_location() {
    if ! command -v warp &> /dev/null || ! command -v usef &> /dev/null; then
        echo -e "${red}*********************************${rest}"
        echo -e "Please install Warp first."
        return
    fi
    echo -e "${red}*********************************${rest}"
    echo -e "Please choose a location from the list below by entering its number:"
    echo ""
    echo -e "1)${yellow} Austria (AT)${rest}"
    echo -e "2)${yellow} Australia (AU)${rest}"
    echo -e "3)${yellow} Belgium (BE)${rest}"
    echo -e "4)${yellow} Bulgaria (BG)${rest}"
    echo -e "5)${yellow} Canada (CA)${rest}"
    echo -e "6)${yellow} Switzerland (CH)${rest}"
    echo -e "7)${yellow} Czech Republic (CZ)${rest}"
    echo -e "8)${yellow} Germany (DE)${rest}"
    echo -e "9)${yellow} Denmark (DK)${rest}"
    echo -e "10)${yellow} Estonia (EE)${rest}"
    echo -e "11)${yellow} Spain (ES)${rest}"
    echo -e "12)${yellow} Finland (FI)${rest}"
    echo -e "13)${yellow} France (FR)${rest}"
    echo -e "14)${yellow} United Kingdom (GB)${rest}"
    echo -e "15)${yellow} Hungary (HU)${rest}"
    echo -e "16)${yellow} Ireland (IE)${rest}"
    echo -e "17)${yellow} India (IN)${rest}"
    echo -e "18)${yellow} Italy (IT)${rest}"
    echo -e "19)${yellow} Japan (JP)${rest}"
    echo -e "20)${yellow} Latvia (LV)${rest}"
    echo -e "21)${yellow} Netherlands (NL)${rest}"
    echo -e "22)${yellow} Norway (NO)${rest}"
    echo -e "23)${yellow} Poland (PL)${rest}"
    echo -e "24)${yellow} Romania (RO)${rest}"
    echo -e "25)${yellow} Serbia (RS)${rest}"
    echo -e "26)${yellow} Sweden (SE)${rest}"
    echo -e "27)${yellow} Singapore (SG)${rest}"
    echo -e "28)${yellow} Slovakia (SK)${rest}"
    echo -e "29)${yellow} United States (US)${rest}"
    echo ""

    echo -en "${green}Enter the ${gray}number${green} of the location [${gray}default: 1${green}]: ${rest}"
    read -r choice
    choice=${choice:-1}
    
    case "$choice" in
        1) location="AT" ;;
        2) location="AU" ;;
        3) location="BE" ;;
        4) location="BG" ;;
        5) location="CA" ;;
        6) location="CH" ;;
        7) location="CZ" ;;
        8) location="DE" ;;
        9) location="DK" ;;
        10) location="EE" ;;
        11) location="ES" ;;
        12) location="FI" ;;
        13) location="FR" ;;
        14) location="GB" ;;
        15) location="HU" ;;
        16) location="IE" ;;
        17) location="IN" ;;
        18) location="IT" ;;
        19) location="JP" ;;
        20) location="LV" ;;
        21) location="NL" ;;
        22) location="NO" ;;
        23) location="PL" ;;
        24) location="RO" ;;
        25) location="RS" ;;
        26) location="SE" ;;
        27) location="SG" ;;
        28) location="SK" ;;
        29) location="US" ;;
        *) echo "Invalid choice. Please select a valid location number." ;;
    esac


    echo -e "${red}*********************************${rest}"
    echo -e "Selected location:"
    echo -e "${red}*********************************${rest}"

    while true; do
        echo -e "${red}Choose an option: ${red}*${rest}"
        echo -e "${red}                  *${rest}"
        echo -e "[1] ${green}IPV4${red}          *${rest}"
        echo -e "[2] ${green}IPV6${red}          *${rest}"
        echo -e "[3] ${background}Back to Menu${red}  *${rest}"
        echo -e "${red}*******************${rest}"

        echo -en "${background}Please Choose: ${rest}"
        read -r option

        case $option in
            1)
                echo -e "${green}Running Psiphon with IPV4...${rest}"
                warp --cfon --country $location -4
                ;;
            2)
                echo -e "${green}Running Psiphon with IPV6...${rest}"
                warp --cfon --country $location -6
                ;;
            3)
                echo -e "${background}Back to Menu.${rest}"
                menu
                ;;
            *)
                echo -e "${red}Invalid option.${rest}"
                ;;
        esac
    done    
}

#Uninstall
uninstall() {
    warp="$PREFIX/bin/warp"
    directory="/data/data/com.termux/files/home/warp-plus"
    home="/data/data/com.termux/files/home"
    if [ -f "$warp" ]; then
        rm -rf "$directory" "$PREFIX/bin/usef" "wa.py" "$PREFIX/bin/warp" "$PREFIX/bin/warp-plus" "warp" "/data/data/com.termux/files/home/.cache/warp-plus" > /dev/null 2>&1
        echo -e "${red}*********************************${rest}"
        echo -e "Uninstallation completed.${rest}"
        echo -e "${red}*********************************${rest}"
    else
        echo -e "${red}*********************************${rest}"
        echo -e "${red} Not installed.Please Install First.${rest}${yellow}|"
        echo -e "${red}*********************************${rest}"
    fi
}

# Warp to Warp plus
warp_plus() {
    if ! command -v python &> /dev/null; then
        echo "Installing Python..."
        pkg install python -y
    fi

    echo -e "Downloading and running${red} Warp+ script...${rest}"
    wget -O wa.py https://raw.githubusercontent.com/NiREvil/configs/main/wa.py
    python wa.py
}

# Menu
menu() {
    clear
    echo -e ""
    echo -e "${gray}   Warp-Plus -- 8 august v1.2.4  ${rest}"
    echo ""
    echo -e "${background}    in the name of USEF GHOBADI 💎 ${rest}"
    echo -e "${red}*********************************${rest}"
    echo -e "1- ${green}Install warp${red}                  * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "2- ${green}Install warp [${gray}armeabi-v7a${green}] ${red}   * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "3- ${green}Uninstall${rest}${red}                     * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "4- ${green}gool [${gray}warp ON warp${green}]${red}           * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "5- ${green}psiphon [${gray}+ All Locations${green}]${red}     * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "6- ${green}warp ON ${gray}warp plus${green} [${gray}Free GB${green}]${rest}${red}   * ${rest}"
    echo -e "                              ${red}  * ${rest}"
    echo -e "${red}0-${rest} ${green}Exit                         ${red} * ${rest}"
    echo -e "                               ${red} * ${rest}"
    echo -e "x- ${gray}Revised version by REvil ${red}   *  ${rest}"
    echo -e "${red}*********************************${rest}"
    
    echo -en "${background}Please enter your selection [0-6]:${rest}"
    read -r choice

    case "$choice" in

       1)

            install

            warp

            ;;

        2)

            install_arm

            warp

            ;;

        3)

            uninstall

            ;;

        4)

            gool

            ;;

        5)

            psiphon_location

            ;;

        6)

            warp_plus

            ;;

        0)

            echo -e "${red}*********************************${rest}"

            echo -e "${gray}see you later dude 🖐${rest}"

            exit

            ;;

        *)

            echo -e "${red}*********************************${rest}"

            echo -e "Invalid choice. Please select a valid option.${rest}"

            echo -e "${red}*********************************${rest}"

            ;;

    esac

}

menu
