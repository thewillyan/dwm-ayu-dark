# dwm
My simple [dwm](https://dwm.suckless.org/) customization using the
[ayu-theme](https://github.com/ayu-theme) color pallete.

# Overview
![Screenshot](https://raw.githubusercontent.com/thewillyan/dwm-ayu-dark/main/img/screenshot.png)

# Install
<summary><b>Simple build guide</b></summary>

This isn't a tutorial, so take care and use your knowledge to make
your own decisions.

## Dependencies
- make
- dmenu
- urxvt
- pactl
- clipmenu
- Iosevka Slab Font
- Font Awesome

## Build
To compile the project run:

```sh
sudo make clean install 
```

Execute the `dwm_bar.sh` script to activate the custom bar. You can add the script to your 
`.xinitrc` to auto launch it when dwm starts.
