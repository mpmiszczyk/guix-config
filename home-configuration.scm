;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "pamixer"
                                            "mpv"
                                            "yt-dlp"
                                            "hunspell-dict-en-gb"
                                            "hunspell-dict-en-us"
                                            "hunspell-dict-en"
                                            "hunspell-dict-pl"
                                            "fwupd-nonfree"
                                            "tree-sitter"
                                            "ocaml-spawn"
                                            "openssl@1"
                                            "openssh"
                                            "node"
                                            "pulseaudio"
                                            "perl"
                                            "unzip"
                                            "ncurses"
                                            "xrdb"
                                            "signal-desktop"
                                            "libsecret"
                                            "libappindicator"
                                            "libxscrnsaver"
                                            "rust-keyring"
                                            "rust-secret-service"
                                            "python"
                                            "ranger"
                                            "awscli"
                                            "aws-vault"
                                            "curl"
                                            "sshuttle"
                                            "kubectl"
                                            "ripgrep"
                                            "bat"
                                            "hunspell"
                                            "libvterm"
                                            "make"
                                            "font-iosevka-term"
                                            "fontconfig"
                                            "git"
                                            "gcc-toolchain"
                                            "elixir"
                                            "erlang"
                                            "ruby"
                                            "dunst"
                                            "libnotify"
                                            "cmake"
                                            "emacs"
                                            "i3lock"
                                            "google-chrome-stable"
                                            "xrandr"
                                            "zsh"
                                            "qutebrowser"
                                            "emacs-guix"
                                            "btop")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")))
                   (bashrc (list (local-file
                                  "/home/mpm/src/guix-config/.bashrc" "bashrc")))
                   (bash-profile (list (local-file
                                        "/home/mpm/src/guix-config/.bash_profile"
                                        "bash_profile"))))))))
