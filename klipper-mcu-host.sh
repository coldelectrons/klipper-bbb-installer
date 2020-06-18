#!/bin/sh
# System startup script to start the mcu-host

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KLIPPER_HOST_MCU=/usr/local/bin/klipper_mcu
KLIPPER_HOST_ARGS="-w -r"

mcu_host_stop()
{
    # Shutdown existing Klipper instance (if applicable). The goal is to
    # put the GPIO pins in a safe state.
    if [ -c /tmp/klipper_host_mcu ]; then
        echo "Attempting to shutdown host mcu..."
        set -e
        ( echo "FORCE_SHUTDOWN" > /tmp/klipper_host_mcu ) 2> /dev/null || ( log_action_msg "Firmware busy! Please shutdown Klipper and then retry." && exit 1 )
        sleep 1
        ( echo "FORCE_SHUTDOWN" > /tmp/klipper_host_mcu ) 2> /dev/null || ( log_action_msg "Firmware busy! Please shutdown Klipper and then retry." && exit 1 )
        sleep 1
        set +e
    fi

    echo "Stopping klipper host mcu" $NAME
    pkill $KLIPPER_HOST_MCU
}

mcu_host_start()
{
    [ -x $KLIPPER_HOST_MCU ] || return

    if [ -c /tmp/klipper_host_mcu ]; then
        mcu_host_stop
    fi

    echo "Starting klipper MCU"
    exec $KLIPPER_HOST_MCU $KLIPPER_HOST_ARGS &
}

mcu_host_start

exit 0
