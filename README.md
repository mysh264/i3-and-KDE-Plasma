# i3 and KDE Plasma

How to install the i3 window manager on KDE Plasma.

> Preview image:
> ![screenshot of my current setup - 1](Images/Screenshot_20260430_153753.png)
> ![screenshot of my current setup - 2](Images/Screenshot_20260430_153807.png)

---

## Why i3 and KDE Plasma

* KDE Plasma is one of the most full-featured and beautiful desktop environments.
* i3wm is one of the lightest, most customizable, and simplest window managers.
* Together, we will have the easy, working out-of-the-box desktop environment (***KDE Plasma***) and tiling style, light, fully customizable window manager (***i3wm***).

---

## Why using i3wm, not kwin script?

Short answer: **I3wm is better and more stable than any kwin script I tried**, and I will be happy to prove me wrong.

---

## Pros & Cons

* **Pros** :
	* If you used KDE Plasma and i3wm before, you will love to have them together.
	* Tilling support for KDE Plasma.
	* Most utilities and configurations, for example, (***GTK & QT theme***) will work out of the box.

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











