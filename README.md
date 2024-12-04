#Welcome House 2 English patch

This includes all the necessary code to patch the game and translate it to English.
Patcher script is Linux only, but it should be easy to replicate the same steps in a .bat in Windows.

## What you'll need:

*	Java and Wine installed on your system.
*	A copy of the game, with the .cue and .bin extracted in the "bin" folder.
*	MD5 for track 1.bin should be aa99387a368d1dd3b790e8cf24ade279

##	You'll also need the following executables in the "tools" folder:
*	armips.exe
*	jpsxdec.jar
*	psxinject.exe (part of the psximager suite)

Simply give run permissions to patcher.py and execute. If everything's in order, it'll patch track 1.bin of the game and you'll be able to play it in English.

##	To-do:
*	Make highlighted text count half-width chars instead of full-width ones (currently avoiding this issue with creative text formatting).
*	Figure out why the text description for the save files is effed up in the PSX's internal memory card manager (but not in emulators), and fix it.

##	Other considerations:

This is my first translation patch ever. It was a dream of mine to translate a game ever since I first found out about fan translations. I did a thorough playtest for proofreading and such, but I probably missed something. Let me know, I'll update the patch in response to feedback.

Feel free to use this code to translate the game to whatever other language you feel like, or whatever. A simple "thank you" would be nice and appreciated, but it's by no means mandatory.
