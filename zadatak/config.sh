#############################################
# Configuration file for the zadatak script #
# Make sure to source this file in all other scripts that use the logger library
# This will ensure that the logger.sh is in PATH
# AND that it's COPIED over to the $HOME/lib-za-bash directory
#############################################

export LOG_FILE_LOCATION="./logger.log"

export LIB_DIR="$HOME/lib-za-bash"

if [[ ! -d "$LIB_DIR" ]]; then
    mkdir -p "$LIB_DIR"
    echo "Created directory $LIB_DIR"
    cp -r ./libovi/* "$LIB_DIR"
fi

# Add the LIB_DIR to the PATH in the shell configuration files if not already present
SHELL_CONFIG_FILES=("$HOME/.bashrc" "$HOME/.zshrc")

for config_file in "${SHELL_CONFIG_FILES[@]}"; do
    if [[ -f "$config_file" ]]; then
        if ! grep -q "export PATH=\$PATH:$LIB_DIR" "$config_file"; then
            echo "export PATH=\$PATH:$LIB_DIR" >> "$config_file"
            echo "Added $LIB_DIR to PATH in $config_file"
        else
            echo "$LIB_DIR is already in the PATH in $config_file"
        fi
    fi
done

# Source the shell configuration files only if this is the first time
if ! grep -q "source $HOME/.bashrc" <<< "$(history)"; then
    source "$HOME/.bashrc" 2>/dev/null || true
fi

if ! grep -q "source $HOME/.zshrc" <<< "$(history)"; then
    source "$HOME/.zshrc" 2>/dev/null || true
fi
