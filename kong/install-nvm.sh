cat > /tmp/install-node.sh << EOF
 

echo "Setting up NodeJS Environment"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

echo 'export NVM_DIR="/home/ec2-user/.nvm"' >> /home/ec2-user/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> /home/ec2-user/.bashrc

# Dot source the files to ensure that variables are available within the current shell
. /home/ec2-user/.nvm/nvm.sh
. /home/ec2-user/.profile
. /home/ec2-user/.bashrc

# Install NVM, NPM, Node.JS & Grunt
nvm alias default 10.7.0
nvm install 10.7.0
nvm use 10.7.0

EOF

chown ec2-user:ec2-user /tmp/install-node.sh && chmod a+x /tmp/install-node.sh
sleep 1; 
su - ec2-user -c "/tmp/install-node.sh"
