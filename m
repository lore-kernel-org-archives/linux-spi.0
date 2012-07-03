From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v2 00/12] IRQ, GPIO SPI, I2C, etc DTC support
Date: Tue,  3 Jul 2012 16:22:33 +0200
Message-ID: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch set adds Device Tree support for IRQ, GPIOm, SPI, I2C, ATA,
and crypto on Orion based drivers, and makes use of these for kirkwood
devices.  It also adds the ability to boot QNAP TS219 based systems
using device tree.

The SPI DT patches are from Michael Walle, and have been previously
posted. I've addressed the issues raised during the review.

The SPI refactor to use the SPI framework was submitted for merge into
3.5, but due to dependency issues, which are now resolved, the patch
was not accepted. This patch has been modified to remove two NOP
functions, which the SPI framework no longer needs.

v1 -> v2
--------

Changes since the last version are the reworking of the IRQ and GPIO
handling. It has been generalized and should now be applicable to all
Orion platforms. The irqdomain is still layered on top of IRQ generic
chip, since generic chip has not yet gained irqdomain support. The
GPIO interrupts are also handled using an IRQ generic chip, thus a
similar layering is made. This applies to both DT and none DT IRQ and
GPIO controllers.

White space problem as pointed out by Michael Walle have been
corrected.

Andrew Lunn (8):
  ARM: Orion: DT support for IRQ and GPIO Controllers
  SPI: Refactor spi-orion to use SPI framework queue.
  I2C: MV64XXX: Add Device Tree support
  Kirkwood: Add basic device tree support for QNAP TS219.
  ARM: Kirkwood: DTify the watchdog timer.
  ATA: sata_mv: Add device tree support
  ARM: Kirkwood: Use DT to configure SATA device.
  Crypto: CESA: Add support for DT based instantiation.

Michael Walle (4):
  spi-orion: remove uneeded spi_info
  spi-orion: add device tree binding
  ARM: kirkwood: use devicetree for orion-spi
  ARM: kirkwood: use devicetree for SPI on dreamplug

 .../devicetree/bindings/arm/mrvl/intc.txt          |   19 ++
 Documentation/devicetree/bindings/ata/marvell.txt  |   16 ++
 .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 ++
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   32 ++-
 .../devicetree/bindings/spi/spi-orion.txt          |    5 +
 .../devicetree/bindings/watchdog/marvel.txt        |   14 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood-dns320.dts              |    5 +
 arch/arm/boot/dts/kirkwood-dns325.dts              |    5 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   34 +++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |    5 +
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   21 ++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   21 ++
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   77 +++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   62 ++++++
 arch/arm/mach-dove/irq.c                           |   58 ++---
 arch/arm/mach-kirkwood/Kconfig                     |   14 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    1 +
 arch/arm/mach-kirkwood/board-dnskw.c               |    5 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |   46 ----
 arch/arm/mach-kirkwood/board-dt.c                  |   20 +-
 arch/arm/mach-kirkwood/board-ib62x0.c              |    5 -
 arch/arm/mach-kirkwood/board-ts219.c               |   82 +++++++
 arch/arm/mach-kirkwood/common.h                    |    5 +
 arch/arm/mach-kirkwood/irq.c                       |   38 ++--
 arch/arm/mach-mv78xx0/irq.c                        |   22 +-
 arch/arm/mach-orion5x/irq.c                        |   22 +-
 arch/arm/plat-orion/gpio.c                         |  166 +++++++++++----
 arch/arm/plat-orion/include/plat/gpio.h            |   16 +-
 arch/arm/plat-orion/include/plat/irq.h             |    3 +-
 arch/arm/plat-orion/irq.c                          |   40 ++++
 drivers/ata/sata_mv.c                              |   42 ++--
 drivers/crypto/mv_cesa.c                           |   31 ++-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++-
 drivers/spi/spi-orion.c                            |  223 ++++++--------------
 drivers/watchdog/orion_wdt.c                       |    8 +
 38 files changed, 878 insertions(+), 366 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/marvell.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-ts219.c

-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
