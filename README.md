This is a Docker environment for cross-compiling Ada arm-eabi binaries on x86_64.

# Getting started

    docker build -t ada-builder .

# Building arm-eabi projects

Assuming all of your dependencies are in the Alire index, this command will build the project in your working directory.

    docker run --rm -t -i -v $PWD:/build alr build

## With dependencies not in the public Alire index

The easiest way to do this is to write a shell script to be executed in the build environment. The following example shows how to build the pico_examples project with local copies of its dependencies.

### pico-build.sh
```shell
#!/bin/bash

git clone --depth=1 https://github.com/JeremyGrosser/rp2040_hal
git clone --depth=1 https://github.com/JeremyGrosser/pico_bsp
git clone --depth=1 https://github.com/JeremyGrosser/pico_examples

cd pico_examples
	alr -n pin -f --use=../pico_bsp pico_bsp
	alr -n pin -f --use=../rp2040_hal rp2040_hal
	alr build
```

	docker run --rm -t -i -v $PWD:/build ada-builder ./pico-build.sh
