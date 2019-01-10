From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date: Thu, 10 Jan 2019 05:12:45 +0000
Message-ID: <VI1PR04MB5726A7CD5886403774D870B999840@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
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

> -----Original Message-----
> From: Schrempf Frieder [mailto:frieder.schrempf@kontron.de]
> Sent: Wednesday, January 9, 2019 7:49 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; marek.vasut@gmail.com;
> broonie@kernel.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
> > - Add driver for NXP FlexSPI host controller
> >
> >   FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
> >   which supports two SPI channels and up to 4 external devices.
> >   Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8
> bidirectional data lines)
> >   i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up
> to 8
> >   bidirectional data lines.
> >
> > - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
> >   filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS
> targets.
> >   LX2160ARDB is having two NOR slave device connected on single bus A
> >   i.e. A0 and A1 (CS0 and CS1).
> >   LX2160AQDS is having two NOR slave device connected on separate buses
> >   one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >   Verified this driver on following SPI NOR flashes:
> >     Micron, mt35xu512aba, [Read - 1 bit mode]
> >     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> > .nxp.com%2Fdocs%2Fen%2Freference-
> manual%2FIMXRT1050RM.pdf&amp;data=02%
> >
> 7C01%7Cyogeshnarayan.gaur%40nxp.com%7C791570ed6d914f922a6c08d6763
> d6c96
> > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6368264035242944
> 30&amp;s
> >
> data=WTPdd1W4Tn4g6OOVeVVQylZ1Y72KUohWQ5QMxClwcgc%3D&amp;reser
> ved=0
> > [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fsubmitter%3
> >
> D182097&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C791570
> ed6d91
> >
> 4f922a6c08d6763d6c96%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%
> 7C6368
> >
> 26403524294430&amp;sdata=QoAN4HtiTTD6UmToVwD6CfPyWN0C9nSQTBO3
> bYSXJtY%3
> > D&amp;reserved=0
> >
> > Yogesh Narayan Gaur (5):
> >    spi: spi-mem: Add driver for NXP FlexSPI controller
> >    dt-bindings: spi: add binding file for NXP FlexSPI controller
> >    arm64: dts: lx2160a: add FlexSPI node property
> >    arm64: defconfig: enable NXP FlexSPI driver
> >    MAINTAINERS: add maintainers for the NXP FlexSPI driver
> >
> > Changes for v6:
> > - Rebase on top of v5.0-rc1.
> 
> Your patches don't apply to v5.0-rc1. It seems like you have instead rebased
> onto the for-5.1 or for-next branch of the SPI tree. I guess this is okay, but you
> should have pointed that out correctly here.
> 
Yes, thanks for pointing out.
This patch series is based on 'for-next' branch of SPI tree repo [1].
Actually, I got confused with the Makefile content and that's why mentioned in comment as "Rebase on top of v5.0-rc1", sorry for confusion.
	VERSION = 5
	PATCHLEVEL = 0
	SUBLEVEL = 0
	EXTRAVERSION = -rc1

--
Regards
Yogesh Gaur
[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/

> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Updated s-b tag in all patches.
> > Changes for v5:
> > - Rebase on top of v4.20-rc2
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v4:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Incorporated binding file review comments.
> > Changes for v3:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v2:
> > - Incorporated Boris review comments and drop below patches as per the
> comments.
> >   - Patch 'spi: add slave device size in spi_device struct'
> >   - Patch 'spi: add flags for octal I/O data transfer'
> > - Incorporated DTS and Binding file review comments of Shawn Guo and Rob
> Herring.
> >
> >   .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
> >   MAINTAINERS                                   |    7 +
> >   .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
> >   .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
> >   arch/arm64/configs/defconfig                  |    1 +
> >   drivers/spi/Kconfig                           |   10 +
> >   drivers/spi/Makefile                          |    1 +
> >   drivers/spi/spi-nxp-fspi.c                    | 1095 +++++++++++++++++
> >   8 files changed, 1188 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >   create mode 100644 drivers/spi/spi-nxp-fspi.c
> >
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
