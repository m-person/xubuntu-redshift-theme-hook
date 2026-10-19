# A Redshift hook to apply dark/light theme on Xfce on sunrise/sundown.

Needs Redshift to be installed and running.

## Installation (on Xubuntu 26.04)
- adjust theme names in the theme.sh file.
- copy the theme.sh file to the ~/.config/redshift/hooks/ dir. Create this dir if it doesn't exist.
- set permissions of the copied file to 700
- copy apparmor rules from etc/apparmor.d/* dir
- apply apparmor rules: `sudo apparmor_parser -r /etc/apparmor.d/usr.bin.redshift`
- restart redshift


Manual execution:
```bash
theme.sh period-changed daytime night
theme.sh period-changed night daytime
```

