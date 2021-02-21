#!/bin/bash

git clone --depth=1 https://github.com/JeremyGrosser/rp2040_hal
git clone --depth=1 https://github.com/JeremyGrosser/pico_bsp
git clone --depth=1 https://github.com/JeremyGrosser/pico_examples

cd pico_examples
    alr -n pin -f --use=../pico_bsp pico_bsp
    alr -n pin -f --use=../rp2040_hal rp2040_hal
    alr build
