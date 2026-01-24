#Install Git
sudo dnf install -y git
#Install Terraform (Direct RPM)
sudo dnf install -y https://rpm.releases.hashicorp.com/RHEL/9/x86_64/stable/terraform-1.8.5-1.x86_64.rpm
#Install Azure CLI
"sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && sudo dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm && sudo dnf install -y azure-cli",