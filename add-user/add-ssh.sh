#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Rerechan02"

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

echo -e "\e[32mloading...\e[0m"
clear

# // PROVIDED
export creditt=$(cat /root/provided)

# // TEXT ON BOX COLOUR
export box=$(cat /etc/box)

# // LINE COLOUR
export line=$(cat /etc/line)

# // BACKGROUND TEXT COLOUR
export back_text=$(cat /etc/back)

clear
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box CREATE USER SSH & OPENVPN\e[30m ]\e[1m               \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
read -p "   Username : " Login
read -p "   Password : " Pass
read -p "   Expired (days): " masaaktif

IP=$(wget -qO- icanhazip.com);
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi

export ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
export sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
export ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
export ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
export ovpn3="$(cat ~/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2|sed 's/ //g')"
export ovpn4="$(cat ~/log-install.txt | grep -w "OpenVPN SSL" | cut -d: -f2|sed 's/ //g')"
export ohpssh="$(cat ~/log-install.txt | grep -w "OHP SSH" | cut -d: -f2|sed 's/ //g')"
export ohpdrop="$(cat ~/log-install.txt | grep -w "OHP Dropbear" | cut -d: -f2|sed 's/ //g')"
export wsdropbear="$(cat ~/log-install.txt | grep -w "Websocket SSH(HTTP)" | cut -d: -f2|sed 's/ //g')"
export wsstunnel="$(cat ~/log-install.txt | grep -w "Websocket SSL(HTTPS)" | cut -d: -f2|sed 's/ //g')"
export wsovpn="$(cat ~/log-install.txt | grep -w "Websocket OpenVPN" | cut -d: -f2|sed 's/ //g')"

sleep 1
echo Ping Host
echo Check Acces...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Create Acc: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear

# // DATE
export harini=`date -d "0 days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
export exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
export exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`

echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "\e[$back_text         \e[30m[\e[$box Informasi Account SSH & OpenVPN\e[30m ]\e[1m           \e[m"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "Domain           : $domain"
echo -e "Username         : $Login"
echo -e "Password         : $Pass"
echo -e "Expired          : $exp1"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "Dropbear         : 143, 109"
echo -e "OpenSSH          : 22"
echo -e "SSL/TLS          :$ssl"
echo -e "WS SSH(HTTP)     : $wsdropbear"
echo -e "WS SSL(HTTPS)    : $wsstunnel"
echo -e "WS OpenVPN(HTTP) : $wsovpn"
echo -e "OHP Dropbear     : $ohpdrop"
echo -e "OHP OpenSSH      : $ohpssh"
echo -e "OHP OpenVPN      : $ovpn3"
echo -e "Port Squid       :$sqd"
echo -e "Badvpn(UDPGW)    : 7200/7300"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "CONFIG OPENVPN"
echo -e "--------------"
echo -e "OpenVPN TCP : $ovpn http://$domain:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN UDP : $ovpn2 http://$domain:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN SSL : $ovpn4 http://$domain:81/client-tcp-ssl.ovpn"
echo -e "OpenVPN OHP : $ovpn3 http://$domain:81/client-tcp-ohp1194.ovpn"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo ""
