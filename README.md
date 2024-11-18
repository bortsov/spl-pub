This is a research project to understand of init_DRAM() function for Allwinner T113-S4 chip on [PBkit101-A SOM](https://pb-embedded.ru/pbkit101-a).

The project is the reduced original project named "spl-pub" in SDK for Allwinner chips from development board manufacturer. There is no public link to their SDK.

Build instruction: `make CROSS_COMPILE="your cross-compiler" p=t113_s4 m=fes ddr=ddr3 fes`

Result in: fes/fes1.bin; it is the firmware for run from SRAM of T113-S4.

Expected behaviour if run this program using [xfel](https://github.com/xboot/xfel) tool: make DDR3 SDRAM initialization, log some info to UART3 and silently exit.

* `sudo ./xfel write 0x00028000 fes1.bin`
* `sudo ./xfel exec  0x000283c8` # see start address for "_start" symbol in linker map file fes/fes1.map

After running this commands, it it possible to use `sunxi-fel` or `xfel` tools to do the usual work; but I don't test `sunxi-fel`.

I change debug log to UART3 (it is "DBUG1" UART connector in PB101-A-BASE development board).
Also I change initialization data of DDR3 SDRAM in fes/main/fes1_head.c file.

This works, in contrast of `sudo ./xfel ddr t113-s4` command and `sunxi-fel` tool.

