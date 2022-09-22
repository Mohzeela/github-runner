GITHUB_RUNNER_VERSION="2.296.2"



apt-get update
apt-get install -y unzip docker.io jq

# Install terraform
sudo apt install -y gnupg software-properties-common 

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg


echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get install terraform

terraform version


# install packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

apt-get update && sudo apt-get install packer

apt-get update && sudo apt-get install packer





mkdir /actions-runner
cd /actions-runner
curl -o actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz
tar xzf /actions-runner/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz -C /actions-runner

/actions-runner/bin/installdependencies.sh

cp ./configure_runner.sh /actions-runner

sudo chown -R ubuntu:ubuntu /actions-runner/