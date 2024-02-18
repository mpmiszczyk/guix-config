;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu)
             (gnu packages)
             (gnu services)
             (gnu services shepherd)
             (guix gexp)
             (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu home services desktop)
             (gnu home services shepherd))


(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "pamixer"
                                            "pulseaudio"
                                            "xf86-video-amdgpu"
                                            "mpv"
                                            "yt-dlp"
                                            "hunspell-dict-en-gb"
                                            "hunspell-dict-en-us"
                                            "hunspell-dict-en"
                                            "hunspell-dict-pl"
                                            "fwupd-nonfree"
                                            "tree-sitter"
                                            "openssl@1"
                                            "openssh"
                                            "node"
                                            "perl"
                                            "unzip"
                                            "ncurses"
                                            "xrdb"
                                            "maim"
                                            "xclip"
                                            "xdotool"
                                            "signal-desktop"
                                            "libsecret"
                                            "libappindicator"
                                            "libxscrnsaver"
                                            "python"
                                            "ranger"
                                            "aws-vault"
                                            "curl"
                                            "kubectl"
                                            "docker-compose"
                                            "ripgrep"
                                            "hunspell"
                                            "libvterm"
                                            "make"
                                            "font-iosevka-term"
                                            "fontconfig"
                                            "git"
                                            "bat"
                                            "gcc-toolchain"
                                            "zlib"
                                            "elixir"
                                            "erlang"
                                            "ruby"
                                            "postgresql"
                                            "dunst"
                                            "libnotify"
                                            "cmake"
                                            "emacs"
                                            "emacs-guix"
                                            "i3lock"
                                            "google-chrome-stable"
                                            "xrandr"
                                            "zsh"
                                            "fzf"
                                            "btop")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-zsh-service-type
                  (home-zsh-configuration
                   (zshrc (list (local-file "./.zshrc" "zshrc")))
                   (zprofile (list (local-file "./.zprofile" "zprofile")))))

         (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") 
                              ("ls" . "ls -p --color=auto")
                              ("ll" . "ls -l")
                              ("la" . "ls -la")
                              ("aws-shell" . "aws-vault exec -d 8h -n")))
                   (bashrc (list (local-file
                                  "/home/mpm/src/guix-config/.bashrc" "bashrc")))
                   (bash-profile (list (local-file
                                        "/home/mpm/src/guix-config/.bash_profile"
                                        "bash_profile")))))         
         ;; (simple-service 'config home-files-service-type
         ;;          `((".gitconfig" ,(local-file "files/.gitconfig"))
         ;;            (".tool-versions" ,(local-file "files/.tool-versions"))))
         (simple-service 'configd home-xdg-configuration-files-service-type
                         `(("btop" ,(local-file "./files/btop" #:recursive? #t))
                           ("i3" ,(local-file "./files/i3" #:recursive? #t))
                           ("fzf" ,(local-file "./files/fzf" #:recursive? #t))
                           ("stumpwm" ,(local-file "./files/stumpwm" #:recursive? #t))))

         (service home-redshift-service-type
                  (home-redshift-configuration
                   (location-provider 'manual)
                                        ; Warsaw
                   (latitude 52.23)
                   (longitude 21.01)))

         (service home-shepherd-service-type
                  (home-shepherd-configuration
                   (services (list (shepherd-service
                                    (provision '(emacs-server))
                                    (documentation "Emacs server")
                                    (start #~(make-forkexec-constructor '("emacs" "--fg-daemon")))
                                    (stop #~(make-kill-destructor))
                                    ;; (stop #~(make-system-destructor '("emacsclient" "--eveal" "(progn (setq kill-emacs-hook nil) (kill-emacs))")))
                                    ))))))))

