About setwave5200
=================

![Spreadsheet](https://raw.githubusercontent.com/wd5gnr/mhs5200a/master/images/screenshot_211.png "The system in action")

The MHS5200A (example: http://www.ebay.com/itm/25MHz-Dual-Channel-DDS-Function-Signal-Generator-Arbitrary-Wave-Sweep-Software-/181754377462) is an inexpensive family of DDS signal generators that have
16 arbitrary wave functions. However, the software is for Windows and not
especially good (giant Labview compiled program with lots of issues).

This software does not attempt to operate the device although you may
find the enclosed reverse engineer of its protocol useful. However, it
does allow you to start with a handy spreadsheet, define a waveform, and
upload it.

Here are the basic steps:

1) Copy mhs5200.xls to some unique name
2) Open that new file with your spreadsheet program
3) On the first tab, you can set the total period, min/max values if you like
4) You can fill in column C and if you want to use data from the rest of the spreadsheet to fill in your formula, you can. Each waveform has 1024 samples and data ranges from 0 to 255. The spreadsheet scales for you if you set min and max.
5) Observe the waveform graph to ensure you have the right shape.
6) Switch to the export tab and export it as a CSV file.
7) Run setwave5200 with the following arguments: port #, csv file, slot #

For example:

setwave5200 /dev/ttyUSB0 test.csv 15

Slot numbers are 0 to 15. You can send multiple files:
setwave5200 /dev/ttyUSB0 test.csv 15 sine.csv 0 noise.csv 5

The CSV file format is pretty forgiving. You can seperate data by
commas or newlines and quotes are allowed but not required. Blank lines
and lines starting with # are skipped.

Due to rounding errors, going all the way to the limit may cause some
distortion at the edges. The example formula limits the amplitude to 95%

       =0.95*SIN(2*PI()/1024*$A2)

In English, take a 1/1024 of a full sample, multiply it by the sample #
(N) and take the sine. Then Take 95% of the full value.

By default, the program expects the CSV data to go from 0 to 255. If you
use the -f option, it will accept data from -1.0 to 1.0 and do the scaling
for you. The -f option applies to the entire command line.

The waves subdirectory has some predefined waves for your enjoyment.

NOTE: If you load a channel while it is active, you will have to change
to another channel and then return before you see the change. Apparently,
the instrument loads a working buffer from the channel and does not read
it again until you reselect it.


Install
=======
Just put the following files on your path in the same directory:
* setwave5200
* setwave5200.dat
* setwave5200.awk
* setwave5200.norm.awk

You will also want the xls file and an Excel-compatible spreadsheet program.


Tip
===
If you really want to generate GUI waveforms, register on the TTI site
http://tti1.co.uk/downloads/waveman-plus.htm and download Waveform Manager Plus.
It is free, but you do have to register. It will run well under Wine (although
you will get an error that GPIB is not available). If you export to  "normalized"
file format, you can directly import the result to the MHS-5200A using the
-f option with setwave5200. Just keep the length at 1024.

Example screen shots:

Here's the TTI application creating a cardiac pulse:
![TTI App](https://raw.githubusercontent.com/wd5gnr/mhs5200a/master/images/screenshot_212.png "App View")


Here's the reproduced waveform on a scope:

![Scope](https://raw.githubusercontent.com/wd5gnr/mhs5200a/master/images/cardiac.png "Scope View")

Experimental
============
If you are brave, feel free to try the wavegen script. WARNING: This will NOT
work out of the box for you. You must edit it for your own setup.

What does it do? It creates (or reuses) a directory for you. In my case, I
use ~/dds. It also launches a Waveform editor (in my case, using wine).
By saving an nrm (-1,1) or csv (0,255) file into ~/dds/2 (for example), the
program will download the file to slot #2 and then move the file to
~/dds/2/sent. Since the Waveform editor keeps resetting the directory,
you probably want to set the directory to its default directory.

If you try this and it works for you (or doesn't) let me know. If people
actually use it, I will probably spruce it up a little more.

