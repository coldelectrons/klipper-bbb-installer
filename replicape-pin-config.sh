    #!/bin/sh -e
    # turn off LEDs 1 – 3, only 0 will be on
    echo 0 > /sys/class/leds/beaglebone:green:usr1/brightness
    echo 0 > /sys/class/leds/beaglebone:green:usr2/brightness
    echo 0 > /sys/class/leds/beaglebone:green:usr3/brightness

    # configure i2c
    config-pin p9.19 i2c
    config-pin p9.20 i2c

    # configure P9 GPIO ports
    config-pin p9.11 pruin #endstop x2
    config-pin p9.13 pruin #endstop z1
    config-pin p9.18 pruin #endstop z2
    config-pin p9.23 pruin #endstop y1
    config-pin p9.25 pruin #endstop x1
    config-pin p9.28 pruin #endstop y2
    config-pin p9.24 pruin #fault z

    config-pin p9.12 pruout #step_e
    config-pin p9.14 pruout #servo 0
    config-pin p9.16 pruout #servo 1
    config-pin p9.41 pruout #enable

    # configure P8 GPIO ports
    config-pin p8.8 pruin #fault h
    config-pin p8.9 pruin #fault y
    config-pin p8.18 pruin #fault e
    config-pin p8.10 pruin #fault x

    config-pin p8.11 pruout #step h
    config-pin p8.12 pruout #step y
    config-pin p8.13 pruout #step z
    config-pin p8.14 pruout #dir z
    config-pin p8.15 pruout #dir e
    config-pin p8.16 pruout #dir h
    config-pin p8.17 pruout #step x
    config-pin p8.19 pruout #dir y
    config-pin p8.26 pruout #dir x

    # configure PWM ports
    #config-pin p9.14 pwm #servo 0
    #config-pin p9.16 pwm #servo 1

    #SPI setup
    config-pin p9.42 spi_cs
    config-pin p9.29 spi
    config-pin p9.30 spi
    config-pin p9.31 spi_sclk

    exit 0
