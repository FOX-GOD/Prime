#!/bin/bash
#============================================#
#  Autor Script con Key: @WOLI1001 (WOLI L.) #
#  Fecha: 01/2/2022                           #
#============================================#
clear
[[ "$(whoami)" != "root" ]] && {
echo -e "\033[1;33m[\033[1;31mErro\033[1;33m] \033[1;37m- \033[1;33mvocê precisa executar como root\033[0m"
rm $HOME/Plus > /dev/null 2>&1; exit 0
}
_lnk='SEU-IP-AKI'; _Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig'); _1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')
cd $HOME
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<22; i++)); do
   echo -ne "\033[1;31mx"
   sleep 0.2s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
function verif_key () {
krm=$(echo '5:q-3gs2.o7%8:1'|rev); chmod +x $_Ink/list > /dev/null 2>&1
[[ ! -e "$_Ink/list" ]] && {
  echo -e "\n\033[1;31mKEY INVÁLIDA!\033[0m"
  rm -rf $HOME/Plus.sh > /dev/null 2>&1
  sleep 2
  clear; exit 1
}
}

echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7; tput setab 4; tput bold; printf '%40s%s%-12s\n' "_BIEN VENIDO A ADM WOLI_  " ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "            \033[1;31mATENCION! \033[1;33mESTE SCRIPT IRA A !\033[0m"
echo ""
echo -e "\033[1;31m• \033[1;33mINSTALAR UN CONJUNTO DE SCRIPTS COMO HERRAMIENTAS\033[0m" 
echo -e "\033[1;33m  PARA LA GESTION DE REDES , SISTEMAS Y USUARIOS!\033[0m"
echo ""
echo -e "\033[1;32m• \033[1;32mTIP! \033[1;33mULTILIZE UN TEMA DARK EN SU TERMINAL PARA\033[0m"
echo -e "\033[1;33m  UNA MEJOR EXPERIENCIA Y VISUALIZACION DEL MISMO!\033[0m"
echo ""
echo -e "\033[1;31m≠×≠×≠×≠×≠×≠×≠×≠×[\033[1;33m • \033[1;32mBy @WOLI0101\033[1;33m •\033[1;31m ]≠×≠×≠×≠×≠×≠×≠×≠×\033[0m"
echo ""
echo -ne "\033[1;36mINGRESE SU KEY:\033[1;37m "; read key
_lnk2=$(echo "$key"|awk -F : '{print $2}'); _lnk1=$(echo "$key"|awk -F : '{print $1}')
echo -e "\n\033[1;36mVERIFICANDO... \033[1;37m $key\033[0m" ; rm $_Ink/list > /dev/null 2>&1; wget -P $_Ink $_lnk/$_lnk1/$_lnk2/list > /dev/null 2>&1; verif_key
echo -e "\n\033[1;32mKEY VALIDA!\033[1;32m"
sleep 2s
echo "/bin/menu" > /bin/adm-woli && chmod +x /bin/adm-woli > /dev/null 2>&1
rm versao* > /dev/null 2>&1
wget https://raw.githubusercontent.com/FOX-GOD/Prime/main/Install/versao > /dev/null 2>&1
> /dev/null 2>&1
#wget https://iplogger.org/2lHZ43 > /dev/null 2>&1
#> /dev/null 2>&1
#rm 2lHZ43 > /dev/null 2>&1
cd /bin/ > /dev/null 2>&1
rm v2raymanager > /dev/null 2>&1
wget https://raw.githubusercontent.com/FOX-GOD/Prime/main/Modulos/v2raymanager > /dev/null 2>&1
chmod +x v2raymanager > /dev/null 2>&1
#-----------------------------------------------------------------------------------------------------------------
#echo -e "\n\033[1;32mKEY VALIDA!\033[1;32m"
sleep 1s
echo ""
[[ -f "$HOME/usuarios.db" ]] && {
clear
echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
echo ""
echo -e "                 \033[1;33m• \033[1;31mATENCION \033[1;33m• \033[0m"
echo ""
echo -e "\033[1;33mUna base de Datos de Usuários \033[1;32m(usuarios.db) "
echo -e "\033[1;33mFue Encontrada !"
echo -e "¿Quieres mantenerlo mientras preservas el límite "
echo -e "de Usuarios Conexiones Simultáneas? O Quiere"
echo -e "crear una nueva base de datos ?\033[0m"
echo -e "\n\033[1;37m[\033[1;31m1\033[1;37m] \033[1;33mManter Base de Dados Actual\033[0m"
echo -e "\033[1;37m[\033[1;31m2\033[1;37m] \033[1;33mCrear una Nueva Base de Datos\033[0m"
echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
echo ""
tput setaf 2 ; tput bold ; read -p "Opción : " -e -i 1 optiondb ; tput sgr0
} || {
awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
}
[[ "$optiondb" = '2' ]] && awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' "  AGUARDE LA INSTALACION" ; tput sgr0
echo ""
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mACTUALIZANDO SISTEMA \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
echo ""
echo -e "    \033[1;33mLAS ACTUALIZACIONES SUELEN DEMORAR UN POCO!\033[0m"
echo ""
fun_attlist () {
apt-get update -y
[[ ! -d /usr/share/.plus ]] && mkdir /usr/share/.plus
echo "crz: $(date)" > /usr/share/.plus/.plus
}
fun_bar 'fun_attlist'
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' "  AGUARDE LA INSTALACION" ; tput sgr0
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mINSTALANDO PAQUETES \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "\033[1;33mALGUNOS PAQUETES SON EXTREMADAMENTE NECESARIOS !\033[0m"
echo ""
inst_pct () {
_pacotes=("bc" "screen" "nano" "unzip" "lsof" "netstat" "net-tools" "dos2unix" "nload" "jq" "curl" "figlet" "python" "python3" "python-pip" "lolcat")
for _prog in ${_pacotes[@]}; do
apt install $_prog -y
done
pip install speedtest-cli
}
fun_bar 'inst_pct'
[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' "  AGUARDE LA INSTALACION" ; tput sgr0
echo ""
echo -e "        \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mFINALIZANDO INSTALACION \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "      \033[1;33mCONCLUYENDO FUNCIONES Y DEFINICIONES! \033[0m"
echo ""
fun_bar "$_Ink/list $_lnk $_Ink $_1nk $key"
clear
echo ""
cd $HOME
echo -e "        \033[1;33m • \033[1;32mINSTALACION COMPLETA\033[1;33m • \033[0m"
echo ""
echo -e "\033[1;31m \033[1;33mCOMANDO PRINCIPAL: \033[0;31mmenu ¤ adm-woli\033[0m"
echo -e " \033[1;33mMAS INFORMACIÓN \033[1;31m(\033[1;34mTELEGRAM\033[1;31m): \033[1;36m@TestS_BO_VPSs\033[0m "
rm $HOME/Plus.sh && cat /dev/null > ~/.bash_history && history -c
#fin
