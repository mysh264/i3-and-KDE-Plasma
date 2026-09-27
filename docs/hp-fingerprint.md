# Fingerprint login on HP laptops (Elan MoC sensor)

For HP laptops with an Elan match-on-chip reader that needs the `elanmoc2` driver (check with `lsusb | grep -i elan`).

## 1. Install the driver and daemon

```bash
yay -S libfprint-elanmoc2-working-git
sudo pacman -S fprintd
sudo systemctl restart fprintd.service
```

Enroll a finger (from Plasma System Settings > Users, or):

```bash
fprintd-enroll
```

## 2. Enable it in PAM

Add this line **at the top** of each file below (above the other `auth` lines). `sufficient` means the fingerprint is enough, and if it fails or times out you can still type your password.

```
auth sufficient pam_fprintd.so
```

| File | What it unlocks |
|---|---|
| `/etc/pam.d/sddm` | login screen |
| `/etc/pam.d/system-local-login` | local logins |
| `/etc/pam.d/system-login` | lock screen and other logins |
| `/etc/pam.d/sudo` | `sudo` in the terminal |
| `/etc/pam.d/polkit-1` | admin password prompts (see below) |

```bash
sudo nano /etc/pam.d/sddm
sudo nano /etc/pam.d/system-local-login
sudo nano /etc/pam.d/system-login
sudo nano /etc/pam.d/sudo
```

Polkit has no file in `/etc/pam.d` by default, so copy it there first:

```bash
sudo cp /usr/lib/pam.d/polkit-1 /etc/pam.d/polkit-1
sudo nano /etc/pam.d/polkit-1
```

> Keep a terminal with `sudo -s` open while editing PAM files, so you can undo a mistake without being locked out.
