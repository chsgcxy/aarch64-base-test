# a64-base-tests

this is the aarch64 base test cases.

it include below tests:

- hello_world
- arm_ok wfi
- config_check
- max_power
- max_power_L2
- cache_miss
- dhrystone
- insts

only dhrystone was added to makefile, you can select which to be added in top level makefile about line 134~135

```makefile
aarch64_tests = dhrystone
# aarch64_tests = hello_world arm_ok wfi config_check max_power max_power_L2 cache_miss dhrystone
```

## before build

before build this, you should make sure that aarch64-none-elf- toolchains are installed correctly.
you can download arm toolchains from [Downloads | GNU-A Downloads – Arm Developer](https://developer.arm.com/downloads/-/gnu-a)

After decompress the package you download, add bin/ to your PATH in your .bashrc

## build target

just make on the top level
then you can find target on aarch64/dhrystone/
there are two target file

- dhrystone.elf  The executable file
- dhrystone.dump  The disassembly file for debug

## about insts

we also support insts test, you can find this under dir aarch64/insts
you can build insts use aarch64/insts/Makefile
