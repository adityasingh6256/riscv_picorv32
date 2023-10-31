# riscv_picorv32
riscv_ISA_toolchain_picorv32
## INSTALLING RISC-V TOOLCHAIN For Linux-
This the cross-compiler that is needed to compile your c codes and turn them into executable files(binary file...machine language).

1. The following prerequisites need to be installed before installing the toolchain
```    
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk
build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
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
````   
./configure --prefix=/opt/riscv --enable-multilib
```    
And then either make, make linux or make musl for the Newlib, Linux glibc-based or Linux musl libc-based cross-compiler, respectively.


To compile a program, run the following command:
> riscv_compiler_to_use -o out_put_file_name c_file_to_compile
> Example : riscv32-unknown-elf-gcc -o hello hello.c
it will create a hello.out file as executable binary file so we can run this on simulators (like spike).
