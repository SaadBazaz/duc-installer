#!/bin/bash

#    Instalattion and uninstallation script for No-IP2 written by Rafael Cunha

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>

# Tested on Ubuntu 12.04. Suit to other distributions
# or versions in case it is not according your requirements.
# For running this script type ./duc.sh in the directory
# that script was saved.


#    Este programa é um software livre: você pode redistribuí-lo 
#    e/ou modificá-lo sob os termos da GNU General Public License 
#    publicada pela Free Software Foundation, na versão 3 da 
#    licença, ou (por sua opção) qualquer versão posterior.

#    Este programa é distribuído na esperança de ser útil,
#    mas SEM NENHUMA GARANTIA; sem nem mesmo garantia implícita de
#    ADEQUAÇÃO ao MERCADO ou APLICAÇÃO EM PARTICULAR.  Veja a 
#    GNU General Public License para maiores detalhes.

#    Você deveria receber uma cópia da GNU General Public License
#    juntamente com esse programa.  Caso contrário, veja 
#    <http://www.gnu.org/licenses/>.

# Testado no Ubuntu 12.04. Adeque a outras distribuições
# ou versões caso não esteja de acordo com suas necessidades.
# Para executar este script digite ./duc.sh na pasta
# em que o script estiver salvo.

function esperar_roteador() {
	while true; do
		ping -c 1 google.com > /dev/null 2>&1
		if [[ $? == 0 ]]; then
			break
		else
			sleep 2
		fi
	done
}

function instalar() {
    echo "Checking Internet connection"
    esperar_roteador
    echo "Uhuu! We've got a connection. OK"
    echo ================================================
    echo

    echo "Wait while we update your system..."
    echo
    sudo apt-get update -qy > /dev/null
    sudo apt-get install build-essential
    sudo apt-get autoremove -qy > /dev/null

    cd /usr/local/src/
    sudo rm -rf noip*
    wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz

    mkdir noip2 && tar -xzf noip-duc-linux.tar.gz -C noip2 --strip-components 1
    cd noip2/
    sudo make clean
    sudo make && sudo make install
    echo
    echo "Installation finished!"
    sleep 6
    echo ""
    clear
}

function desinstalar() {
    sudo killall noip2
    sudo rm -rf /usr/local/bin/noip2
    sudo rm -rf /usr/local/etc/no-ip2.conf
    sudo rm -rf /usr/local/etc/NO-IPalmco0
    sudo rm -rf /usr/local/src/noip*
    sudo rm /etc/init.d/noip2

    if [ -e /etc/rc0.d/K20noip2 ];
    then
        cd /etc/rc0.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc1.d/K20noip2 ];
    then
        cd /etc/rc1.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc2.d/K20noip2 ];
    then
        cd /etc/rc2.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc3.d/K20noip2 ];
    then
        cd /etc/rc3.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc4.d/K20noip2 ];
    then
        cd /etc/rc4.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc5.d/K20noip2 ];
    then
        cd /etc/rc5.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rc6.d/K20noip2 ];
    then 
        cd /etc/rc6.d/
        sudo rm K20noip2
    fi

    if [ -e /etc/rcS.d/K20noip2 ];
    then
        cd /etc/rcS.d/
        sudo rm K20noip2
    fi
    sleep 6
    clear
}

while :
    do

        echo "What do you want to do?"         
        echo
        echo "TYPE A NUMBER"
        echo "1 . Install No-IP2"
        echo "2 . Uninstall No-IP2"
        echo "3 . Reboot your system"
        echo "4 . Exit"

        read opt
        echo
        case $opt in
            1)
                echo "Installing No-IP2.."
                instalar;
                ;;
            2)
                echo "Uninstalling No-IP2"
                desinstalar;
                ;;
            3)
                echo
                sudo reboot;
                ;;
            4)
                exit;
                ;;
            *) clear;
                echo "Invalid option";;
        esac
done
