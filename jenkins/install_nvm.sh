cat > /tmp/install-node.sh << EOF
 
echo "Setting up NodeJS Environment"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
echo 'export NVM_DIR="/home/jenkins/.nvm"' >> /home/jenkins/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/jenkins/.bashrc
# Dot source the files to ensure that variables are available within the current shell
. /home/jenkins/.nvm/nvm.sh
. /home/jenkins/.profile
. /home/jenkins/.bashrc
# Install NVM, NPM, Node.JS & Grunt
nvm alias default 10.7.0
nvm install 10.7.0
nvm use 10.7.0
EOF

chown jenkins:jenkins /tmp/install-node.sh && chmod a+x /tmp/install-node.sh
sleep 1; 
su - jenkins -c "/tmp/install-node.sh"
