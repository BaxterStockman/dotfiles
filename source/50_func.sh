# cd and ls in one
cl() {
    if [[ -d "$1" ]]; then
        cd "$1"
        ls
    else
        echo "bash: cl: '$1': Directory not found"
    fi
}

# calculator
calc() {
    echo "scale=3;$@" | bc -l
}
