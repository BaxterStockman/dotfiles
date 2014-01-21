# Check that we're on Arch
[[ "$(cat /etc/issue 2> /dev/null)" =~ Arch ]] || return 1

e_header "Updating Pacman"
sudo pacman -Syyu

# Install packages
packages=(
  cowsay
  nmap
  htop
)
