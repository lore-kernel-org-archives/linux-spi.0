From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 0/6]
Date: Wed, 17 May 2017 14:47:46 +0200
Message-ID: <1495025272-23930-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi all,

This patch series adds support for SPI slave controllers to the Linux
SPI subsystem, including:
  - DT binding updates for SPI slave support,
  - Core support for SPI slave controllers,
  - SPI slave support for the Renesas MSIOF device driver (thanks to
    Nakamura-san for the initial implementation in the R-Car BSP!),
  - Sample SPI slave handlers.

Due to the nature of SPI slave (simultaneous transmit and receive, while
everything runs at the pace of the master), it has hard real-time
requirements: once an SPI transfer is started by the SPI master, a
software SPI slave must have prepared all data to be sent back to the
SPI master.  Hence without additional hardware support, an SPI slave
response can never be a reply to a command being simultaneously
transmitted, and SPI slave replies must be received by the SPI master in
a subsequent SPI transfer.

Examples of possible use cases:
  - Receiving streams of data in fixed-size messages (e.g. from a
    tuner),
  - Receiving and transmitting fixed-size messages of data (e.g. network
    frames),
  - Sending commands, and querying for responses,
  - ...

Binding an SPI slave handler to the SPI slave device represented by an
SPI slave controller can either be done from DT, or through sysfs.
The latter, which also allows unregistering, is done through a sysfs
virtual file named "slave", cfr. Documentation/spi/spi-summary.

Originally I wanted to implement a simple SPI slave handler that could
interface with an existing Linux SPI slave driver, cfr. Wolfram Sang's
I2C slave mode EEPROM simulator for the i2c subsystem.
Unfortunately I couldn't find any existing driver using an SPI slave
protocol that fulfills the above requirements. The Nordic Semiconductor
nRF8001 BLE controller seems to use a suitable protocol, but I couldn't
find a Linux driver for it.  Hence I created two sample SPI slave
protocols and drivers myself:
  1. "spi-slave-time" responds with the system uptime at the time of
     reception of the last SPI message, which can be used by an external
     microcontroller as a dead man's switch.
  2. "spi-slave-system-control" allows remote control of system reboot,
     power off, halt, and suspend.

For some use cases, using spidev from user space may be a more appropriate
solution than an in-kernel SPI protocol handler, and this is fully
supported.

>From the point of view of an SPI slave protocol handler, an SPI slave
controller looks almost like an ordinary SPI master controller. The only
exception is that a transfer request will block on the remote SPI
master, and may be cancelled using spi_slave_abort().
Hence "struct spi_master" has become a misnomer.  I'll send an RFC
follow-up patch to fix that.

For now, the MSIOF SPI slave driver only supports the transmission of
messages with a size that is known in advance (the hardware can provide
an interrupt when CS is deasserted before, though).
I.e. when the SPI master sends a shorter message, the slave won't
receive it.  When the SPI master sends a longer message, the slave will
receive the first part, and the rest will remain in the FIFO.

Handshaking (5-pin SPI, RDY-signal) is optional, and not yet
implemented.  An RDY-signal may be used for one or both of:
  1. The SPI slave asserts RDY when it has data available, and wants to
     be queried by the SPI master.
       -> This can be handled on top, in the SPI slave protocol handler,
	  using a GPIO.
  2. After the SPI master has asserted CS, the SPI slave asserts RDY
     when it is ready to accept the transfer.
       -> This may need hardware support in the SPI slave controller,
	  or dynamic GPIO vs. CS pinmuxing.

Changes compared to v3:
  - Add Reviewed-by, Acked-by,
  - Add missing kerneldoc for spi_master.slave,
  - Use slave_aborted flag and complete() instead of messing with
    internal completion and thread state,

Changes compared to v2 (highlights only, see individual patches for
more details):
  - In SPI slave mode, represent the (single) slave device again as a
    child of the controller node, which is now optional, and must be
    named "slave" if present,
  - Introduce a separate spi_alloc_slave() function,
  - Replace the SPI_CONTROLLER_IS_SLAVE flag in spi_master.flags by a
    bool in spi_master,
  - Fix cancellation in the spi-sh-msiof driver,
  - Drop "spi: core: Extract of_spi_parse_dt()", which was applied,

