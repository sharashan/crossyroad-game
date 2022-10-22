WARNING: THESE INSTRUCTIONS MIGHT ONLY WORK FOR MACOS CURRENTLY

WINDOWS Installation:
First install the graphics package's system dependency with the following command:

  $ sudo apt install pkg-config

Then install the graphics package with the following command:

  $ opam install graphics

Next we need to install an X server in windows to be able to see the display output.
Xming is a free option available here:
https://sourceforge.net/projects/xming/
Go through the install wizard. All default settings is fine. Change Keyboard settings using Windows key. Move the two sliders all the way to the right.

Open Xming and enter the command:
  $ export DISPLAY=:0

And now you're ready to run:

  $ make play

MacOS Installation:

Make sure you have installed XQuartz then install the graphics package with the following command:

  $ opam install graphics

Then you should be ready to run:

  $ make play