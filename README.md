# riscv_picorv32   
riscv_ISA_toolchain_picorv32----    

Simplicity of RISC-V ISA enables CPU implementation with approximately 8K to 15K gate count, around 47% lower than ARM processors.     
As name defines single CISC instruction can perform many complex tasks while single RISC instruction can perform only single simple tasks     
CISC programs can be smaller at the cost of silicon complexity and high power consumption on the other hand RISC programs can be longer providing ability to run these programs on simpler silicon that requires much less power.    

## Table of Contents

1. [RISCV ISA Base Module with MAFDQC Standard Extensions](#riscv-isa-base-module-with-mafdqc-standard-extensions)
2. [RV32I ISA Encoding](#rv32i-isa-encoding)
3. [RV32 ISA 32 Registers](#rv32-isa-32-registers)
4. [Basic Core of RISCV](#basic-core-of-riscv)
5. [Core with Other Blocks](#core-with-other-blocks)
6. [Installing RISC_V Toolchain for Linux](#installing-risc_v-toolchain-for-linux)
7. [Installation (Newlib/Linux Multilib)](#installation-newlib-linux-multilib)
8. [Testing Toolchain](#testing-toolchain)
9. [Picorv32_core Simulation](#picorv32-core-simulation)
10. [Testing PCPI Interface for Given Multiplication Module](#testing-pcpi-interface-for-given-multiplication-module)
11. [Adding a Module in PICORV32 and Interface It with PCPI](#adding-a-module-in-picorv32-and-interface-it-with-pcpi)
12. [Testing of DOT Product of Floating Point Numbers](#testing-of-dot-product-of-floating-point-numbers)
13. [Future Work](#future-work)
14. [Author](#author)
15. [Contributors](#contributors)
16. [Acknowledgement](#acknowledgement)
17. [Contact Information](#contact-information)
18. [References](#references)


## RISCV ISA Base Module with MAFDQC Standard Extensions 

| Module/Extension      | Description                                           |
|-----------------------|-------------------------------------------------------|
| Base Integer ISA      | RV32I: 32-bit base integer instruction set.           |
|                       | RV64I: 64-bit base integer instruction set.           |
|                       | RV128I: 128-bit base integer instruction set.         |
| M (Integer Multiply/Divide) | Adds integer multiplication and division instructions. |
| A (Atomic Instructions)| Includes atomic memory operations like LR/SC.          |
| F (Single-Precision Floating Point) | Adds single-precision floating-point instructions. |
| D (Double-Precision Floating Point) | Adds double-precision floating-point instructions. |
| Q (Quad-Precision Floating Point)   | Adds quad-precision floating-point instructions.   |
| C (Compressed)        | Introduces a compressed instruction format to reduce code size. |
| B (Bit Manipulation)  | Includes bit manipulation instructions.               |
| J (Jump and Link)     | Adds additional jump and link instructions.           |
| T (Transactional Memory) | Provides support for hardware transactional memory.  |
| P (Packed-SIMD)       | Introduces packed-SIMD instructions.                  |

## RV32I ISA Encoding  

![Screenshot from 2023-12-11 10-57-41](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/c921ae31-a9ac-4106-81b7-69eb67e28bbf)

## rv32 ISA 32 Registers

![Screenshot from 2023-12-11 10-48-46](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/4d2bfee1-00f3-41d4-aa8d-77e689473954)

## Basic Core of RISCV   
![schematic](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/8ed2063b-1a4e-4cae-bfdb-151d1c676795)

## Core with other blocks
![20170601033253-main-cortus-riscv](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/c52c726d-8a04-43b4-b696-9fbc0908fdab)

## Installing RISC_V Toolchain For Linux
This the cross-compiler that is needed to compile your c codes and turn them into executable files(binary file...machine language).

![Screenshot from 2023-10-17 18-46-44](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/ea8cd137-f770-49f2-828a-b908a5a7b8b4)

1. The following prerequisites need to be installed before installing the toolchain
```    
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev      
sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev        
```     
2. Select folder to download tools and other components, and clone git repository. This will create a
folder named “riscv-gnu-toolchain” in the selected path and download all files there.
```
cd riscv_tools    
git clone --recurse-submodules https://github.com/riscv/riscv-gnu-toolchain
```
this will clone toolchain repo in riscv_tools(random name given) and in file name riscv-gnu-toolchain.    

3. Now we need to set the “PATH” and “RISCV” macro to the environment file. This is done so that
next time we can directly call $PATH and $RISCV to point to the installation source. Careful while
selecting the PATH variable, this could cause issues later on if not properly defined. I have selected
the installation source for all my risc-v installations as /opt/riscv/ so my “PATH” will point to
/opt/riscv/bin and “RISCV” to /opt/riscv/.you can give different path where you want your installation should be present.
```
mkdir /opt/riscv/
```
all the installations will be in opt/riscv/      


Check your rc file, this file will be different based on your linux flavour.
Common rc files are ~/.bashrc[If you make changes to ~/.bashrc, those changes will apply to Bash shell sessions. When you open a new terminal or start a new Bash shell session, the modifications in ~/.bashrc will be read and applied.this is default] or ~/.cshrc[If you make changes to ~/.cshrc, those changes will apply to C shell (csh) and its variants (such as tcsh) shell sessions. ] or ~/.zshrc[If you make changes to ~/.zshrc, those changes will apply to Zsh shell sessions].
you can check your shell type by openning terminal and give command
```
echo $SHELL
```

Open up this file and add the below “export” lines     
```
nano ~/.bashrc or vim ~/.bashrc
```
```    
export PATH=/opt/riscv/bin/:$PATH   
export RISCV=/opt/riscv/    
```

If you don't put these 2 lines in the ~/.bashrc(default) file and you just write these 2 export command in terminal them after you close the session(terminal) you will find that the added paths are gone so for permanent effect add them in ~/.bashrc file.
so after adding them save them and close the  ~/.bashrc.    
now we need to source them once for permanently adding these 2 path Next time you open a new terminal, this will have been sourced automatically.
```
source ~/.bashrc
```
4. Move into the riscv-gnu-toolchain folder and build the compiler. The command will differ based on
which compiler you need. Generally we use embedded elf and so we install newlib. You may choose to
install the linux compiler if it suits your needs. The default build is RV64GC (RV64IMAFDC)
```
cd riscv-gnu-toolchain
mkdir build
cd build
```
for riscv 32 bit and a RV64GC (RV64IMAFDC) RISC-V processor architecture with support for both the general-purpose integer instructions and the compressed instruction set extension.
```
../configure --prefix=/opt/riscv  --with-arch=rv32gc --with-abi=ilp32
```
Supported architectures are rv32i or rv64i plus standard extensions (a)tomics, (m)ultiplication and division, (f)loat, (d)ouble, or (g)eneral for MAFD.
Supported ABIs are ilp32 (32-bit soft-float), ilp32d (32-bit hard-float), ilp32f (32-bit with single-precision in registers and double in memory, niche use only), lp64 lp64f lp64d (same but with 64-bit long and pointers).
or configure for basic riscv 32 bit integer type (rv32i)
```
../configure --prefix=$RISCV --with-arch=rv32i (OR you can write --prefix=/opt/riscv means complete address where you want your installations )
```
For 64 bit (The default build is RV64GC (RV64IMAFDC))
```
../configure --prefix=$RISCV
```

#### To build the Newlib cross-compiler
```
sudo make
```
#### To build the Linux cross-compiler
```
sudo make linux
```

## Installation (Newlib/Linux multilib)
To build either cross-compiler with support for both 32-bit and 64-bit, run the following command:
```     
./configure --prefix=/opt/riscv --enable-multilib
```       
And then either make, make linux or make musl for the Newlib, Linux glibc-based or Linux musl libc-based cross-compiler, respectively.

To compile a program, run the following command:    
riscv_compiler_to_use -o out_put_file_name c_file_to_compile    
Example : riscv32-unknown-elf-gcc -o hello hello.c    
it will create a hello.out file as executable binary file so we can run this on simulators (like spike).    


## Testing Toolchain


Run a hello command and test it on spike for printing it.



![Screenshot from 2023-11-03 18-17-41](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/989159a7-5d1c-46a7-91d3-6de7d26b17fd)



Produce ELF 32 Bit LSB executable ,named as 'hello' . and produce hello.asm assembly file ,hello.txt.


![Screenshot from 2023-11-03 22-48-34](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/0b1431ab-9f1f-4481-9a5b-fb11085847d6)

you can check the files -----


![Screenshot from 2023-11-03 19-01-14](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/0dceafea-1074-41d9-99db-ef3eef28836a)


![Screenshot from 2023-12-08 14-54-26](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/30791248-5ac0-481a-9594-823231ac41a0)


Use the linker script firmware/riscv.ld for linking binaries against the newlib library. Using this linker script will create a binary that has its entry point at 0x10000. (The default linker script does not have a static entry point, thus a proper ELF loader would be needed that can determine the entry point at runtime while loading the program.)


```
riscv32-unknown-elf-gcc -nostartfiles -o linked_hello hello.o -lm -T riscv.ld
```

use this above command for linking your design to start entry point at 0x10000.
this will produce ----
![Screenshot from 2023-12-08 14-54-11](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/1f745786-a337-4117-88c4-8ef18b0ac246)


another example of Multiplication in c compile to assembly and then binary--

![Screenshot from 2023-12-08 15-07-21](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/a5211b27-fbc6-4db8-b5b0-4b2e9205a600)

other then executable file like hello we can generate files of different format ----

![Screenshot from 2023-12-08 15-10-00](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/ff25ba14-d026-4df9-8c50-d73097bfc174)


## Picorv32_core Simulation 

Simulating picorv32 core for counter---


Converted the the counter code in c to assembly and then machine code of instructions in 32 bits instructions.saving the istructions on addresses of 32'h00000000,32'h00000004,32'h00000008...like that and saving counter value at address 1020 (32'h000003fc).so counter value will be shown on mem_wdata ,and values will be 0,1,2,3,4...like that,mem_rdata will show counter values and also instruction data.

![Screenshot from 2023-12-09 22-23-52](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/ea2202b7-81db-4dae-9c9d-f1754b1c7c23)

waveform----

![Screenshot from 2023-12-09 22-08-19](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/4a905905-99ae-46cd-b08b-8078d270d746)

## Testing PCPI interface for given multiplication module
some changes before simulation--- ENABLE_PCPI=1;ENABLE_MUL=1;`define PICORV32_REGS picorv32_regs (for register file in extra module)
		dut.cpuregs.rdata1 <= 32'h00000055;	//85
		dut.cpuregs.rdata2 <= 32'h00000006;	//6
      // output = (85*6=510)  = 36'h000001FE;
		#1000;
		dut.cpuregs.rdata1 <= 32'h0000000C;	//12
		dut.cpuregs.rdata2 <= 32'h00000010;	//16
      // output = (12*16=192) = 36'h000000C0;


      
      some delay=2000ns=2us for output to come

      
![Screenshot from 2023-12-11 07-15-37](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/50592412-34c1-47d1-ab9d-f7b38993816a)

## Adding a module in PICORV32 and interface it with PCPI


#### MODULE we will try is dot product of 2 floating point no. ,according to this we can add any module as we want like if we want to add some kind of encription we can do this.


what we have to change here---     
1)ENABLE_PCPI=1;    
2)add a parameter [ 0:0] ENABLE_DOT_PRO = 1, 
3)`define PICORV32_REGS picorv32_regs (for register file in extra module)    
4)
```
generate if(ENABLE_DOT_PRO) begin
		picorv32_pcpi_dot_product pcpi_dp(
            		.clk       (clk            ),
			.resetn    (resetn         ),
			.pcpi_valid(1'b1     ),
			.pcpi_insn (pcpi_insn      ),
			.pcpi_rs1  (pcpi_rs1       ),
			.pcpi_rs2  (pcpi_rs2       ),
			.pcpi_wr   (pcpi_dp_wr    ),
			.pcpi_rd   (pcpi_dp_rd    ),
			.pcpi_wait (pcpi_dp_wait  ),
			.pcpi_ready(pcpi_dp_ready )
        	);
        end else begin
		assign pcpi_dp_wr = 0;
		assign pcpi_dp_rd = 32'bx;
		assign pcpi_dp_wait = 0;
		assign pcpi_dp_ready = 0;
	end endgenerate
 ```

5)edit pcpi_int_wait,pcpi_int_ready

6)add your module and link it to the pcpi. inputs to pcpi_rs1,pcpi_rs2 and pcpi_rd for output register.   

## Testing of DOT Product of Floating Point Numbers   

we are doing here a^2 + b^2

// output = (45.25 * 45.25) + (3.125 * 3.125) = 2057.328125 = 36'h045009540    
// output = (-31.5 * -31.5) + (-7.875 * -7.875) = 1054.265625 = 36'h041F22000    
//output = (-3.125 * -3.125) + (7.25 * 7.25) = 62.328125 = 36'h042795000    


![Screenshot from 2023-12-11 07-51-15](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/da6265df-bf95-4423-a62f-a476bb9aeeb4)   


![Screenshot from 2023-12-11 08-07-11](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/8dba3569-c360-441b-8bb2-e0fa7a671b43)

## Future Work   

1.Addition of UART protocol to picorv32    
2.Use of axi4 lite interface for connecting the IOs and/or memory    
3.Adding Number theoretic transform(NTT) module for homomorphic encryption to picorv32   

## Author  

-Aditya Singh   

## Contributors  
-Dr. Sasirekha GVK    
-Haribabu P     

## Acknowledgement
-prof. Madhav rao    
-prof. Jyotsna Bapat    

## Contact Information
Aditya Singh (aditya.singh@iiitb.ac.in)
-
## References
1) https://github.com/YosysHQ/picorv32
2) https://github.com/Artoriuz/RV32I-SC
3) https://kalaharijournals.com/resources/IJME2021Dec81-100/DEC_91.pdf
4) https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
5) https://github.com/riscv
6) https://github.com/riscvarchive
7) https://riscv.org/technical/specifications/
8) https://kuleuven-diepenbeek.github.io/hwswcodesign-course/100_processor/103_picorv/
9) https://github.com/riscv-software-src/riscv-tools

















