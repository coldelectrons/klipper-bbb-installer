#!/bin/bash
# This script installs Klipper on a Beaglebone running Debian Buster
# for use with its PRU micro-controller.

PYTHONDIR="${HOME}/klippy-env"
SYSTEMDDIR="/lib/systemd/system"
KLIPPER_USER=$USER
KLIPPER_GROUP=$KLIPPER_USER

# Step 1: Install packages
install_packages()
{
    # Install desired packages
    PKGLIST="gcc-pru"
    # Packages for python cffi
    PKGLIST="python-virtualenv virtualenv python-dev libffi-dev build-essential"
    # kconfig requirements
    PKGLIST="${PKGLIST} libncurses-dev"
    # hub-ctrl
    PKGLIST="${PKGLIST} libusb-dev"
    PKGLIST="${PKGLIST} libusb-1.0"
    # XXX 20200615 Fritz:
    # I've commented these out due to the conflict between gcc-avr and gcc-pru
    # and these are of little use on a Beaglebone
    # AVR chip installation and building
    #PKGLIST="${PKGLIST} avrdude gcc-avr binutils-avr avr-libc"
    # ARM chip installation and building
    #PKGLIST="${PKGLIST} stm32flash libnewlib-arm-none-eabi"
    #PKGLIST="${PKGLIST} gcc-arm-none-eabi binutils-arm-none-eabi"

    # Update system package info
    report_status "Running apt-get update..."
    sudo apt-get update

    report_status "Installing packages..."
    sudo apt-get install --yes ${PKGLIST}
}

# Step 2: Create python virtual environment
create_virtualenv()
{
    report_status "Updating python virtual environment..."

    # Create virtualenv if it doesn't already exist
    [ ! -d ${PYTHONDIR} ] && virtualenv ${PYTHONDIR}

    # Install/update dependencies
    ${PYTHONDIR}/bin/pip install -r ${SRCDIR}/scripts/klippy-requirements.txt
}


# Step 3: Install startup script
install_script()
{
    report_status "Installing systemd unit scripts..."
    sudo cp files/pinconfig.service.service ${SYSTEMDDIR}/
    sudo cp files/klipper-firmware.service ${SYSTEMDDIR}/
    sudo cp files/klipper.service ${SYSTEMDDIR}/
# Use systemctl to enable the klipper systemd service script
    sudo systemctl enable pinconfig.service
    sudo systemctl enable klipper-firmware.service
    sudo systemctl enable klipper.service
}

# Step 4: Install pru udev rule
install_udev()
{
    report_status "Installing pru udev rule..."
    sudo /bin/sh -c "cat > /etc/udev/rules.d/pru.rules" <<EOF
KERNEL=="rpmsg_pru30", GROUP="tty", MODE="0660"
EOF
}

# Step 5: Add user to tty group
install_groups()
{
    report_status "Adding $USER to tty group..."
    sudo adduser $USER tty
}

# Helper functions
report_status()
{
    echo -e "\n\n###### $1"
}

verify_ready()
{
    if [ "$EUID" -eq 0 ]; then
        echo "This script must not run as root"
        exit -1
    fi
}

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

# Run installation steps defined above
verify_ready
install_packages
create_virtualenv
#dwc2_patch
install_script
install_udev
install_groups
start_software
