This is a port of the Commodore 64 version of Qwak. The original was for the BBC Micro, there was a sequel for the Amiga ECS. Later GBA and iOS versions were also made, but the GBA and iOS versions are a bit different. This port sits between the BBC and Amiga versions. 

It was entered into the RGCD C64 16KB Cartridge Game Development Competition 2015, it came 2nd. To be fair the launch version was very buggy. A 1.1 and 1.2 versions were made post compo that fixed a lot of bugs. Then for RESET magazine cover disk a special 1.3 version with more bug fixes and a much needed password system was added in, as I was able to break the 16K limit. A Commodore 128 native version was also made from the 1.3 RESET edition. 

This port has most things working; sprite colour flashing doesn't, as I can't really be bothered. Also the shield timer used a CIA timer combining both A and B timers to make an NMI trigger after about 10 seconds, this doesn’t work on the CX 16 either. 

The graphics are “as they were on the 64” and I’ve been lazy. See the video for details. https://youtu.be/cdpaEtIrpDE

The code is mostly ok, but bear in mind it was written with a 16K limit in mind so something are done in a archaic way to save space, also sometimes more verbose code that uses repeating formats compresses better, so I do some dumb things in places to boost compression. I’ve tried to strip out most of the unused/c64 centric stuff to make it a bit cleaner. I’ve also upgraded the code where possible to use W65C02 spec opcodes. 

Also there is no music or SFX but I have left the calling points in. 

Built and tested on the emulator R34. 
Uses NES style controlls, A is fire and B is jump, dpad as you would expect.

Minimal invocation 
64tass.exe qwak.asm -o qwak.prg -a --mw65c02
But I recommend making a listing file as well, a verbose one as included here. 
64tass.exe qwak.asm -o qwak.prg --no-caret-diag --dump-labels -l qwak.tass -L qwak.list --verbose-list --line-numbers -Wimmediate -a --mw65c02
To convert the bitmap data into VER format, python(3.x) is needed and you will need to have PIL package installed.

see 58mins into the accompanying video for a visual walk through. https://youtu.be/cdpaEtIrpDE

Relaunch64 
Build 
64tass.exe SOURCEFILE -o OUTFILE --no-caret-diag --dump-labels -l SOURCENAME.tass -L SOURCENAME.list --verbose-list --line-numbers -Wimmediate -a --mw65c02 

Run
R64 -iw
64tass.exe SOURCEFILE -o OUTFILE --no-caret-diag --dump-labels -l SOURCENAME.tass -L SOURCENAME.list --verbose-list --line-numbers -Wimmediate -a --mw65c02
<path to emulator here>x16emu.exe -prg OUTFILE -run -debug -joy1 NES
