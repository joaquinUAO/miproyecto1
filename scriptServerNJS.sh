#!/bin/bash
services=$1
myIpAdress=$2
consulObject=$3

echo "...INSTALANDO CONSUL..."
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul

echo "...INSTALANDO NODEJS..."
sudo apt install nodejs npm -y

echo "...EJECUTANDO AGENTE CONSUL..."
screen -dmS consul bash -c "consul agent -server -retry-join=$consulObject -bind=$myIpAdress -data-dir=. -bootstrap-expect=2"

echo "...CLONANDO SERVICIO WEB..."
git clone https://github.com/omondragon/consulService

echo “...CONFIGURANDO IP...”
cd consulService/app
sudo sed -i "s/192.168.100.3/$myIpAdress/g" index.js

echo "...INSTALANDO CONSUL EXPRESS..."
npm install consul express

echo "...INICIALIZANDO SERVICIOS..."
for ((i=1; i<=$services; i++))
do
  echo "Iniciando instancia $i"
  port=$((6000 + $i))
  app="serverweb$port"
  screen -dmS $app bash -c "node index.js $port"
done
