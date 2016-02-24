#!/bin/bash
# Procedimento para instalação dos principais programas para o ubuntu e derivados
# Data: 23/02/2016
# Por: Douglas Cabral

sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
#see https://gist.github.com/cowboy/3118588
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Insere os repositórios necessários
# 1. Add the Spotify repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Gooogle Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Brackets
sudo add-apt-repository ppa:webupd8team/brackets -y

#Java
sudo add-apt-repository ppa:webupd8team/java -y

# Atualiza a lista de pacotes
sudo apt-get update

# Atualiza a distribuição
sudo apt-get upgrade

# Array de pacotes para instalar
programas=(
firefox
libreoffice
brackets
curl
thunderbird
gimp
vlc
rsync
grsync
gparted
google-chrome-stable
spotify-client
unzip
g++
unrar
filezilla
meld
p7zip-full
nodejs
npm
transmission
brasero
gnome-disk-utility
software-properties-common
ssh
ubuntu-restricted-extras
libav-tools
mediainfo
oracle-java8-installer
oracle-java8-set-default
)

#instala cada uma das aplicações
for i in "${programas[@]}"
do
    pacote=$(dpkg --get-selections | grep "$i")
    if [ -n "$pacote" ];
    then
        echo "Pacote $i já instalado"
    else
        echo "Instalando $i"
        sudo apt-get -y install "$i"
    fi
done

echo -n "Pressione qualquer tecla para sair..."
read
exit
