# 6502
6502 breadboard computer designed by Ben Eater

![image](https://user-images.githubusercontent.com/41388783/214171772-caf244b7-5dfa-4b14-a225-c143d53f99b8.png)

[Ben Eater's YouTube Tutorial](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH)

[Ben Eater's Website](https://eater.net/6502)

## Usage

Once you have the project cloned locally you need to run the python script to build the binary. To do this run the command:
```sh
python makerom.py
```
If you are at a later stage in the project you can assemble the ASM code directly using [vasm](http://sun.hasenbraten.de/vasm/).
```sh
vasm6502_oldstyle -Fbin -dotdir hello_world.s
```
---
You can then verify the contents of the binary by running:
```sh
hexdump -C rom.bin
```
> Note: If running vasm, replace `rom.bin` with `a.out`
---
Now that the binary has been created you can load it onto the ROM chip. I am doing this with software called [minipro](https://gitlab.com/DavidGriffith/minipro). Once the software is installed, all you have to do is run the command below to load the binary to the ROM.
```sh
minipro -p AT28C256 -w rom.bin
```
> Note: If running vasm, replace `rom.bin` with `a.out`

## Questions?

If you have any questions about the project you can reach out to me via email or GitHub with the information below. 

>Email: leithen113@gmail.com 

>GitHub: [Thenlie](https://github.com/Thenlie)

