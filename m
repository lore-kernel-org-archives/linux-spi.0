From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v4 00/10] Port the FSL QSPI driver to the SPI framework
Date: Wed,  7 Nov 2018 15:43:17 +0100
Message-ID: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 shawnguo@kernel.org, marek.vasut@gmail.com, han.xu@nxp.com, broonie@kernel.org,
 Frieder Schrempf <frieder.schrempf@kontron.de>, miquel.raynal@bootlin.com,
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

Patch 1 adds the driver for the Freescale QSPI controller to the SPI
framework. Together with m25p80.c it can be used to interface SPI
NOR flashes just as the old driver did. For this to work properly a few
minor changes to the devicetrees might be necessary (see patches 2 to 5).

Patch 6 changes the defconfigs to use the new driver and patch 9 removes
the old driver.

Patch 8 and 9 remove 'fsl,qspi-has-second-chip' from the devicetrees.
Patch 10 adjusts the MAINTAINERS file.

The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
The read performance of the new driver is almost the same or even better
than the old driver, depending on the block size.
The write performance is a bit slower on average (~10-15%).

The new driver was also tested with the SPI NAND framework [2] and a
Toshiba TC58CVG2S0H flash.

If someone has a board that uses two chips on a single bus, it would be
really nice to have the driver be tested on such a setup.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.18&id=c36ff266dc82f4ae797a6f3513c6ffa344f7f1c7
[2] https://patchwork.ozlabs.org/cover/913728/

---
Changes in v4:
==============
* Rebase on top of v4.20-rc1
* Drop patches that were merged separately
* Address change of company name and email address
* Use readl_poll_timeout() instead of busy waiting
* Revert change to use callback functions for register read/write
* Avoid divide by zero by checking op->dummy.nbytes
* Make big-endian setting SoC-specific and don't read it from devicetree
* Improve some register macros and masks

Changes in v3:
==============
* Move fix for typo in spi-mem.h to a separate patch
* Fix documentation of spi_mem_get_name() and get_name()
* Avoid overwriting the name of the memory device in probe of m25p80
* Add Suggested-by tags

Changes in v2:
==============
* Rebase on top of nand/next
* Add a name field to struct spi_mem and fill it while probing
* Add Yogesh Gaur and Suresh Gupta as authors
* Use GENMASK() for generating bitmasks
* Use callback functions for read/write of registers
* Attach the seq variable to the selected CS
* Avoid using conditional in read/write loop
* Avoid infinite loop and use a timeout instead
* Return error pointer when allocation in fsl_qspi_get_name() fails
* Remove redundant iounmap()
* Put suspend()/resume() in dev_pm_ops instead of platform_driver
* Split the moving and editing of the dt-bindings in two patches
---
Frieder Schrempf (10):
  spi: Add a driver for the Freescale/NXP QuadSPI controller
  dt-bindings: spi: Move the bindings for the FSL QSPI driver
  dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
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
 .../devicetree/bindings/spi/spi-fsl-qspi.txt    |   62 +
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
 drivers/mtd/spi-nor/Kconfig                     |    9 -
 drivers/mtd/spi-nor/Makefile                    |    1 -
 drivers/mtd/spi-nor/fsl-quadspi.c               | 1224 ------------------
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/spi-fsl-qspi.c                      |  948 ++++++++++++++
 20 files changed, 1054 insertions(+), 1317 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
 delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/spi/spi-fsl-qspi.c

-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