Changes compared to v1 (highlights only, see individual patches for
more details):
  - Do not create a child node in SPI slave mode. Instead, add an
    "spi-slave" property, and put the mode properties in the controller
    node.
  - Attach SPI slave controllers to a new "spi_slave" device class,
  - Use a "slave" virtual file in sysfs to (un)register the (single)
    slave device for an SPI slave controller, incl. specifying the slave
    protocol handler,
  - Add cancellation support using spi_master.slave_abort() and
    spi_slave_abort(),
  - Please see the individual patches for more detailed changelog
    information.

Dependencies:
  - Today's spi/for-next,

For your convenience, I've pushed this series and its dependencies to
the topic/spi-slave-v4 branch of the git repository at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git

Full test information is also available on the eLinux wiki
(http://elinux.org/Tests:MSIOF-SPI-Slave).

For testing, device tree overlays enabling SPI master and slave
controllers on an expansion I/O connector on r8a7791/koelsch are
available in the topic/renesas-overlays branch of my renesas-drivers git
repository.  Please see http://elinux.org/R-Car/DT-Overlays for more
information about using these overlays.

Test wiring on r8a7791/koelsch, between MSIOF1 and MSIOF2 on EXIO
connector A:
   - Connect pin 48 (MSIOF1 CS#) to pin 63 (MSIOF2 CS#),
   - Connect pin 46 (MSIOF1 SCK) to pin 61 (MSIOF2 SCK),
   - Connect pin 54 (MSIOF1 TX/MOSI) to pin 70 (MSIOF2 RX/MOSI),
   - Connect pin 56 (MSIOF1 RX/MISO) to pin 68 (MSIOF2 TX/MISO).

Preparation for all examples below:
    # overlay add a-msiof1-spidev # buggy DT: spidev listed directly in DT
    # overlay add a-msiof2-slave

Example 1:

    # echo spi-slave-time > /sys/class/spi_slave/spi3/slave 
    # spidev_test -D /dev/spidev2.0 -p dummy-8B
    spi mode: 0x0
    bits per word: 8
    max speed: 500000 Hz (500 KHz)
    RX | 00 00 04 6D 00 09 5B BB __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __  | ...m..[�
               ^^^^^    ^^^^^^^^
	       seconds  microseconds

Example 2:

    # echo spi-slave-system-control > /sys/class/spi_slave/spi3/slave 
    # reboot='\x7c\x50'
    # poweroff='\x71\x3f'
    # halt='\x38\x76'
    # suspend='\x1b\x1b'
    # spidev_test -D /dev/spidev2.0 -p $suspend # or $reboot, $poweroff, $halt

Example 3:

    # echo spidev > /sys/class/spi_slave/spi3/slave 
    # spidev_test -D /dev/spidev3.0 -p slave-hello-to-master &
    # spidev_test -D /dev/spidev2.0 -p master-hello-to-slave

Thanks!

Geert Uytterhoeven (5):
  spi: Document DT bindings for SPI controllers in slave mode
  spi: core: Add support for registering SPI slave controllers
  spi: Document SPI slave controller support
  spi: slave: Add SPI slave handler reporting uptime at previous message
  spi: slave: Add SPI slave handler controlling system state

Hisashi Nakamura (1):
  spi: sh-msiof: Add slave mode support

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   2 +
 Documentation/devicetree/bindings/spi/spi-bus.txt  |  76 +++++----
 Documentation/spi/spi-summary                      |  27 +++-
 drivers/spi/Kconfig                                |  26 ++-
 drivers/spi/Makefile                               |   4 +
 drivers/spi/spi-sh-msiof.c                         | 111 +++++++++----
 drivers/spi/spi-slave-system-control.c             | 154 ++++++++++++++++++
 drivers/spi/spi-slave-time.c                       | 127 +++++++++++++++
 drivers/spi/spi.c                                  | 179 ++++++++++++++++++---
 include/linux/spi/sh_msiof.h                       |   6 +
 include/linux/spi/spi.h                            |  35 +++-
 11 files changed, 647 insertions(+), 100 deletions(-)
 create mode 100644 drivers/spi/spi-slave-system-control.c
 create mode 100644 drivers/spi/spi-slave-time.c

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
