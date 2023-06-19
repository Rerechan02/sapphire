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
yl='\e[031;1m'
bl='\e[36;1m'
gl='\e[32;1m'
clear
yl='\e[031;1m'
bl='\e[36;1m'
gl='\e[32;1m'
clear
echo ""
figlet " SCRIPT" | lolcat
figlet " BY RERECHAN02" | lolcat
echo -e "\e[32;1m.-----------------------------------------------.\e[0m"
echo -e "\e[32;1m|               \e[36;1mINFO SCRIPT VPS\e[0m                 \e[32;1m|\e[0m"
echo -e "\e[32;1m'-----------------------------------------------'\e[0m"
echo -e "           \e[031;1m> Premium Script By Rerechan02 <\e[0m" | lolcat
echo -e " \e[0;32m_______________________________________________\e[0m"
echo -e "\e[0;32m|    \e[1;35mFor OS Debian 10 & Ubuntu 20.04 64 bit     \e[0;32m|\e[0m"
echo -e "\e[0;32m|  \e[1;35mFor VPS with KVM and VMWare Rerechan02         \e[0;32m|\e[0m"
echo -e "\e[0;32m|               \e[1;35mI HOPE YOU HAPPY                \e[0;32m|\e[0m"
echo -e "\e[0;32m|_______________________________________________\e[0;32m|\e[0m"
echo -e "\e[0;32m|_______________\e[36;1mTHANKYOU SUPPORT\e[0m\e[0;32m________________|\e[0m"
echo -e "               \e[0;32m'----------------'\e[0m"
