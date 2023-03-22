# ps1-3ds-forwarder
Package PS1 roms into installable CIA files.

## Usage
`./create.sh [ROM] [ICON] [BANNER] [SOUND]`  
#### ROM - Path to your PS1 rom. Must be in CHD format.
#### ICON - Path to your icon. Must be 48x48 in PNG format.
#### BANNER - Path to your banner. Must be 256x128.
#### SOUND - Path to the banner sound. Must be .wav and under three seconds. Use stereo.  
It'll prompt you for other pieces of information from there. Just fill it out. If it says (optional), then you can just press enter and leave it blank.  
  
## Other things
Let me know if anything is broken *with this forwarder, not the emulator*. I'm having difficulties with the emulator code itself, so I can't really upate that right now.  
   
This tool isn't supposed to be an easy-to-use GUI. It's just bash script that runs a bunch of commands to package things together.  
  
There's no Windows version yet, so if you're on Windows and absolutely need to forward your game, you can follow along the script yourself using the respective Windows versions of the tools used.  
   
In this version of the forwarder, there is no retroarch menu. It has been disabled. If you need to change emulator settings or use a remap file, you can edit the files inside the ROMFS folder.  
  
Last thing. There's a weird bug I can't figure out. The game won't save the first time you open it. So open and close the game once before you get too invested.
  
Other than that, enjoy!
