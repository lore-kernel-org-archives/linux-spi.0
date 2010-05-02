From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH v6 0/2] spi: driver for Cirrus EP93xx SPI controller
Date: Sun,  2 May 2010 17:38:58 +0300
Message-ID: <cover.1272805161.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, hartleys@visionengravers.com,
	ryan@bluewatersys.com, martinwguy@gmail.com,
	linux-arm-kernel@lists.infradead.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello,

This series implements SPI master driver for Cirrus Logic EP93xx SPI
controllers.

This is sixth iteration of the driver.

Changes to the previous version:
	- addressed most review comments by H. Hartley Sweeten
	- incorporated GPIO chipselect patch by H. Hartley Sweeten

I tested this on TS-7260 board with at25 and mmc_spi drivers. Now that I have
Sim.One board, which is EP9307 based, I also tested with that (I hacked the
board a bit to get EGPIO9 as a chip select).

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 Documentation/spi/ep93xx_spi                    |   95 +++
 arch/arm/mach-ep93xx/clock.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                     |   53 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   27 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 +
 drivers/spi/Kconfig                             |   10 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  986 +++++++++++++++++++++++
 9 files changed, 1190 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
