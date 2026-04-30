# i3 and KDE Plasma

How to install the i3 window manager on KDE Plasma.

---

> ![screenshot of my current setup - 1](Images/Screenshot_20260430_153753.png)
> ![screenshot of my current setup - 2](Images/Screenshot_20260430_153807.png)

---

## Why i3 and KDE Plasma?

* KDE Plasma is one of the most full-featured and beautiful desktop environments.
* i3wm is one of the lightest, most customizable, and simplest window managers.
* Together, we will have the easy, working out-of-the-box desktop environment (***KDE Plasma***) and tiling style, light, fully customizable window manager (***i3wm***).

---

## Why using i3wm, not kwin script?

Short answer: **I3wm is better and more stable than any kwin script I tried**, and I will be happy to prove me wrong.

---

## Pros & Cons

* **Pros** :
	* If you used KDE Plasma and i3wm before, you will love having them together.
	* Tilling support for KDE Plasma.
	* Most utilities and configurations, for example, (***GTK & QT theme, Display brightness buttons, Audio buttons, ...etc***) will work out of the box.

* **Cons**:
	* Not even one. “*At least for me*.”

---

## Situation before the installation

* EndeavourOS KDE Edition, all updates installed
* KDE Plasma (X11)
* KWin

---

## To Do

1. Install Packages.
2. ~Download This clone for i3, i3block, rofi, picom, conky~
3. Download [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), for rofi & i3block configuration files (also i3 & picom configuration files if you like).
4. Merge rofi configuration pre pared files into (**$HOME/.local/share/rofi**) and (**$HOME/.config/rofi**)
5. Merge i3block configuration prepared files (**i3block.conf and Scripts Folder**) into (**$HOME.config/i3/**)
6. Modify picom (Download the one that I have, or use [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), or simply do it yourself as you prefer.)
7. Modify the i3wm config file in general (Download the one that I have, or use [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), or simply do it yourself as you prefer.)
    * No need for any Bright or volume shortcut keys, **KDE will handle it.**
    * No need for `dex`, **KDE will handle it.**
    * No need for any Lock screen shortcut or configuration, **KDE will handle it.**

    * 
    * `Feh` will take care of wallpaper; **Do not use KDE for wallpaper.**
    * Exit Menu `rofi` will handle it. **Do not use KDE for that.**
8. Modify the i3wm config file for KDE Plasma 
9. Turn off some KDE shortcuts.
10. Turn off the startup screen.
11. Fix mouse cursor.
12. Fix fonts (i3bar & i3 frame).
13. Add URLs Sources.

---

## To Do

1. ~Install Packages.~
2. ~Download This clone for i3, i3block, rofi, picom, conky~
3. Download [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), for rofi & i3block configuration files (also i3 & picom configuration files if you like).
4. Merge rofi configuration pre pared files into (**$HOME/.local/share/rofi**) and (**$HOME/.config/rofi**)
5. Merge i3block configuration prepared files (**i3block.conf and Scripts Folder**) into (**$HOME.config/i3/**)
6. Modify picom (Download the one that I have, or use [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), or simply do it yourself as you prefer.)
7. ~Modify the i3wm config file in general (Download the one that I have, or use [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), or simply do it yourself as you prefer.)~
    * ~No need for any Bright or volume shortcut keys, **KDE will handle it.**~
    * ~No need for `dex`, **KDE will handle it.**~
    * ~No need for any Lock screen shortcut or configuration, **KDE will handle it.**~

    * 
    * ~`Feh` will take care of wallpaper; **Do not use KDE for wallpaper.**~
    * ~Exit Menu `rofi` will handle it. **Do not use KDE for that.**~
8. ~Modify the i3wm config file for KDE Plasma~
9. ~Turn off some KDE shortcuts.~
10. Turn off the startup screen.
11. ~Fix mouse cursor.~
12. ~Fix fonts (i3bar & i3 frame).~
13. Add URLs Sources.

---

## Installation

### Packages

We're gonna install a couple of packages that are required or nice-to-haves on i3, as well as i3 itself. This consists of:

* ```i3```, [the window manager itself](https://i3wm.org/)
* ```i3blocks```, [for i3bar staus line](https://github.com/vivien/i3blocks)
* ```picom```, [compositor](https://github.com/yshui/picom) (kwin replacement)
* ```feh```, [to set up the background](https://github.com/derf/feh)
* ```rofi```, [application launcher](https://github.com/davatorium/rofi) (dmenu replacement)
* ```wmctrl```, [to get some info for the i3 config](https://github.com/Conservatory/wmctrl) (if you're not on an English installation of Plasma)

*optional for i3wm*

* ```viewnior```, my favourit [image viewer](https://github.com/hellosiyan/Viewnior) (gwenview alternative)
* ```conky```, [light-weight system monitor](https://github.com/brndnmtthws/conky)
* ```awesome-terminal-fonts```, if you are using [awesome fonts](https://fontawesome.com/v4/cheatsheet/), you will need it
* ```xfce4-terminal```, [best drop-down terminal](https://docs.xfce.org/apps/xfce4-terminal/dropdown) (yakuake replacement)
* ```sysstat tk gnuplot```, some i3blocks scripts need it

*optional for KDE Plasma Panel*
* ```plasma6-applets-panel-spacer-extended``` <sup>AUR</sup> , [Spacer with Mouse gestures for the KDE Plasma Panel](https://github.com/luisbocanegra/plasma-panel-spacer-extended)
* ```plasma6-applets-kurve```  <sup>AUR</sup> , [Audio visualizer widget powered by CAVA for the KDE Plasma Desktop](https://github.com/luisbocanegra/kurve)

**Here's a one-liner on how I installed everything:**
```
sudo pacman -Syyu && sudo pacman -S i3 i3blocks picom feh rofi wmctrl
```

Another one for ***i3wm optional Packages***:
```
sudo pacman -S viewnior conky awesome-terminal-fonts xfce4-terminal sysstat tk gnuplot
```

A third one for ***KDE Plasma panel optional Packages***:
```
yay -S plasma6-applets-panel-spacer-extended plasma6-applets-kurve
```

---

## Configuration

Replace kwin with i3 using systemd user service

Note that for this method, you do not need to be the root user. However, that means the changes will not effect the other users.

Create a new service file called plasma-i3.service in `$HOME/.config/systemd/user`.

```
mkdir -p $HOME/.config/systemd/user
```

```
cd $HOME/.config/systemd/user
```

```
nano plasma-i3.service
```

Write the following into `$HOME/.config/systemd/user/plasma-i3.service`:

```conf
[Unit]
Description=Launch Plasma with i3
Before=plasma-workspace.target

[Service]
ExecStart=/usr/bin/i3
Restart=on-failure

[Install]
WantedBy=plasma-workspace.target
```

Mask `plasma-kwin_x11.service` by running
```systemctl mask plasma-kwin_x11.service --user```

Enable the plasma-i3 service by running
```systemctl enable plasma-i3 --user```

To go back to KWin, just unmask the `plasma-kwin_x11.service` and disable your `plasma-i3` service in the same way.

---


### Adding stuff to the i3 config

1. To improve compatibility with Plasma, add the following lines in your i3 config.

```sh
# Plasma compatibility improvements

for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [class="yakuake"] floating enable
for_window [class="systemsettings"] floating enable
for_window [class="plasmashell"] floating enable
for_window [class="Plasma"] floating enable, border none
for_window [title="plasma-desktop"] floating enable, border none
for_window [title="win7"] floating enable, border none
for_window [class="krunner"] floating enable, border none
for_window [class="Kmix"] floating enable, border none
for_window [class="Klipper"] floating enable, border none
for_window [class="Plasmoidviewer"] floating enable, border none
for_window [class="(?i)*nextcloud*"] floating disable


no_focus [class="plasmashell" window_type="notification"]


for_window [class="plasmashell" window_type="notification"] floating enable, border none, move absolute position center, move down 400px

# Killing the existing window that covers everything
for_window [title="^Desktop @ QRect.*"] kill, floating enable, border none
```

2. For the application launcher, you can still use the application launcher from Plasma Panel.

> <p align="center">"KDE Plasma application launcher"</p>

> ![KDE Plasma application launcher](Images/Screenshot_20260430_214529.png)

Also, you can use `rofi` launcher. *Meta+E*

> <p align="center">"Rofi application launcher"</p>

> ![Rofi application launcher](Images/Screenshot_20260430_214059.png)

If you prefer to use `krunner`, this is the terminal command line to launch it, if you need it.
```
qdbus6 org.kde.krunner /App org.kde.krunner.App.display
```
---

### Removing stuff from the i3 config
1. Auto Start
KDE Plasma will handle the startup apps. Remove any exec line that uses for auto startup in the i3 config file; also, do not use dex, the only exception will be feh for wallpaper and picom.
```
exec --no-startup-id feh --bg-scale "/path/of/wallpaper"
```
More info about picom down below.
```
exec --no-startup-id picom -b
```

2. Display brightness buttons integration
KDE Plasma will handle it out of the box. Remove any shortcut for that from the i3wm config file.

3. Audio buttons integration
KDE Plasma will handle it out of the box. Remove any shortcut for that from the i3wm config file.

4. Lock screen
KDE Plasma will handle it out of the box. Remove any shortcut for that from the i3wm config file.

---

### Disabling a shortcut that breaks stuff

#### Meta+Q "*Kill apps*"
Launch the Plasma System Settings and go to *Category Workspace > Shortcuts > Category System Services > Plasma* and disable the shortcut "Activities..." that uses the combination ```Meta+Q```.

#### Meta+R "*Resize*"
Launch the Plasma System Settings and go to *Category Workspace > Shortcuts > Category Applications > Spectacle* and disable the shortcut "Start/Stop Region Recording" that uses the combination ```Meta+R```.

---

### Do not use the plasma shutdown screen
Rofi will handle it, if you are using my configuration files or [EndeavourOS i3wm Edition configuration files (github)](https://github.com/endeavouros-team/endeavouros-i3wm-setup), Just press ```Meta+Shift+E```

```
# exit-menu
bindsym Mod4+Shift+e exec --no-startup-id ~/.config/i3/scripts/powermenu
```

> <p align="center">"Rofi exit menu"</p>

> ![Rofi exit Menu](Images/Screenshot_20260430_215358.png)

---

### Turn off the KDE Plasma startup screen "*Splash Screen*"
Launch the Plasma System Settings and go to *Colors & Themes > Splash Screen* and disable it.

> <p align="center">"Screenshot of Splash Screen Settings"</p>

> ![Screenshot of Splash Screen Settings](Images/Screenshot_20260430_211921.png)

### Fix mouse cursor
When changing the mouse cursor theme or size, some apps will show a different mouse cursor
In my case, I used breeze_cursors and changed the size to 32

to fix it, create `$HOME/.icons/default` directory

```
mkdir -p $HOME/.icons/default
```

Then create a new file called `index.theme`

```
nano $HOME/.icons/default/index.theme
```

Write the following into `index.theme`

```conf
[Icon Theme]
Inherits=breeze_cursors
Size=32
```

---

### Fix Fonts (**i3bar & i3-frame**)
when restart the system, you will notice the i3bar using a different font. Using Meta+Shift+R solves it.
It's annoying, so another workaround

Create a new file called `.Xresources` in your $HOME

```
nano $HOME/.Xresources
```

Write the following into `.Xresources`

```conf
Xft.antialias: 1
Xft.hinting: 1
Xft.hintstyle: hintslight
Xft.rgba: rgb```
```

Then run this to load parameters from your configuration file `.Xresources` during your X Session.

```
xrdb -merge ~/.Xresources
```

---

