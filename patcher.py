#!/usr/bin/python3
import subprocess

IMAGES = [
	('450', 'OPEN1.IDB[1]'),
	('452', 'OPEN1.IDB[3]'),
	('454', 'OPEN1.IDB[5]'),
	('456', 'OPEN1.IDB[7]'),
	('457', 'OPEN1.IDB[8]'),
	('458', 'OPEN1.IDB[9]'),
	('460', 'OPEN1.IDB[11]'),
	('462', 'OPEN1.IDB[13]'),
	('511', 'RADIO.IDB[0]'),
	('535', 'END2.IDB[2]'),
	('536', 'END2.IDB[3]'),
	('537', 'END2.IDB[4]'),
	('538', 'END2.IDB[5]'),
	('539', 'END2.IDB[6]'),
	('540', 'END2.IDB[7]'),
	('541', 'END2.IDB[8]'),
	('542', 'END2.IDB[9]'),
	('556', 'END2.IDB[23]'),
	('557', 'END2.IDB[24]')
]

if __name__ == '__main__':
	# create index of files in bin image
	print('=============== CREATING BIN IMAGE FILE INDEX ===============')
	subprocess.run('java -jar tools/jpsxdec.jar -f bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\).bin -x bin/wh2.idx', shell = True)
	# extract game executable
	print('=============== EXTRACTING GAME EXECUTABLE ===============')
	subprocess.run('java -jar tools/jpsxdec.jar -x bin/wh2.idx -i 1 -dir exe/', shell = True)
	subprocess.run('mv exe/SLPS_006.33 exe/src_SLPS_006.33', shell = True)
	# patch executable with code and text
	print('=============== PATCHING GAME EXECUTABLE ===============')
	subprocess.run('wine tools/armips.exe main\.asm', shell = True)
	# reinsert patched executable
	print('=============== REINSERTING PATCHED GAME EXECUTABLE ===============')
	subprocess.run('mv bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\).cue bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\).cue', shell = True)
	subprocess.run('wine tools/psxinject.exe -v bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\)\.bin SLPS_006\.33 exe/SLPS_006\.33', shell = True)
	# insert modified images
	print('=============== INSERTING IMAGES ===============')
	for image in IMAGES:
		subprocess.run('java -jar tools/jpsxdec.jar -x bin/wh2.idx -i {} -replacetim pics/{}'.format(image[0], image[1]), shell = True)
	print('=============== SHOULD BE FINISHED ===============')

# java -jar tools/jpsxdec.jar -f bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\).bin -x bin/wh2.idx
# java -jar tools/jpsxdec.jar -x bin/wh2.idx -i 1 -dir exe/
# mv exe/SLPS_006.33 exe/src_SLPS_006.33
# wine tools/armips.exe main\.asm
# mv bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\).cue bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\).cue
# wine tools/psxinject.exe -v bin/Welcome\ House\ 2\ -\ Keaton\ and\ His\ Uncle\ \(Japan\)\ \(Track\ 1\)\.bin SLPS_006\.33 exe/SLPS_006\.33
# java -jar tools/jpsxdec.jar -x bin/wh2.idx -i {} -replacetim {}


