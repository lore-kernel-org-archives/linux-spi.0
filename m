From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 0/6] spi: Add slave mode support
Date: Wed, 22 Jun 2016 15:42:03 +0200
Message-ID: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

	Hi all,

This is a first take at adding support for SPI slave controllers to the
Linux SPI subsystem, including:
  - DT binding updates for SPI slave support,
  - Core support for SPI slave controllers,
  - SPI slave support for the Renesas MSIOF device driver (thanks to
    Nakamura-san for the initial implementation in the R-Car BSP!),
  - Sample SPI slave handlers.

Due to the naure of SPI slave (simultaneous transmit and receive, while
everything runs at the pace of the master), it has hard real-time
requirements: once an SPI transfer is started by the SPI master, a
software SPI slave must have prepared all data to be sent back to the
SPI master.  Hence without additional hardware support, an SPI slave
response can never be a reply to a command being simultaneously
transmitted, and SPI slave replies must be received by the SPI master i=
n
a subsequent SPI transfer.

Examples of possible use cases:
  - Receiving streams of data in fixed-size messages (e.g. from a
    tuner),
  - Receiving and transmitting fixed-size messages of data (e.g. networ=
k
    frames),
  - Sending commands, and querying for responses,
  - ...

Originally I wanted to implement a simple SPI slave handler that could
interface with an existing Linux SPI slave driver, cfr. Wolfram Sang's
I2C slave mode EEPROM simulator for the i2c subsystem.
Unfortunately I couldn't find any existing driver using an SPI slave
protocol that fulfills the above requirements. The Nordic Semiconductor
nRF8001 BLE controller seems to use a suitable protocol, but I couldn't
find a Linux driver for it.  Hence I created two sample SPI slave
protocols and drivers myself:
  1. "spi-slave-time" responds with the time of reception of the
     last SPI message, which can be used by an external microcontroller
     as a dead man's switch.
  2. "spi-slave-system-control" allows remote control of system reboot,
     power off, halt, and suspend.

=46or some use cases, using spidev from user space may be a more approp=
riate
solution than an in-kernel SPI protocol handler.

=46rom the point of view of an SPI slave protocol handler, an SPI slave
controller looks exactly like an ordinary SPI master controller. Hence
"struct spi_master" may have become a misnomer. For now I didn't bother
fixing that.  Should we rename spi_master (and the spi_*master()
functions) to spi_controller? Or create wrappers/defines with "slave"
in their name?

=46or now, the MSIOF SPI slave driver only supports the transmission of
messages with a size that is known in advance (the hardware can provide
an interrupt when CS is deasserted before, though).
I.e. when the SPI master sends a shorter message, the slave won't
receive it.  When the SPI master sends a longer message, the slave will
receive the first part, and the rest will remain in the FIFO.

Handshaking (5-pin SPI, RDY-signal) is optional. An RDY-signal may be
used for one or both of:
  1. The SPI slave asserts RDY when it has data available, and wants to
     be queried by the SPI master.
       -> This can be handled on top, in the SPI slave protocol handler=
,
	  using a GPIO.
  2. After the SPI master has asserted CS, the SPI slave asserts RDY
     when it is ready to accept the transfer.
       -> This may need hardware support in the SPI slave controller,
	  or dynamic GPIO vs. CS pinmuxing.

This patch series applies to both v4.7-rc1 and next-20160622, with the
following 2 patches applied:
      1. [PATCH] spi: Improve DT binding documentation,
      2. [PATCH] spi: sh-msiof: Remove sh_msiof_spi_priv.chipdata.
=46or your convenience, I've pushed this series and its dependencies to
the topic/spi-slave-v1 branch of the git repository at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git

=46or testing, device tree overlays enabling SPI master and slave
controllers on an expansion I/O connector on r8a7791/koelsch are
available in the topic/renesas-overlays branch of my renesas-drivers gi=
t
repository.  Please see http://elinux.org/R-Car/DT-Overlays for more
information about using these overlays.

Test wiring on r8a7791/koelsch, between MSIOF1 and MSIOF2 on EXIO
connector A:
   - Connect pin 48 (MSIOF1 CS#) to pin 63 (MSIOF2 CS#),
   - Connect pin 46 (MSIOF1 SCK) to pin 61 (MSIOF2 SCK),
   - Connect pin 54 (MSIOF1 TX/MOSI) to pin 70 (MSIOF2 RX/MOSI),
   - Connect pin 56 (MSIOF1 RX/MISO) to pin 68 (MSIOF2 TX/MISO).

Example 1:

    # overlay add a-msiof1-spidev
    # overlay add a-msiof2-slave-time
    # spidev_test -D /dev/spidev2.0 -p dummy-8B
    spi mode: 0x0
    bits per word: 8
    max speed: 500000 Hz (500 KHz)
    RX | 00 00 04 6D 00 09 5B BB __ __ __ __ __ __ __ __ __ __ __ __ __=
 __ __ __ __ __ __ __ __ __ __ __  | ...m..[=EF=BF=BD
               ^^^^^    ^^^^^^^^
	       seconds  microseconds

Example 2:

    # overlay add a-msiof1-spidev
    # overlay add a-msiof2-slave-system-control
    # reboot=3D'\x7c\x50'
    # poweroff=3D'\x71\x3f'
    # halt=3D'\x38\x76'
    # suspend=3D'\x1b\x1b'
    # spidev_test -D /dev/spidev2.0 -p $suspend # or $reboot, $poweroff=
, $halt

Thanks for your comments!

Geert Uytterhoeven (5):
  [RFC] spi: Document DT bindings for SPI controllers in slave mode
  [RFC] spi: core: Add support for registering SPI slave controllers
  [RFC] spi: slave: Add SPI slave handler reporting boot up time
  [RFC] spi: slave: Add SPI slave handler controlling system state
  [RFC] spi: spidev: Allow direct references in DT from SPI slave
    controllers

Hisashi Nakamura (1):
  [RFC] spi: sh-msiof: Add slave mode support

 Documentation/devicetree/bindings/spi/spi-bus.txt |  31 +++--
 drivers/spi/Kconfig                               |  26 ++++-
 drivers/spi/Makefile                              |   4 +
 drivers/spi/spi-sh-msiof.c                        |  52 +++++++--
 drivers/spi/spi-slave-system-control.c            | 134 ++++++++++++++=
++++++++
 drivers/spi/spi-slave-time.c                      | 103 ++++++++++++++=
+++
 drivers/spi/spi.c                                 |  39 ++++---
 drivers/spi/spidev.c                              |   3 +-
 include/linux/spi/sh_msiof.h                      |   6 +
 include/linux/spi/spi.h                           |   5 +-
 10 files changed, 360 insertions(+), 43 deletions(-)
 create mode 100644 drivers/spi/spi-slave-system-control.c
 create mode 100644 drivers/spi/spi-slave-time.c

--=20
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
