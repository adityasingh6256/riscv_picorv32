# riscv_picorv32
riscv_ISA_toolchain_picorv32
## INSTALLING RISC-V TOOLCHAIN For Linux-
This the cross-compiler that is needed to compile your c codes and turn them into executable files(binary file...machine language).

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

#### Installation (Newlib/Linux multilib)
To build either cross-compiler with support for both 32-bit and 64-bit, run the following command:
```     
./configure --prefix=/opt/riscv --enable-multilib
```       
And then either make, make linux or make musl for the Newlib, Linux glibc-based or Linux musl libc-based cross-compiler, respectively.

To compile a program, run the following command:    
riscv_compiler_to_use -o out_put_file_name c_file_to_compile    
Example : riscv32-unknown-elf-gcc -o hello hello.c    
it will create a hello.out file as executable binary file so we can run this on simulators (like spike).    


### Testing_Toolchain


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


![Screenshot from 2023-12-08 15-10-00](https://github.com/adityasingh6256/riscv_picorv32/assets/110079790/ff25ba14-d026-4df9-8c50-d73097bfc174)







