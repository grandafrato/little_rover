# LittleRover

An experimental rover using a RaspberryPi Pico and the AtomVM.

## Build Dependencies

* Elixir & Erlang
* cmake
* ninja
* gcc-arm-none-eabi
* gperf

## Building

We need to build AtomVM and the VM libraries before we can get serious with the
code here.

### AtomVM

1. Clone the latest version of [AtomVM](https://github.com/atomvm/AtomVM.git)
   into a suitable directory.
   ```shell
   git clone https://github.com/atomvm/AtomVM.git && cd AtomVM
   ```
2. Build the VM (remove `-DPICO_BOARD=pico_w` if you're using a Pico without WIFI).
   ```shell
   cd src/platforms/rp2040/
   mkdir build
   cd build
   cmake .. -G Ninja -DPICO_BOARD=pico_w
   ninja
   ```
3. Go back to the root directory (`cd ../../../..`) and build the standard
   libraries.
   ```shell
   mkdir build
   cd build
   cmake .. -G Ninja
   ninja
   ```

### This Project

1. Clone the project parallel to the VM.
   ```shell
   git clone https://gitub.com/grandafrato/little_rover && cd little_rover
   ```
2. Fetch & build project dependencies.
   ```shell
   mix do deps.get + deps.compile
   ```
3. Add the AtomVM standard libraries.
   ```shell
   mkdir avm_deps
   cp ../AtomVM/build/src/libs/atomvmlib.avm avm_deps/atomvmlib.avm
   ```
4. Build the project.
   ```shell
   mix atomvm.packbeam
   ```

# Flashing

Now that we have built the project, we should put the software on the Pico!

1. First, we need to turn the avm file into a uf2.
   ```shell
   ../AtomVM/build/tools/uf2tool/uf2tool create -o little_rover.uf2 -s 0x10100000 little_rover.avm
   ```
2. (optional) If you haven't installed the AtomVM on the Pico before, you will
   need to merge the AtomVM uf2 file with the one you just created.
   ```shell
   ../AtomVM/build/tools/uf2tool/uf2tool join -o rover_final.uf2 ../AtomVM/src/platforms/rp2040/build/src/AtomVM.uf2 little_rover.uf2
   ```
3. Put the Pico into flashing mode by pushing and holding the BOOTSEL button and
   plugging your Pico into a USB port on your computer. Now it should show up as
   a storage device, and you can just move the uf2 file onto it to flash the it.
