wants=(
    i3-wm
    conky
    feh
)

for package in ${wants[2]}; do
    exists $package || sudo pacman -S $package
done
