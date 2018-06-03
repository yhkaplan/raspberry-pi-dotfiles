#Backup your packages list
# Get a packages list
dpkg --get-selections > ~/Package.list

# Copy list of repositories
sudo cp /etc/apt/sources.list ~/sources.list

# Export repo keys
sudo apt-key exportall > ~/Repo.keys

# Restore packages
sudo apt-key add ~/Repo.keys
sudo cp ~/sources.list /etc/apt/sources.list 
sudo apt-get update
sudo apt-get install dselect
sudo dpkg --set-selections < ~/Package.list
sudo apt-get dselect-upgrade -y
