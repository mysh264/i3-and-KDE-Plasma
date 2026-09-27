# App Recommendations

Apps I use and recommend alongside KDE Plasma + i3wm. Back to the [main README](../README.md).

### Terminals

<details><summary>Click to view</summary>

* ```kitty``` , The fast, feature-rich, [GPU based terminal emulator](https://sw.kovidgoyal.net/kitty/).

  ```bash
  sudo pacman -S kitty
  ```
</details>

---

### Web Browsers

<details><summary>Click to view</summary>

* ```brave``` <sup>[AUR](http://aur.archlinux.org/packages/brave-bin)</sup> , Web browser that blocks ads and trackers by default.

  ```bash
  yay -S brave-bin
  ```

* ```zen``` <sup>[Flatpak](http://flathub.org/en/apps/app.zen_browser.zen)</sup> <sup>[AUR](http://aur.archlinux.org/packages/zen-browser-bin)</sup> , [A fast, private and secure web browser built to improve your day-to-day experience.](https://zen-browser.app/)

  ```bash
  flatpak install flathub app.zen_browser.zen
  
  yay -S zen-browser-bin
  ```
</details>

---

### Email Clients

<details><summary>Click to view</summary>

* ```thunderbird thunderbird-i18n-en-us thunderbird-i18n-ar hunspell-en_us hunspell-ar``` , Thunderbird is **a free email application** that’s easy to set up and customize - and it’s loaded with great features!

  ```bash
  sudo pacman -S thunderbird thunderbird-i18n-en-us thunderbird-i18n-ar hunspell-en_us
  ```
  ```bash
  yay -S hunspell-ar
  ```

* ```birdtray``` <sup>[AUR](http://aur.archlinux.org/packages/birdtray)</sup> , Run Thunderbird with a system tray icon.

  ```bash
  yay -S birdtray
  ```
</details>

---

### Editors

<details><summary>Click to view</summary>

* ```github-desktop``` <sup>[Flatpak](https://flathub.org/en/apps/io.github.shiftey.Desktop)</sup> , GUI for managing Git and GitHub.

  ```bash
  flatpak install flathub io.github.shiftey.Desktop
  ```

* ```typora``` <sup>[AUR](http://aur.archlinux.org/packages/typora)</sup> , [A minimal markdown editor and reader.](https://typora.io/)

  ```bash
  yay -S typora
  ```

* ```zed``` <sup>[Flatpak](https://flathub.org/en/apps/dev.zed.Zed)</sup> , High-performance code editor.

  ```bash
  flatpak install flathub dev.zed.Zed
  ```

* ```meld``` , Compare files, directories and working copies.

  ```bash
  sudo pacman -S meld
  ```
</details>

---

### Downloader

<details><summary>Click to view</summary>

* ```jdownloader2``` <sup>[AUR](http://aur.archlinux.org/packages/jdownloader2)</sup> , Download manager, written in Java, for one-click hosting sites like Rapidshare and MEGA.

  ```bash
  yay -S jdownloader2
  ```
</details>

---

### Torrent Downloaders

<details><summary>Click to view</summary>

* ```qbittorrent``` , An open source Bittorrent client.

  ```bash
  sudo pacman -S qbittorrent
  ```
</details>

---

### Multimedia Tools

<details><summary>Click to view</summary>

* ```mpv``` , A free, open source, and cross-platform media player.

  ```bash
  sudo pacman -S mpv xclip
  ```

* ```mpv-mpris2-bin```<sup>[AUR](http://aur.archlinux.org/packages/mpv-mpris2-bin)</sup> , Rust implementation of the MPRIS v2 DBus interface for the mpv.

  ```bash
  sudo pacman -S playerctl ffmpegthumbnailer
  
  yay -S mpv-mpris2-bin
  ```
* ```subliminal``` , 
  ```bash
  yay -S subliminal --noconfirm
  ```

* ```mpv-config``` , My personal mpv configurations and scripts. <sup>[Github](https://github.com/mysh264/mpv-config)</sup> , <sup>[Forked](https://github.com/noelsimbolon/mpv-config)</sup>

  ```bash
  cd $HOME/.config/mpv
  ```
  ```bash
  git clone https://github.com/mysh264/mpv-config.git
  ```
  ```bash
  mv mpv-config/{*,.*} .
  ```
  ```bash
  rm -rvf mpv-config
  ```
  ```bash
  cd
  ```

* ```easyeffects``` , [Audio Effects for Pipewire applications.](https://github.com/wwmm/easyeffects)

  ```bash
  sudo pacman -S easyeffects
  ```

* ```stremio``` <sup>[Flatpak](https://flathub.org/en/apps/com.stremio.Stremio)</sup> , [A one-stop hub for video content aggregation (Movies, TV shows, series, live television or web channels)](https://www.stremio.com/)

  ```bash
  flatpak install flathub com.stremio.Stremio
  ```

* ```yt-x``` <sup>[AUR](http://aur.archlinux.org/packages/yt-x)</sup> <sup>[Github](https://github.com/Benexl/yt-x)</sup> , Browse YouTube from your terminal. Plus other sites yt-dlp supports.

  ***~Note: Use ```yt-x``` with ```kitty```~***

  ```bash
  yay -S yt-x-git
  ```

* ```video-trimmer``` , Trim videos quickly.

  ```bash
  sudo pacman -S video-trimmer
  ```

* ```handbrake``` , Video Transcoder.

  ```bash
  sudo pacman -S handbrake
  ```
</details>

---

### Screenshot & Screen Recorder Tools

<details><summary>Click to view</summary>

* ```maim``` , Utility to take a screenshot using imlib2.

  ```bash
  sudo pacman -S maim slop
  ```

* ```obs-studio``` , Free, open source software for live streaming and recording.

  ```bash
  sudo pacman -S obs-studio
  ```
</details>

---

### Disk Utilities

<details><summary>Click to view</summary>

* ```ventoy``` <sup>[AUR](http://aur.archlinux.org/packages/ventoy-bin)</sup> , [A new bootable USB solution](http://www.ventoy.net)

  ```bash
  yay -S ventoy-bin
  ```

* ```gparted``` , A Partition Magic clone, frontend to GNU Parted.

  ```bash
  sudo pacman -S gparted
  ```

* ```gnome-disk-utility``` , Disk Management Utility for GNOME.

  ```bash
  sudo pacman -S gnome-disk-utility
  ```
</details>

---

### Password Managers

<details><summary>Click to view</summary>

* ```enpass``` <sup>[AUR](http://aur.archlinux.org/packages/enpass-bin)</sup> , [A multiplatform password manager](http://enpass.io/)

  ```bash
  yay -S enpass-bin
  ```
</details>

---

### Networking

<details><summary>Click to view</summary>

* ```sniffnet``` , Application to comfortably monitor your network traffic

  ```bash
  sudo pacman -S sniffnet
  ```
</details>

---

### File index and search

<details><summary>Click to view</summary>

* ```catfish``` , Versatile file searching tool.

  ```bash
  sudo pacman -S catfish plocate zeitgeist
  ```

* ```kfind``` , Find Files/folders.

  ```bash
  sudo pacman -S kfind mlocate
  ```

* ```ncdu``` , Disk usage analyzer with an ncurses interface.

  ```bash
  sudo pacman -S ncdu
  ```

  </details>

---

### File Managers

<details><summary>Click to view</summary>

* ```yazi``` <sup>TUI</sup> <sup>[Github](https://github.com/sxyazi/yazi)</sup> , Blazing fast terminal file manager written in Rust, based on async /0

  * [Quick start](https://yazi-rs.github.io/docs/quick-start)

  ```bash
  sudo pacman -S yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick xclip chafa git
  ```

  * [Plugins](https://github.com/yazi-rs/plugins)

    <details><summary>Click to view</summary>

    * [Full Boarder](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi) , Add a full border to Yazi to make it look fancier.

      * Installation:

        ```bash
        ya pkg add yazi-rs/plugins:full-border
        ```

      * Add this to your init.lua to enable the plugin: ```nano $HOME/.config/init.lua```

        ```lua
        require("full-border"):setup()
        
        # Or you can customize the border type:
        
        require("full-border"):setup {
        	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        	type = ui.Border.ROUNDED,
        }
        ```

        ---

    * [Git](https://github.com/yazi-rs/plugins/tree/main/git.yazi) , Show the status of Git file changes as linemode in the file list.

      * Installation:

        ```bash
        ya pkg add yazi-rs/plugins:git
        ```

      * Add the following to your `~/.config/yazi/init.lua`: ```nano $HOME/.config/init.lua```

        ```lua
        th.git = th.git or {}
        th.git.unknown_sign = " "
        th.git.modified_sign = "M"
        th.git.deleted_sign = "D"
        th.git.clean_sign = "✔"
        
        require("git"):setup {
        	-- Order of status signs showing in the linemode
        	order = 1500,
        }
        ```

      * And register it as fetchers in your `~/.config/yazi/yazi.toml`: ```nano $HOME/.config/yazi.toml```

        ```toml
        [[plugin.prepend_fetchers]]
        id    = "git" # Remove if Yazi > v26.1.22
        url   = "*"
        run   = "git"
        group = "git"
        
        [[plugin.prepend_fetchers]]
        id    = "git" # Remove if Yazi > v26.1.22
        url   = "*/"
        run   = "git"
        group = "git"
        ```

        ---

    * [VCS Files](https://github.com/yazi-rs/plugins/tree/main/vcs-files.yazi) , Show Git file changes in Yazi.

    
      * Installation
    
          ```bash
          ya pkg add yazi-rs/plugins:vcs-files
          ```
    
    
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
          ```tmol
          [[mgr.prepend_keymap]]
          on   = [ "g", "c" ]
          run  = "plugin vcs-files"
          desc = "Show Git file changes"
          ```

          ---

    
    
    * [Mount](https://github.com/yazi-rs/plugins/tree/main/mount.yazi) , A mount manager for Yazi, providing disk mount, unmount, and eject functionality.
    
      * Installation

        ```bash
        ya pkg add yazi-rs/plugins:mount
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```toml
        [[mgr.prepend_keymap]]
        on  = "M"
        run = "plugin mount"
        ```

        ---

    * [Zoom](https://github.com/yazi-rs/plugins/tree/main/zoom.yazi) , Enlarge or shrink the preview image of a file, which is useful for magnifying small files for viewing.
    
      * Installation

        ```bash
        ya pkg add yazi-rs/plugins:zoom
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```toml
        [[mgr.prepend_keymap]]
        on   = "+"
        run  = "plugin zoom 1"
        desc = "Zoom in hovered file"
        
        [[mgr.prepend_keymap]]
        on   = "-"
        run  = "plugin zoom -1"
        desc = "Zoom out hovered file"
        ```
    
        ---
    
    * [Chmod](https://github.com/yazi-rs/plugins/tree/main/chmod.yazi) , Execute `chmod` on the selected files to change their mode.
    
      * Installation
    
        ```bash
        ya pkg add yazi-rs/plugins:chmod
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```toml
        [[mgr.prepend_keymap]]
        on   = [ "e", "E" ]
        run  = "plugin chmod"
        desc = "Chmod on selected files"
        ```
    
        ---
    
    * [MIME EXT](https://github.com/yazi-rs/plugins/tree/main/mime-ext.yazi) , A MIME type provider based on a file extension database.
    
      * Installation

        ```bash
        ya pkg add yazi-rs/plugins:mime-ext
        ```
    
      * Add this to your `~/.config/yazi/yazi.toml`: ```nano $HOME/.config/yazi.toml```
    
        ```toml
        [[plugin.prepend_fetchers]]
        id    = "mime" # Remove if Yazi > v26.1.22
        url   = "local://*"
        run   = "mime-ext.local"
        prio  = "high"
        group = "mime"
        
        [[plugin.prepend_fetchers]]
        id    = "mime" # Remove if Yazi > v26.1.22
        url   = "remote://*"
        run   = "mime-ext.remote"
        prio  = "high"
        group = "mime"
        ```
    
      * You can also customize it in your `~/.config/yazi/init.lua` with: ```nano $HOME/.config/yazi/init.lua```
    
        ```lua
        require("mime-ext.local"):setup {
        	-- Expand the existing filename database (lowercase), for example:
        	with_files = {
        		makefile = "text/makefile",
        		-- ...
        	},
        
        	-- Expand the existing extension database (lowercase), for example:
        	with_exts = {
        		mk = "text/makefile",
        		-- ...
        	},
        
        	-- If the MIME type is not in both filename and extension databases,
        	-- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
        	fallback_file1 = false,
            }
        ```
    
        ---
    
    * [DIFF](https://github.com/yazi-rs/plugins/tree/main/diff.yazi) , Diff the selected file with the hovered file, create a living patch, and copy it to the clipboard.
    
      * Installation
    
        ```bash
        ya pkg add yazi-rs/plugins:diff
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```toml
        [[mgr.prepend_keymap]]
        on   = "<C-d>"
        run  = "plugin diff"
        desc = "Diff the selected with the hovered file"
        ```
    
        ---
    
    * [Smart Enter](https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi) , Open files or enter directories all in one key!
    
      * Installation
    
        ```bash
        ya pkg add yazi-rs/plugins:smart-enter
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```tmol
        [[mgr.prepend_keymap]]
        on   = "<Enter>"
        run  = "plugin smart-enter"
        desc = "Enter the child directory, or open the file"
        ```
    
      * If you still want `open` to target multiple selected files, add this to your `~/.config/yazi/init.lua`: ```nano $HOME/.config/yazi/init.lua```
    
        ```lua
        require("smart-enter"):setup {
        	open_multi = true,
        }
        ```
    
        ---
    
    * [Toggle Pane](https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi) , Toggle the show, hide, and maximize states for different panes: parent, current, and preview. 
    
      * Installation
    
        ```bash
        ya pkg add yazi-rs/plugins:toggle-pane
        ```
    
      * Add this to your `~/.config/yazi/keymap.toml`: ```nano $HOME/.config/yazi/keymap.toml```
    
        ```tmol
        [[mgr.prepend_keymap]]
        on   = "p"
        run  = "plugin toggle-pane min-preview"
        desc = "Show or hide the preview pane"
        
        [[mgr.prepend_keymap]]
        on   = "P"
        run  = "plugin toggle-pane max-preview"
        desc = "Maximize or restore the preview pane"
        ```
    
        ***Note: You can replace `preview` with `current` or `parent` to toggle the other panes.***
    
        ---
    
      </details>

* ```ranger``` <sup>TUI</sup> <sup>[Github]()</sup> , Simple, vim-like file manager.

  * [Video Previews](https://github.com/ranger/ranger/wiki/Video-Previews)

  ```bash
  sudo pacman -S ranger atool lha lzop unace zip elinks ffmpegthumbnailer highlight imagemagick libcaca lynx mediainfo odt2txt perl-image-exiftool perl-archive-zip perl-io-compress-brotli poppler python-pillow transmission-cli ueberzug w3m
  ```

* ```nnn``` <sup>TUI</sup> <sup>[Github](https://github.com/jarun/nnn)</sup> , The fastest terminal file manager ever written.

  ```bash
  sudo pacman -S nnn atool libarchive zip unzip trash-cli sshfs rclone fuse2
  ```
  </details>

---

### Communication and Productivity

<details><summary>Click to view</summary>

* ```portal for teams``` <sup>[Flatpak](https://flathub.org/en/apps/com.github.IsmaelMartinez.teams_for_linux)</sup> , Unofficial Microsoft Teams client for Linux.

  ```bash
  flatpak install flathub com.github.IsmaelMartinez.teams_for_linux
  ```

* ```teams-for-linux``` <sup>[AUR](https://aur.archlinux.org/packages/teams-for-linux)</sup> , Unofficial Microsoft Teams client for Linux using Electron.

  ```bash
  yay -S teams-for-linux
  ```
</details>

---

<h2 align="center">Web Browsers Extensions/Add-ons</h2>

### Firefox Extensions/Add-ons

<details><summary>Click to view</summary>

1. [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
2. [Tweaks for YouTube](https://addons.mozilla.org/en-US/firefox/addon/tweaks-for-youtube/)
    * _**Note: How to use**_
      * _Appearance & Other Features > **Enable (Expanded Cinema Mode)**_
      * _Preferences > Video View - Start New Video In > **Cinema mode**_
      * _Preferences > Preferred Video Resolution > **1080p (HD)**_
3. ~[Simple Translate](https://addons.mozilla.org/en-US/firefox/addon/simple-translate/)~
4. [Simple Translate Popup Fix](https://addons.mozilla.org/en-GB/firefox/addon/simple-translate-popup-fix/)
    * _**Note: How to use**_
      * _Target language: **Arabic**_
      * _Second language : **English**_
      * _Choose: Behavior when selecting text: **Display translation panel**_
      * _Enable: **Automatically switch to the second language**_
5. [Grammarly: AI Writing and Grammar Checker App](https://addons.mozilla.org/en-US/firefox/addon/grammarly-1/)
6. [AI Grammar Checker & Paraphraser – LanguageTool](https://addons.mozilla.org/en-US/firefox/addon/languagetool/)
7. [Private Grammar Checker - Harper](https://addons.mozilla.org/en-US/firefox/addon/private-grammar-checker-harper/)
8. [Adaptive Tab Bar Color](https://addons.mozilla.org/en-US/firefox/addon/adaptive-tab-bar-colour/)
9. [Time Tracker - Web Habit Builder](https://addons.mozilla.org/en-US/firefox/addon/besttimetracker/)
10. [Server IP](https://addons.mozilla.org/en-US/firefox/addon/server-ip/)
11. [User-Agent Switcher and Manager](https://addons.mozilla.org/en-US/firefox/addon/user-agent-string-switcher/)
12. [Allow Right-Click](https://addons.mozilla.org/en-US/firefox/addon/re-enable-right-click/)
13. [Open Link with New Tab](https://addons.mozilla.org/en-US/firefox/addon/open-link-with-new-tab/)
14. [I still don't care about cookies](https://addons.mozilla.org/en-US/firefox/addon/istilldontcareaboutcookies/)
15. [Search by Image](https://addons.mozilla.org/en-US/firefox/addon/search_by_image/)

</details>

---

## Google Chrome Extensions/Add-ons

<details><summary>Click to view</summary>

1. [uBlock Origin Lite](https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh) *Note: If you are using ```Brave browser```,* ***DO NOT USE IT***
2. [Tweaks for YouTube](https://chromewebstore.google.com/detail/tweaks-for-youtube/ogkoifddpkoabehfemkolflcjhklmkge)
    * _**Note: How to use**_
      * _Appearance & Other Features > **Enable (Expanded Cinema Mode)**_
      * _Preferences > Video View - Start New Video In > **Cinema mode**_
      * _Preferences > Preferred Video Resolution > **1080p (HD)**_
3. [Simple Translate](https://chromewebstore.google.com/detail/simple-translate/ibplnjkanclpjokhdolnendpplpjiace)
    * _**Note: How to use**_
      * _Target language: **Arabic**_
      * _Second language : **English**_
      * _Choose: Behavior when selecting text: **Display translation panel**_
      * _Enable: **Automatically switch to the second language**_
4. [AI Grammar Checker & Paraphraser – LanguageTool](https://chromewebstore.google.com/detail/ai-grammar-checker-paraph/oldceeleldhonbafppcapldpdifcinji)
5. [Private Grammar Checker - Harper](https://chromewebstore.google.com/detail/private-grammar-checker-h/lodbfhdipoipcjmlebjbgmmgekckhpfb)
6. [Time Tracker - Web Habit Builder](https://chromewebstore.google.com/detail/time-tracker-web-habit-bu/dkdhhcbjijekmneelocdllcldcpmekmm)
7. [Server IP](https://chromewebstore.google.com/detail/server-ip/adcbaggcjppnkmhfmjcdgagmggnfeikh)
8. [User-Agent Switcher and Manager](http://chromewebstore.google.com/detail/user-agent-switcher-and-m/bhchdcejhohfmigjafbampogmaanbfkg)
9. [Allow Right-Click](https://chromewebstore.google.com/detail/allow-right-click/hnafhkjheookmokbkpnfpmemlppjdgoi)
10. [I still don't care about cookies](https://chromewebstore.google.com/detail/i-still-dont-care-about-c/edibdbjcniadpccecjdfdjjppcpchdlm)

</details>
