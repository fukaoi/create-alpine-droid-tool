## Create alpin droid tool

### Usage

+ Termux-app in android
+ pkg install tsu
+ $ sudo ./setup.sh

### start-alpine.sh

```
#!/bin/sh

su -c "/data/alpineLinux/up.sh"
su -c "/data/alpineLinux/chroot.sh"
```

### stop-alpine.sh

```
#!/bin/sh

su -c "/data/alpineLinux/down.sh"
```
