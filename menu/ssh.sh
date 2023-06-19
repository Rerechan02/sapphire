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
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m       • SSH & OVPN MENU •         \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " [\e[36m•01\e[0m] Buat Akun SSH & OpenVPN "
echo -e " [\e[36m•02\e[0m] Akun Trial SSH & OpenVPN "
echo -e " [\e[36m•03\e[0m] Perpanjang Akun SSH & OpenVPN "
echo -e " [\e[36m•04\e[0m] Hapus SSH & OpenVPN Account "
echo -e " [\e[36m•05\e[0m] Periksa Login Pengguna SSH & OpenVPN "
echo -e " [\e[36m•06\e[0m] Daftar Anggota SSH & OpenVPN "
echo -e " [\e[36m•07\e[0m] Hapus Pengguna Kedaluwarsa SSH & OpenVPN "
echo -e " [\e[36m•08\e[0m] Siapkan Autokill SSH "
echo -e " [\e[36m•09\e[0m] Cek Pengguna yang Melakukan Multi Login SSH "
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mKEMBALI KE MENU\033[0m"
echo -e ""
echo -e   "Press x or [ Ctrl+C ] • Untuk-Keluar"
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Please Input Number  [1-9 or x] :  "  ssh
echo -e ""
case $ssh in
1)
add-ssh
;;
2)
trial
;;
3)
renew-ssh
;;
4)
del-ssh
;;
5)
cek-ssh
;;
6)
member
;;
7)
delete
;;
8)
autokill
;;
9)
ceklim
;;
10)
user-list
;;
11)
user-lock
;;
12)
user-unlock
;;
13)
user-password
;;
14)
restart
;;
x)
exit
;;
0)
menu
;;
*)
ssh
;;
echo "Please enter an correct number"
;;
esac