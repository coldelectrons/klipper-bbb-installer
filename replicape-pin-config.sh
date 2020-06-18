    #!/bin/sh -e
    # turn off LEDs 1 – 3, only 0 will be on
    echo 0 > /sys/class/leds/beaglebone:green:usr1/brightness
    echo 0 > /sys/class/leds/beaglebone:green:usr2/brightness
    echo 0 > /sys/class/leds/beaglebone:green:usr3/brightness

    # configure i2c
    config-pin p9.19 i2c
    config-pin p9.20 i2c

    # configure P9 GPIO ports
    config-pin p9.11 gpio_input #endstop x2
    config-pin p9.13 gpio_input #endstop z1
    config-pin p9.18 gpio_input #endstop z2
    config-pin p9.23 gpio_input #endstop y1
    config-pin p9.25 gpio_input #endstop x1
    config-pin p9.28 gpio_input #endstop y2
    config-pin p9.24 gpio_input #fault z

    config-pin p9.12 gpio #step_e
    config-pin p9.14 gpio #servo 0
    config-pin p9.16 gpio #servo 1
    config-pin p9.41 gpio #enable

    # configure P8 GPIO ports
    config-pin p8.08 gpio_input #fault h
    config-pin p8.09 gpio_input #fault y
    config-pin p8.18 gpio_input #fault e
    config-pin p8.10 gpio_input #fault x

    config-pin p8.11 gpio #step h
    config-pin p8.12 gpio #step y
    config-pin p8.13 gpio #step z
    config-pin p8.14 gpio #dir z
    config-pin p8.15 gpio #dir e
    config-pin p8.16 gpio #dir h
    config-pin p8.17 gpio #step x
    config-pin p8.19 gpio #dir y
    config-pin p8.26 gpio #dir x

    # configure PWM ports
    #config-pin p9.14 pwm #servo 0
    #config-pin p9.16 pwm #servo 1

    #SPI setup
    config-pin p9.42 spi_cs
    config-pin p9.29 spi
    config-pin p9.30 spi
    config-pin p9.31 spi_sclk

    exit 0
