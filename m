From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v2 00/12] Port the FSL QSPI driver to the SPI framework
Date: Fri, 6 Jul 2018 05:08:51 +0000
Message-ID: <DB6PR0402MB28385BD243F290AC9C418B2B99470@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "richard@nod.at" <richard@nod.at>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, Han Xu <han.xu@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Content-Language: en-US
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

Hi Frieder,

These patch series also depends on the patches [1][2] for the controller which can't write nor->page_size bytes in single write command step.
Thus, have to invoke Write sequence again and before sending WRITE command, need to send WREN command.

[1] https://patchwork.ozlabs.org/patch/928677/
[2] https://patchwork.ozlabs.org/patch/928678/

--
Regards
Yogesh Gaur.

> -----Original Message-----
> From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
> Sent: Thursday, July 5, 2018 4:45 PM
> To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com; linux-
> spi@vger.kernel.org
> Cc: dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; richard@nod.at; miquel.raynal@bootlin.com;
> broonie@kernel.org; David Wolfe <david.wolfe@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Han Xu <han.xu@nxp.com>;
> shawnguo@kernel.org; Frieder Schrempf <frieder.schrempf@exceet.de>
> Subject: [PATCH v2 00/12] Port the FSL QSPI driver to the SPI framework
> 
> Now that the SPI memory interface was introduced by Boris [1], it is possible to
> move drivers from mtd/spi-nor to the SPI framework in order to use them for
> different type of SPI memory chips.
> 
> Patch 1 adds a function spi_mem_get_name() to the SPI memory interface and a
> ->name field to struct spi_mem.
> Patch 2 uses it in m25p80.c to make it possible for SPI controller drivers to
> provide a custom naming scheme for the flash chip.
> This is needed to avoid breaking compatibility of mtdparts when switching from
> the old to the new driver.
> 
> Patch 3 adds a driver for the Freescale QSPI controller to the SPI framework.
> Together with m25p80.c it can be used to interface SPI NOR flashes just as the
> old driver did. For this to work properly a few minor changes to the devicetrees
> are necessary (see patches 5 to 7).
> 
> Patch 8 changes the defconfigs to use the new driver and patch 9 removes the
> old driver.
> 
> Patch 10 and 11 remove 'fsl,qspi-has-second-chip' from the devicetrees.
> Patch 12 adjusts the MAINTAINERS file.
> 
> The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
> The read performance of the new driver is almost the same or even better than
> the old driver, depending on the block size.
> The write performance is a bit slower on average (~10-15%).
> 
> The new driver was also tested with the SPI NAND framework [2] and a Winbond
> W25M02GV flash.
> 
> If someone has a board that uses both chips selects and/or both busses, it would
> be really nice to have the driver be tested on such a setup.
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fspi.git%2Fcom
> mit%2F%3Fh%3Dfor-
> 4.18%26id%3Dc36ff266dc82f4ae797a6f3513c6ffa344f7f1c7&data=02%7C01%7
> Cyogeshnarayan.gaur%40nxp.com%7C77846565197d44d7413008d5e268ccb2%
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636663862101876439&
> sdata=Y8dyVYysfK3Q6vDXUMEBs%2BBygMxh9qM%2ByWdtk9hGyQU%3D&rese
> rved=0
> [2]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.ozlabs.org%2Fcover%2F913728%2F&data=02%7C01%7Cyogeshnarayan.g
> aur%40nxp.com%7C77846565197d44d7413008d5e268ccb2%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C636663862101876439&sdata=VUE5kVY7V
> DW0a3PKmQvsUC9TyHZUhhntgM1SJC3EUWU%3D&reserved=0
> 
> Changes in v2:
> ==============
> * Rebase on top of nand/next
> * Add a name field to struct spi_mem and fill it while probing
> * Add Yogesh Gaur and Suresh Gupta as authors
> * Use GENMASK() for generating bitmasks
> * Use callback functions for read/write of registers
> * Attach the seq variable to the selected CS
> * Avoid using conditional in read/write loop
> * Avoid infinite loop and use a timeout instead
> * Return error pointer when allocation in fsl_qspi_get_name() fails
> * Remove redundant iounmap()
> * Put suspend()/resume() in struct dev_pm_ops instead of struct platform_driver
> * Split the moving and editing of the dt-bindings in two patches
> 
> Frieder Schrempf (12):
>   spi: spi-mem: Extend the SPI mem interface to set a custom memory name
>   mtd: m25p80: Call spi_mem_get_name() to let controller set a custom
>     name
>   spi: Add a driver for the Freescale/NXP QuadSPI controller
>   dt-bindings: spi: Move the bindings for the FSL QSPI driver
>   dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
>   ARM: dts: Reflect change of FSL QSPI driver and remove unused
>     properties
>   arm64: dts: Reflect change of FSL QSPI driver and remove unused
>     properties
>   ARM: defconfig: Use the new FSL QSPI driver under the SPI framework
>   mtd: fsl-quadspi: Remove the driver as it was replaced by
>     spi-fsl-qspi.c
>   ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
>   ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
>   MAINTAINERS: Move the Freescale QSPI driver to the SPI framework
> 
>  .../devicetree/bindings/mtd/fsl-quadspi.txt     |   65 -
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt    |   65 +
>  MAINTAINERS                                     |    4 +-
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts           |    8 +-
>  arch/arm/boot/dts/imx6sx-sdb.dts                |    8 +-
>  arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |    2 +
>  arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts     |    6 +-
>  arch/arm/configs/imx_v6_v7_defconfig            |    2 +-
>  arch/arm/configs/multi_v7_defconfig             |    2 +-
>  .../boot/dts/freescale/fsl-ls1043a-qds.dts      |    3 +-
>  .../boot/dts/freescale/fsl-ls1046a-qds.dts      |    4 +-
>  .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |    6 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |    1 -
>  .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |    4 +
>  drivers/mtd/devices/m25p80.c                    |    3 +-
>  drivers/mtd/spi-nor/Kconfig                     |    9 -
>  drivers/mtd/spi-nor/Makefile                    |    1 -
>  drivers/mtd/spi-nor/fsl-quadspi.c               | 1217 ------------------
>  drivers/spi/Kconfig                             |   11 +
>  drivers/spi/Makefile                            |    1 +
>  drivers/spi/spi-fsl-qspi.c                      |  954 ++++++++++++++
>  drivers/spi/spi-mem.c                           |   30 +
>  include/linux/spi/spi-mem.h                     |    7 +-
>  23 files changed, 1100 insertions(+), 1313 deletions(-)  delete mode 100644
> Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>  delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c  create mode 100644
> drivers/spi/spi-fsl-qspi.c
> 
> --
> 2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
