# Honor system-wide environment variables

echo ".zprofile Setting up the system, user profile, and related variables."

export GUIX_PROFILE="/home/mpm/.guix-profile"
source "$GUIX_PROFILE/etc/profile"

# Merge search-paths from multiple profiles, the order matters.
eval "$(guix package --search-paths \
-p $HOME/.config/guix/current \
-p $HOME/.guix-profile \
-p /run/current-system/profile)"

# Prepend setuid programs.
export PATH=/run/setuid-programs:$PATH

# Created by `pipx` on 2024-01-12 09:22:18
export PATH="$PATH:/home/mpm/.local/bin"
