#!/bin/bash
####################
#Fecha: 01/2/2022  #
#Devel: @WOLI0101  #
####################
barra="⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊\e[0m"

# r="/usr/local/protec/rip" && [[ ! -d ${r} ]] && exit
 r >/dev/null 2>&1
 #20/2/2022
 clear
# SCPdir="/etc/VPS-MX"
#SCPdir="/etc/VPSManager"
# SCPfrm="${SCPdir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
# SCPinst="${SCPdir}/wsproxy.py"&& [[ ! -d ${SCPinst} ]] && exit
 declare -A cor=( [0]="\\033[1;37m" [1]="\\033[1;34m" [2]="\\033[1;31m" [3]="\\033[1;33m" [4]="\\033[1;32m" [5]="\\e[1;36m" )
 
 mportas () {
 unset portas
 portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
 while read port; do
 var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
 [[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\\n"
 done <<< "$portas_var"
 i=1
 echo -e "$portas"
 }
 
 fun_bar () {
 comando="$1"
  _=$(
 $comando > /dev/null 2>&1
 ) & > /dev/null
 pid=$!
 while [[ -d /proc/$pid ]]; do
 echo -ne " \\033[1;33m["
    for((i=0; i<20; i++)); do
    echo -ne "\\033[1;31m##"
    sleep 0.5
    done
 echo -ne "\\033[1;33m]"
 sleep 1s
 echo
 tput cuu1
 tput dl1
 done
 echo -e " \\033[1;33m[\\033[1;31m########################################\\033[1;33m] - \\033[1;32m100%\\033[0m"
 sleep 1s
 }
 
 ssl_stunel () {
 [[ $(mportas|grep stunnel4|head -1) ]] && {
 echo -e "\\033[1;33m  Deteniendo Stunnel"
 echo -e $barra
 service stunnel4 stop > /dev/null 2>&1
 rm -rf /etc/stunnel/stunnel.conf
 apt-get purge stunnel4 -y &>/dev/null && echo -e "\\e[31m DETENIENDO SERVICIO SSL" #| pv -qL10
 apt-get purge stunnel4 &>/dev/null
 apt-get remove stunnel4 &>/dev/null
 echo -e $barra
 echo -e "\\033[1;33m "Detenido Con Exito!""
echo -e $barra
 return 0
 }
 clear
 echo -e $barra
 echo -e "\\033[1;33m   Seleccione una puerta de redirección interna."
 echo -e "\\033[1;33m   "Un puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON""
 echo -e $barra
          while true; do
          echo -ne "\\033[1;37m"
          read -p " Puerto Local: " redir
 		 echo ""
          if [[ ! -z $redir ]]; then
              if [[ $(echo $redir|grep [0-9]) ]]; then
                 [[ $(mportas|grep $redir|head -1) ]] && break || echo -e "\\033[1;31m $(fun_trans  "Puerto Invalido")"
              fi
          fi
          done
 echo -e $barra
 DPORT="$(mportas|grep $redir|awk '{print $2}'|head -1)"
 echo -e "\\033[1;33m  "Ahora Que Puerto sera SSL""
 echo -e $barra
     while true; do
 	echo -ne "\\033[1;37m"
     read -p " Puerto SSL: " SSLPORT
 	echo ""
     [[ $(mportas|grep -w "$SSLPORT") ]] || break
     echo -e "\\033[1;33m Esta puerta está en uso"
     unset SSLPORT
     done
 echo -e $barra
 echo -e "\\033[1;32m    Instalando SSL..."
 echo -e $barra
 fun_bar "apt-get install stunnel4 -y"
 apt-get install stunnel4 -y > /dev/null 2>&1
 echo -e "client = no\\n[SSL]\\ncert = /etc/stunnel/stunnel.pem\\naccept = ${SSLPORT}\\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
 ####Coreccion2.0##### 
 openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1
 
 (echo "bo" ; echo "bo" ; echo "Speed" ; echo "@VPS~BO" ; echo "@TestS_BO_VPSs" ; echo "@WOLI0101" ; echo "@VPS~BO" )|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1
 
 cat stunnel.crt stunnel.key > stunnel.pem 
 
 mv stunnel.pem /etc/stunnel/
 ######-------
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel4 restart > /dev/null 2>&1
echo -e $barra
 echo -e "\033[0;37m  INSTALADO CON EXITO"
 echo -e $barra
sleep 1s
 rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
 rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
 rm -rf /root/stunnel.crt > /dev/null 2>&1
 rm -rf /root/stunnel.key > /dev/null 2>&1
 return 0
 }
# SPR &
 ssl_stunel_2 () {
 echo -e "\\033[1;32m              AGREGAR MAS PUERTOS SSL"
 echo -e $barra
 echo -e "\\033[1;33m   Seleccione una puerta de redirección Interna."
 echo -e "\\033[1;33m   Un Puerto SSH/DROPBEAR/SQUID/OPENVPN/SSL"
 echo -e $barra
          while true; do
          echo -ne "\\033[1;37m"
          read -p " Puerto-Local: " portx
 		 echo ""
          if [[ ! -z $portx ]]; then
              if [[ $(echo $portx|grep [0-9]) ]]; then
                 [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\\033[1;31m $(fun_trans  "Puerto Invalido")"
              fi
          fi
          done
 echo -e $barra
 DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
 echo -e "\033[1;33m Ahora Que Puerto sera SSL"
 echo -e $barra
     while true; do
 	echo -ne "\033[1;37m"
     read -p " Listen-SSL: " SSLPORT
 	echo ""
     [[ $(mportas|grep -w "$SSLPORT") ]] || break
     echo -e "\\033[1;33m $(fun_trans  "Esta puerta está en uso")"
     unset SSLPORT
     done
 echo -e $barra
 echo -e "\\033[1;32m    Instalando SSL..."
 echo -e $barra
 fun_bar "apt-get install stunnel4 -y"
 echo -e "client = no\\n[SSL+]\\ncert = /etc/stunnel/stunnel.pem\\naccept = ${SSLPORT}\\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf
 ######-------
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel4 restart > /dev/null 2>&1
 echo -e $barra
 echo -e "\033[0;37m            INSTALADO CON EXITO"
 echo -e $barra
 rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
 rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
 rm -rf /root/stunnel.crt > /dev/null 2>&1
 rm -rf /root/stunnel.key > /dev/null 2>&1
 return 0
 }
 sslpython(){
echo -e $barra
 echo -e "\\033[1;37mSe Requiere tener el puerto 80 y el 443 libres"
echo -e $barra
 sleep 2
 install_python(){ 
  apt-get install python -y &>/dev/null && echo -e "\\033[1;97m Activando Python Direct ► 80\\n"
  sleep 2 
  screen -dmS pydic-80 python /etc/VPSManager/wsproxy.py 80 "VPSManager" && echo "80 VPSManager" >> /etc/VPSManager/PySSL.log
 #echo -e $barra
  }
  
  install_ssl(){  
  apt-get install stunnel4 -y &>/dev/null && echo -e "\\033[1;97m Activando Servicios SSL ► 443\\n" #| pv -qL 12
  sleep 2
  apt-get install stunnel4 -y > /dev/null 2>&1 
  echo -e "client = no\\n[SSL]\\ncert = /etc/stunnel/stunnel.pem\\naccept = 443\\nconnect = 127.0.0.1:80" > /etc/stunnel/stunnel.conf 
  openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1 
  (echo mx; echo bo; echo bo; echo speed; echo internet; echo conectedmx; echo @conectedmx)|openssl req -new -key stunnel.key -x509 -days 1095 -out stunnel.crt > /dev/null 2>&1
  cat stunnel.crt stunnel.key > stunnel.pem   
  mv stunnel.pem /etc/stunnel/ 
  ######------- 
  sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
  service stunnel4 restart > /dev/null 2>&1  
  rm -rf /root/stunnel.crt > /dev/null 2>&1 
  rm -rf /root/stunnel.key > /dev/null 2>&1 
  } 
 install_python 
 install_ssl 
echo -e $barra
 echo -e "${cor[4]}              INSTALACION COMPLETA"
echo -e $barra
 }
 
 unistall(){
 clear
echo -e $barra
 echo -e " DETENIENDO SERVICIOS SSL Y PYTHON"
echo -e $barra
 service stunnel4 stop > /dev/null 2>&1
 apt-get purge stunnel4 -y &>/dev/null
 apt-get purge stunnel -y &>/dev/null
 kill -9 $(ps aux |grep -v grep |grep -w "wsproxy.py"|grep dmS|awk '{print $2}') &>/dev/null
 rm /etc/VPSManager/PySSL.log &>/dev/null
 clear
echo -e $barra
 echo -e "LOS SERVICIOS SE HAN DETENIDO"
echo -e $barra
sleep 2
 }
 
 #
 certif(){
 [[ $(mportas|grep stunnel4|head -1) ]] && {
 echo -e "\\033[1;33m   Deteniendo Stunnel"
 echo -e $barra
 service stunnel4 stop > /dev/null 2>&1
 apt-get purge stunnel4 -y &>/dev/null && echo -e "\\e[31m DETENIENDO SERVICIO SSL" | pv -qL10
 apt-get remove stunnel4 &>/dev/null
 rm -rf /etc/stunnel/stunnel.conf
 rm -rf /etc/stunnel/private.key
 rm -rf /etc/stunnel/certificate.crt
 rm -rf /etc/stunnel/ca_bundle.crt
 echo -e $barra
 echo -e "\\033[1;33m Detenido Con Exito!"
 echo -e $barra
 return 0
 }
 clear
 echo -e $barra
 echo -e "\\033[1;33m   Seleccione una puerta de redirección interna."
 echo -e "\\033[1;33m   Un Puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON"
 echo -e $barra
          while true; do
          echo -ne "\\033[1;37m"
          read -p " Puerto Local: " redir
 		 echo ""
          if [[ ! -z $redir ]]; then
              if [[ $(echo $redir|grep [0-9]) ]]; then
                 [[ $(mportas|grep $redir|head -1) ]] && break || echo -e "\\033[1;31m $(fun_trans  "Puerto Invalido")"
              fi
          fi
          done
 echo -e $barra
 DPORT="$(mportas|grep $redir|awk '{print $2}'|head -1)"
 echo -e "\\033[1;33m   Ahora Que Puerto sera SSL"
 echo -e $barra
     while true; do
 	echo -ne "\\033[1;37m"
     read -p " Puerto SSL: " SSLPORT
 	echo ""
     [[ $(mportas|grep -w "$SSLPORT") ]] || break
     echo -e "\\033[1;33m $(fun_trans  "Esta puerta está en uso")"
     unset SSLPORT
     done
 echo -e $barra
 echo -e "\033[0;31m       Instalando SSL..."
 echo -e $barra
 apt-get install stunnel4 -y &>/dev/null && echo -e "\\e[32m INSTALANDO SSL" | pv -qL10
 clear
 echo -e "client = no\\n[SSL]\\ncert = /etc/stunnel/stunnel.pem\\naccept = ${SSLPORT}\\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
 echo -e $barra
 echo -e "\\e[1;37m ACONTINUACION ES TENER LISTO EL LINK DEL CERTIFICADO.zip\\n VERIFICAR CERTIFICADO EN ZEROSSL, DESCARGALO Y SUBELO\\n EN TU GITHUB O DROPBOX"
 echo -e $barra
 read -p "enter para seguir..."
 clear
 ####Cerrificado ssl/tls#####
 msg -bar
 echo -e "\\e[1;33m👇 LINK DEL CERTIFICADO.zip 👇           \\n \\e[0m"
 echo -e "\\e[1;36m LINK \\e[37m: \\e[34m\\c "
 #extraer certificado.zip
 read linkd
 wget $linkd &>/dev/null -O /etc/stunnel/certificado.zip
 cd /etc/stunnel/
 unzip certificado.zip &>/dev/null
 cat private.key certificate.crt ca_bundle.crt > stunnel.pem
 rm -rf certificado.zip
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel restart > /dev/null 2>&1
 service stunnel4 restart &>/dev/null
 msg -bar
 echo -e "${cor[4]} CERTIFICADO INSTALADO CON EXITO \\e[0m" 
 msg -bar
 }
 
 certificadom(){
 if [ -f /etc/stunnel/stunnel.conf ]; then
 insapa2(){
 for pid in $(pgrep python);do
 kill $pid
 done
 for pid in $(pgrep apache2);do
 kill $pid
 done
 service dropbear stop
 apt install apache2 -y
 echo "Listen 80
 
 <IfModule ssl_module>
         Listen 443
 </IfModule>
 
 <IfModule mod_gnutls.c>
         Listen 443
 </IfModule> " > /etc/apache2/ports.conf
 service apache2 restart
 }
 clear
 echo -e $barra
 insapa2 &>/dev/null && echo -e " \\e[1;33mAGREGANDO RECURSOS " | pv -qL 10
 echo -e $barra
 echo -e "\\e[1;37m Verificar dominio \\e[0m"
 echo -e $barra
 read -p " LLAVE: " keyy
 echo -e $barra
 read -p " DATOS: " dat2w
 mkdir -p /var/www/html/.well-known/pki-validation/
 datfr1=$(echo "$dat2w"|awk '{print $1}')
 datfr2=$(echo "$dat2w"|awk '{print $2}')
 datfr3=$(echo "$dat2w"|awk '{print $3}')
 echo -ne "${datfr1}\\n${datfr2}\\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt
 echo -e $barra
 echo -e "\\e[1;37m VERIFIQUE EN LA PÁGINA ZEROSSL \\e[0m"
 echo -e $barra
 read -p " ENTER PARA CONTINUAR"
 clear
 echo -e "=============================================="
 echo -e "\\e[1;33m👇 LINK DEL CERTIFICADO 👇\\n \\e[0m"
 echo -e "\\e[1;36m LINK \\e[37m: \\e[34m\\c"
 read link
 incertis(){
 wget $link -O /etc/stunnel/certificado.zip
 cd /etc/stunnel/
 unzip certificado.zip 
 cat private.key certificate.crt ca_bundle.crt > stunnel.pem
 service stunnel restart &>/dev/null
 service stunnel4 restart &>/dev/null
 }
 incertis &>/dev/null && echo -e " \\e[1;33mEXTRAYENDO CERTIFICADO " | pv -qL 10
 echo -e $barra
 echo -e "${cor[4]} CERTIFICADO INSTALADO \\e[0m" 
 echo -e $barra
 
 for pid in $(pgrep apache2);do
 kill $pid
 done
 apt install apache2 -y &>/dev/null
 echo "Listen 81
 
 <IfModule ssl_module>
         Listen 443
 </IfModule>
 
 <IfModule mod_gnutls.c>
         Listen 443
 </IfModule> " > /etc/apache2/ports.conf
 service apache2 restart &>/dev/null
 service dropbear start &>/dev/null
 service dropbear restart &>/dev/null
 for port in $(cat /etc/VPS-MX/PortPD.log| grep -v "nobody" |cut -d' ' -f1)
 do
 PIDVRF3="$(ps aux|grep pydic-"$port" |grep -v grep|awk '{print $2}')"
 if [[ -z $PIDVRF3 ]]; then
 screen -dmS pydic-"$port" python /etc/VPS-MX/protocolos/PDirect.py "$port"
 else
 for pid in $(echo $PIDVRF3); do
 echo ""
 done
 fi
 done
 else
 msg -bar
 echo -e "${cor[3]} SSL/TLS NO INSTALADO \\e[0m"
 msg -bar
 fi
 }
 
 
 clear
 if netstat -tnlp |grep 'stunnel4' &>/dev/null; then
 stunel="\\e[32m[ON]"
 else
 stunel="\\e[31m[OFF]"
 fi
echo -e $barra
echo -e $barra
 echo -e "${cor[3]}        INSTALADOR MULTI SSL"
 echo -e $barra
 echo -e "${cor[1]}      Escoja la opcion deseada."
echo -e $barra
 echo -e "${cor[4]} 1).-\\033[1;37m INICIAR || DETENER SSL $stunel"
 echo -e "${cor[4]} 2).-\\033[1;37m AGREGAR + PUERTOS SSL"
echo -e $barra
 echo -e "${cor[4]} 3).-\\033[1;37m INICIAR SSL+PYTHON DIRECTO\\e[0m"
 echo -e "${cor[4]} 4).-\\033[1;37m DETENER SERVICIO SSL+PYTHON\\e[0m"
echo -e $barra
 echo -e "${cor[4]} 5).-\\033[1;37m CERTIFICADO SSL/TLS\\e[0m"
 echo -e "${cor[4]} 0).-\\033[1;37m VOLVER A CONEXIONES\\e[0m"
 echo -e $barra
 echo -ne "\\033[1;37mDIGITE UN NÚMERO [0/5]: "
 read opcao
 case $opcao in
 1)
 echo -e $barra
 ssl_stunel
 ;;
 2)
 echo -e $barra
 ssl_stunel_2
 sleep 3
 exit
 ;;
 3)
 sslpython
 exit
 ;;
 4) unistall
 ;;
 5)
 clear
 echo -e $barra
 echo -e  "	CERTIFICADO"
 echo -e $barra
 echo -e "${cor[4]} 1).-\\033[1;37m CERTIFICADO WEB ZIP "
 echo -e "${cor[4]} 2).-\\033[1;37m CERTIFICADO MANUAL ZEROSSL   "
echo -e $barra
 echo -ne "\\033[1;37mSELECCIONE UN NÚMERO [0/2]: "
 read opc
 case $opc in
 1)
 certif
 exit
 ;;
 2)
 certificadom
 exit
 ;;
 esac
 ;;
 esac 
 
