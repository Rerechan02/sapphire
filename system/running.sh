export red="\e[1;31m"
export green="\e[0;32m"
export NC="\e[0m"

# // GIT USER
export GitUser="Rerechan02"
export MYIP=$(wget -qO- icanhazip.com);

# // VPS INFO
clear
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
    lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
    lan_net="eth0"
    typevps="KVM"
    sleep 1
fi

# // VPS ISP INFORMATION
echo -e "\e[32mloading...\e[0m"
clear
export ITAM='\033[0;30m'
echo -e "$ITAM"
export NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
export REGION=$( curl -s ipinfo.io/region )
export COUNTRY=$( curl -s ipinfo.io/country )
export WAKTU=$( curl -s ipinfo.ip/timezone )
export CITY=$( curl -s ipinfo.io/city )
export REGION=$( curl -s ipinfo.io/region )
export WAKTUE=$( curl -s ipinfo.io/timezone )
export koordinat=$( curl -s ipinfo.io/loc )

# // TOTAL RAM
export tram=$( free -m | awk 'NR==2 {print $2}' )
export uram=$( free -m | awk 'NR==2 {print $3}' )
export fram=$( free -m | awk 'NR==2 {print $4}' )
export swap=$( free -m | awk 'NR==4 {print $2}' )
#link izin ip vps
url_izin='https://raw.githubusercontent.com/Rerechan02/iziznscript/main/ip'

# Mendapatkan IP VPS saat ini
ip_vps=$(curl -s ifconfig.me)

# Mendapatkan isi file izin.txt dari URL
izin=$(curl -s "$url_izin")

# Memeriksa apakah konten izin.txt berhasil didapatkan
if [[ -n "$izin" ]]; then
  while IFS= read -r line; do
    # Memisahkan nama VPS, IP VPS, dan tanggal kadaluwarsa
    nama=$(echo "$line" | awk '{print $1}')
    ipvps=$(echo "$line" | awk '{print $2}')
    tanggal=$(echo "$line" | awk '{print $3}')

    # Memeriksa apakah IP VPS saat ini cocok dengan IP VPS yang ada di izin.txt
    if [[ "$ipvps" == "$ip_vps" ]]; then
      echo "Nama VPS: $nama"
      echo "IP VPS: $ipvps"
      echo "Tanggal Kadaluwarsa: $tanggal"
      break
    fi
  done <<< "$izin"

  # Memeriksa apakah IP VPS ditemukan dalam izin.txt
  if [[ "$ipvps" != "$ip_vps" ]]; then
    echo "IP VPS tidak ditemukan dalam izin.txt"
    exit 0
  fi
else
  echo "Konten izin.txt tidak berhasil didapatkan dari URL"
  exit 0
fi


# // DETAIL ORDER
export username=$(cat /usr/bin/user)
export oid=$(cat /usr/bin/ver)
export exp=$(cat /usr/bin/e)

# // TYPE PROCS
export totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
export totalcore+=" Core"
export corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
export tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# // SHELL VER
export shellversion=""
export shellversion=Bash
export shellversion+=" Version" 
export shellversion+=" ${BASH_VERSION/-*}" 
export versibash=$shellversion

# // OS INFO
source /etc/os-release
export Versi_OS=$VERSION
export ver=$VERSION_ID
export Tipe=$NAME
export URL_SUPPORT=$HOME_URL
export basedong=$ID

# // DOWNLOAD
export download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
export downloadsize=$(($download/1073741824))

# // UPLOAD
export upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
export uploadsize=$(($upload/1073741824))

# // CPU INFO
export cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
export cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
export cpu_usage+=" %"

# // OS UPTIME
export uptime="$(uptime -p | cut -d " " -f 2-10)"

# // KERNEL
export kernelku=$(uname -r)

# // DATE
export harini=`date -d "0 days" +"%d-%m-%Y"`
export jam=`date -d "0 days" +"%X"`

# // DNS PATH
export tipeos2=$(uname -m)

# // DOMAIN
export Domen="$(cat /usr/local/etc/xray/domain)"

echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "Your VPS Information :"
echo -e "\e[0;32mSCRIPT VPS\e[0m"
echo "-----------------------------------------------------------"
echo "Operating System Information :"
echo -e "VPS Type    : $typevps"
echo -e "OS Arch     : $tipeos2"
echo -e "Hostname    : $HOSTNAME"
echo -e "OS Name     : $Tipe"
echo -e "OS Version  : $Versi_OS"
echo -e "OS URL      : $URL_SUPPORT"
echo -e "OS BASE     : $basedong"
echo -e "OS TYPE     : Linux / Unix"
echo -e "Bash Ver    : $versibash"
echo -e "Kernel Ver  : $kernelku"
echo "-----------------------------------------------------------"
echo "Hardware Information :"
echo -e "Processor   : $tipeprosesor"
echo -e "Proc Core   : $totalcore"
echo -e "Virtual     : $typevps"
echo -e "Cpu Usage   : $cpu_usage"
echo "-----------------------------------------------------------"
echo "System Status / System Information :"
echo -e "Uptime      : $uptime ( From VPS Booting )"
echo -e "Total RAM   : $tram MB"
echo -e "Used RAM    : $uram MB"
echo -e "Avaible RAM : $fram MB"
echo -e "Download    : $downloadsize GB ( From Startup/VPS Booting )"
echo -e "Upload      : $uploadsize GB ( From Startup/VPS Booting )"
echo "-----------------------------------------------------------"
echo "Internet Service Provider Information :"
echo -e "Public IP   : $(curl ifconfig.me)"
echo -e "Domain      : $(cat /etc/xray/domain)"
echo -e "NDomain     : $(cat /etc/xray/ndomain)
echo -e "ISP Name    : $(cat /root/.isp)"
echo -e "Region      : $(cat /root/.region)"
echo -e "City        : $(cat /root/.city)"
echo -e "Time Zone   : $WAKTUE"
echo "-----------------------------------------------------------"
echo "Time & Date & Location & Coordinate Information :"
echo -e "Location    : $COUNTRY"
echo -e "Coordinate  : $koordinat"
echo -e "Time Zone   : $WAKTUE"
echo -e "Date        : $harini"
echo -e "Time        : $jam ( WIB )"
echo "-----------------------------------------------------------"
echo -e "\e[1;32mSTATUS SCRIPT :\e[0m"
echo -e "\e[0;34mUser        :\e[0m $nama"
echo -e "\e[0;34mExpired     :\e[0m $tanggal"
echo "-----------------------------------------------------------"
echo -e ""
echo -e "              \e[0;32m[\e[1;36mSYSTEM STATUS INFORMATION\e[0;32m]\e[0m"
echo -e "             \e[0;34m=============================\e[0m"
echo -e ""
echo -e "\e[1;33mSTATUS SSH & OPEN VPN:\e[0m"
echo -e "\e[0;34m-----------------------\e[0m"

status="$(systemctl show ssh.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Open SSH                : "$green"running"$NC" ✓"
else
echo -e " Open SSH                : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show --now openvpn-server@server-tcp-1194 --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OpenVPN TCP             : "$green"running"$NC" ✓"
else
echo -e " OpenVPN TCP             : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show --now openvpn-server@server-udp-2200 --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OpenVPN UDP             : "$green"running"$NC" ✓"
else
echo -e " OpenVPN UDP             : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show stunnel4.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Stunnel(SSL)            : "$green"running"$NC" ✓"
else
echo -e " Stunnel(SSL)            : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show dropbear.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " DropBear                : "$green"running"$NC" ✓"
else
echo -e " DropBear                : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-http.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket SSH(HTTP)     : "$green"running"$NC" ✓"
else
echo -e " Websocket SSH(HTTP)     : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-https.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket SSL(HTTPS)    : "$green"running"$NC" ✓"
else
echo -e " Websocket SSL(HTTPS)    : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ws-ovpn.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Websocket OpenVPN(HTTP) : "$green"running"$NC" ✓"
else
echo -e " Websocket OpenVPN(HTTP) : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohps.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-SSH                 : "$green"running"$NC" ✓"
else
echo -e " OHP-SSH                 : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohpd.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-Dropbear            : "$green"running"$NC" ✓"
else
echo -e " OHP-Dropbear            : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show ohp.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " OHP-OpenVPN             : "$green"running"$NC" ✓"
else
echo -e " OHP-OpenVPN             : "$red"not running (Error)"$NC" "
fi

echo -e ""
echo -e "\e[1;33mSTATUS XRAY:\e[0m"
echo -e "\e[0;34m-------------\e[0m"

status="$(systemctl show xray@vless.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless Ws Tls       : "$green"running"$NC" ✓"
else
echo -e " Xray Vless Ws Tls       : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray@vmess.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess Ws Tls       : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess Ws Tls       : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray@trojan.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan Ws Tls      : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan Ws Tls      : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray@vlessnone.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vless Ws None      : "$green"running"$NC" ✓"
else
echo -e " Xray Vless Ws None      : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray@vmessnone.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Vmess Ws None      : "$green"running"$NC" ✓"
else
echo -e " Xray Vmess Ws None      : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show xray@trojannone.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Xray Trojan Ws None     : "$green"running"$NC" ✓"
else
echo -e " Xray Trojan Ws None     : "$red"not running (Error)"$NC" "
fi

echo -e ""
echo -e "\e[1;33mSTATUS NGINX & SQUID:\e[0m"
echo -e "\e[0;34m--------------------\e[0m"
status="$(systemctl show nginx.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Nginx                   : "$green"running"$NC" ✓"
else
echo -e " Nginx                   : "$red"not running (Error)"$NC" "
fi

status="$(systemctl show squid.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Squid                   : "$green"running"$NC" ✓"
else
echo -e " Squid                   : "$red"not running (Error)"$NC" "
fi

echo -e "\e[0;34m-----------------------------------------------------------\e[0m"
echo -e ""
echo -e "${green}JIKA TERDAPAT NOT RUNNING, PLEASE REPORT TO ADMIN FOR FIX$NC"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
