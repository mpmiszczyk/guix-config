;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (gnu packages shells)
             (gnu packages lisp)
	           (gnu packages linux)
             (gnu services networking)
             (gnu services sound)
             (gnu services docker)
             (gnu services databases)
	           (nongnu packages linux)
	           (nongnu system linux-initrd))


(use-package-modules fonts wm databases)

(use-service-modules linux desktop networking ssh xorg)

(operating-system
 ;; nongnu firmware
 (kernel linux)
 (kernel-loadable-modules (list v4l2loopback-linux-module
                                ;; thinkpad-acpi
                                ;; uvcvideo-module
                                ))
 (initrd microcode-initrd)
 (firmware (cons*
	          ;; iwlwifi-firmware
	          linux-firmware
            amdgpu-firmware
            %base-firmware))
 
 (locale "en_US.utf8")
 (timezone "Europe/Warsaw")
 (keyboard-layout (keyboard-layout "pl" "colemak"
                                   #:options '("ctrl:nocaps")))
 (host-name "mpm-p16s1")

 ;; The list of user accounts ('root' is implicit).
 (users (cons* (user-account
                (name "mpm")
                (comment "mpm")
                (group "users")
                (home-directory "/home/mpm")
		            (shell (file-append zsh "/bin/zsh"))
                (supplementary-groups '("wheel" "netdev" "audio" "video" "docker" ;; "postgres"
                                        )))
               %base-user-accounts))

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (list
                    ;; sbcl-stumpwm-ttf-fonts
                    ;; sbcl-ttf-fonts
                    ;; font-iosevka-term
                    (specification->package "sbcl")
                    ;; (specification->package "sbcl-slynk")
                    (specification->package "v4l2loopback-linux-module")
                    (specification->package "stumpwm")
                    (specification->package "sbcl-stumpwm-cpu")
                    (specification->package "sbcl-stumpwm-net")
                    (specification->package "sbcl-stumpwm-pass")
                    (specification->package "sbcl-stumpwm-ttf-fonts")
                    (specification->package "sbcl-stumpwm-wifi")
                    ;; (specification->package "stumpwm-with-slynk")
                    (specification->package "font-iosevka-term")
                    (specification->package "i3-wm")
                    (specification->package "i3status")
                    (specification->package "dmenu")
                    (specification->package "setxkbmap")
                    (specification->package "xterm")
                    (specification->package "nss-certs")
			              (specification->package "zsh")
                    (specification->package "mesa")
                    (specification->package "gnome-keyring"))
                   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (modify-services
   (append (list
            ;; To configure OpenSSH, pass an 'openssh-configuration'
            ;; record as a second argument to 'service' below.
            (service kernel-module-loader-service-type
                            '("uvcvideo" "v4l2loopback"))
            (service openssh-service-type)
            (set-xorg-configuration (xorg-configuration
                                     (keyboard-layout keyboard-layout)))
            (service gnome-keyring-service-type)
            (service docker-service-type)
            (service screen-locker-services-type
                     (screen-locker-configuration
                      (name "slock")
                      (program (file-append slock "/bin/slock"))))
            )

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services)
   ;; Get nonguix substitutes.
   (guix-service-type config =>
                      (guix-configuration
                       (inherit config)
                       (substitute-urls
                        (append (list "https://substitutes.nonguix.org")
                                %default-substitute-urls))
                       (authorized-keys
                        (append (list (local-file "./nonguix-signing-key.pub"))
                                %default-authorized-guix-keys))))))
  
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "653d9bd0-7bb5-47a2-892f-2b04dc1d5488"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "87D3-C803"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices)) %base-file-systems)))
