### WARNING: THESE INSTRUCTIONS MIGHT ONLY WORK FOR MACOS CURRENTLY

## Windows Instructions:
Install Graphics package with the following commands:
  `$ sudo apt install pkg-config`

  `$ opam install graphics`

Download and install the Xming X Server at (https://sourceforge.net/projects/xming/)

Run XLaunch and do not change any of the settings, saving it at the end.

In terminal, enter `$ export DISPLAY=:0`

Now you can play with `$make play`

## MacOS Instructions:

Install the graphics package through terminal:

`$ opam install graphics`

Download XQuartz (https://www.xquartz.org/)

Now you can play with `$ make play`