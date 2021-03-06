#!/bin/sh
# script to start the PRU firmware

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KLIPPER_HOST_MCU=/usr/local/bin/klipper_mcu
KLIPPER_HOST_ARGS="-w -r"
PIDFILE=/var/run/klipper_mcu.pid
RPROC0=/sys/class/remoteproc/remoteproc1
RPROC1=/sys/class/remoteproc/remoteproc2

pru_stop()
{
    # Shutdown existing Klipper instance (if applicable). The goal is to
    # put the GPIO pins in a safe state.
    if [ -c /dev/rpmsg_pru30 ]; then
        echo "Attempting to shutdown PRU..."
        set -e
        ( echo "FORCE_SHUTDOWN" > /dev/rpmsg_pru30 ) 2> /dev/null || ( log_action_msg "Firmware busy! Please shutdown Klipper and then retry." && exit 1 )
        sleep 1
        ( echo "FORCE_SHUTDOWN" > /dev/rpmsg_pru30 ) 2> /dev/null || ( log_action_msg "Firmware busy! Please shutdown Klipper and then retry." && exit 1 )
        sleep 1
        set +e
    fi

    echo "Stopping pru"
        echo 'stop' > $RPROC0/state
        echo 'stop' > $RPROC1/state
}

pru_start()
{
    if [ -c /dev/rpmsg_pru30 ]; then
        pru_stop
    else
        echo 'stop' > $RPROC0/state
        echo 'stop' > $RPROC1/state
    fi
    sleep 1

    echo "Starting pru"
        echo 'klipper_pru0' > $RPROC0/firmware
        echo 'klipper_pru1' > $RPROC1/firmware
        echo 'start' > $RPROC0/state
        echo 'start' > $RPROC1/state
}

pru_start

exit 0
