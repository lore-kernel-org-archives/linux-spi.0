From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH 00/11] Port the FSL QSPI driver to the SPI framework
Date: Wed, 30 May 2018 15:14:29 +0200
Message-ID: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 Frieder Schrempf <frieder.schrempf@exceet.de>, marek.vasut@gmail.com,
 han.xu@nxp.com, broonie@kernel.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Now that the SPI memory interface was introduced by Boris [1], it is
possible to move drivers from mtd/spi-nor to the SPI framework in order
to use them for different type of SPI memory chips.

Patch 1 adds a function spi_mem_get_name() to the SPI memory interface,
and patch 2 uses it in m25p80.c to make it possible for SPI controller
drivers to provide a custom naming scheme for the flash chip.
This is needed to avoid breaking compatibility of mtdparts when switching
from the old to the new driver.

Patch 3 adds a driver for the Freescale QSPI controller to the SPI
framework. Together with m25p80.c it can be used to interface SPI
NOR flashes just as the old driver did. For this to work properly a few
minor changes to the devicetrees are necessary (see patches 4,5 and 6).

Patch 7 changes the defconfigs to use the new driver and patch 8 removes
the old driver.

Patch 9 and 10 remove 'fsl,qspi-has-second-chip' from the devicetrees.
Patch 11 adjusts the MAINTAINERS file.

The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
The read performance of the new driver is almost the same or even better
than the old driver, depending on the block size.
The write performance is a bit slower on average (~10-15%).

The new driver was also tested with the SPI NAND framework [2] and a
Winbond W25M02GV flash.

If someone has a board that uses both chips selects and/or both busses,
it would be really nice to have the driver be tested on such a setup.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.18&id=c36ff266dc82f4ae797a6f3513c6ffa344f7f1c7
[2] https://patchwork.ozlabs.org/cover/913728/

Frieder Schrempf (11):
  spi: spi-mem: Extend the SPI mem interface to set a custom memory name
  mtd: m25p80: Call spi_mem_get_name() to let controller set a custom
    name
  spi: Add a driver for the Freescale/NXP QuadSPI controller
  dt-bindings: spi: Move and adjust the bindings for the fsl-qspi driver
  ARM: dts: Reflect change of FSL QSPI driver and remove unused
    properties
  arm64: dts: Reflect change of FSL QSPI driver and remove unused
    properties
  ARM: defconfig: Use the new FSL QSPI driver under the SPI framework
  mtd: fsl-quadspi: Remove the driver as it was replaced by
    spi-fsl-qspi.c
  ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
  ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
  MAINTAINERS: Move the Freescale QSPI driver to the SPI framework

 .../devicetree/bindings/mtd/fsl-quadspi.txt     |   65 -
 .../devicetree/bindings/spi/spi-fsl-qspi.txt    |   69 +
 MAINTAINERS                                     |    4 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |    8 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                |    8 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |    2 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts     |    6 +-
 arch/arm/configs/imx_v6_v7_defconfig            |    2 +-
 arch/arm/configs/multi_v7_defconfig             |    2 +-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts      |    3 +-
 .../boot/dts/freescale/fsl-ls1046a-qds.dts      |    4 +-
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |    6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |    1 -
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |    4 +
 drivers/mtd/devices/m25p80.c                    |    3 +-
 drivers/mtd/spi-nor/Kconfig                     |    9 -
 drivers/mtd/spi-nor/Makefile                    |    1 -
 drivers/mtd/spi-nor/fsl-quadspi.c               | 1206 ------------------
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/spi-fsl-qspi.c                      |  929 ++++++++++++++
 drivers/spi/spi-mem.c                           |   25 +
 include/linux/spi/spi-mem.h                     |    3 +
 23 files changed, 1071 insertions(+), 1301 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
 delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/spi/spi-fsl-qspi.c

-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
