#!/bin/bash -xe
# This installs the CodeDeploy agent and its prerequisites on Ubuntu 22.04.
sudo apt-get update -y
sudo apt-get install ruby-full ruby-webrick wget -y
cd /tmp
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_1.3.2-1902_all.deb
mkdir codedeploy-agent_1.3.2-1902_ubuntu22
dpkg-deb -R codedeploy-agent_1.3.2-1902_all.deb codedeploy-agent_1.3.2-1902_ubuntu22
sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_1.3.2-1902_ubuntu22/DEBIAN/control
dpkg-deb -b codedeploy-agent_1.3.2-1902_ubuntu22/
sudo dpkg -i codedeploy-agent_1.3.2-1902_ubuntu22.deb
systemctl list-units --type=service | grep codedeploy

#!/bin/bash -xe
# output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# download nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# source nvm
. /.nvm/nvm.sh
nvm install node v14.16.0
# export NVM dir
export NVM_DIR="/.nvm"	
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"	
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# update
sudo apt-get update -y
# run node in sudo
#n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
#sudo npm install pm2 -g
cd /home/ubuntu
# get source code from github
git clone https://github.com/jomardev25/aws-codedeploy-ec2-nodejs.git
cd aws-codedeploy-ec2-nodejs
# give permission
sudo chmod -R 755 .
#install node module
npm install
# start the app
node index.js > app.out.log 2> app.err.log < /dev/null &
#pm2 start index.js