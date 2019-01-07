From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH v8 0/7] Port the FSL QSPI driver to the SPI framework
Date: Mon, 7 Jan 2019 09:29:39 +0000
Message-ID: <20190107092823.11188-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Now that the SPI memory interface was introduced by Boris, it is
possible to move drivers from mtd/spi-nor to the SPI framework in order
to use them for different type of SPI memory chips.

Patch 1 adds the driver for the Freescale QSPI controller to the SPI
framework. Together with m25p80.c it can be used to interface SPI
NOR flashes just as the old driver did. The new driver replaces the old one by
reusing its Kconfig option.

Patch 2 moves the bindings to the correct place and patch 3 adjusts the
bindings for the new driver.

Patch 4 removes the code of the old driver.

Patch 5 and 6 remove 'fsl,qspi-has-second-chip' from the devicetrees.
Patch 7 adjusts the MAINTAINERS file.

The new driver was tested with the following setups:
* i.MX6UL and a Micron SPI NOR @ 60MHz.
* i.MX6UL and a Toshiba TC58CVG2S0H SPI NAND flash.
* LS1088ARDB with two SPI NOR chips connected to CS0 and CS1 (Yogesh Gaur)
* Other i.MX platforms (Han Xu)

The read performance of the new driver is almost the same or even better
than the old driver, depending on the block size.
The write performance is a bit slower on average (~10-15%).
---
Changes in v8:
==============
* Rebase on top of v5.0-rc1
* Add A-b, R-b and T-b tags
* Update cover letter

Changes in v7:
==============
* Remove unused variables in fsl_qspi_select_mem()
* Update cover letter

Changes in v6:
==============
* Add a quirk for LS2080A SoC to fix multi chip setup
* Use separate area in AHB memory map for each chip
* Add R-b tags for binding changes

Changes in v5:
==============
* Change SoB tags and commit author to new e-mail address
* Drop change in compatible string of bindings
* Reset the AHB domain
* Drop the defconfig changes and reuse the Kconfig option of the old driver
* Remove unused read()/write() pointers from struct fsl_qspi
* Remove unused enum fsl_qspi_devtype
* Fix break condition for fsl_qspi_readl_poll_tout()

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
Frieder Schrempf (7):
  spi: Add a driver for the Freescale/NXP QuadSPI controller
  dt-bindings: spi: Move the bindings for the FSL QSPI driver
  dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
  mtd: fsl-quadspi: Remove the driver as it was replaced by
    spi-fsl-qspi.c
  ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
  ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
  MAINTAINERS: Move the Freescale QSPI driver to the SPI framework

 .../fsl-quadspi.txt => spi/spi-fsl-qspi.txt}  |   18 +-
 MAINTAINERS                                   |    4 +-
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |    1 -
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    1 -
 drivers/mtd/spi-nor/Kconfig                   |    9 -
 drivers/mtd/spi-nor/Makefile                  |    1 -
 drivers/mtd/spi-nor/fsl-quadspi.c             | 1224 -----------------
 drivers/spi/Kconfig                           |   11 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-fsl-qspi.c                    |  966 +++++++++++++
 10 files changed, 988 insertions(+), 1248 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/fsl-quadspi.txt => spi/spi-fsl-qspi.txt} (73%)
 delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/spi/spi-fsl-qspi.c

-- 
2.17.1
