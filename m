From: Han Xu <han.xu@nxp.com>
Subject: RE: Questions about the Freescale/NXP QuadSPI controller
Date: Thu, 2 Aug 2018 21:58:48 +0000
Message-ID: <VI1PR0401MB2221D006E89A06B7D343A5E5972C0@VI1PR0401MB2221.eurprd04.prod.outlook.com>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-4-git-send-email-frieder.schrempf@exceet.de>
 <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
 <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "richard@nod.at" <richard@nod.at>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>, David Wolfe
 <david.wolfe@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Prabhakar
 Kushwaha <prabhakar.kushwaha@nxp.com>, Yogesh Narayan Gaur
 <yogeshnarayan.gaur@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
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



> -----Original Message-----
> From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
> Sent: Thursday, August 2, 2018 8:09 AM
> To: David Wolfe <david.wolfe@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Han Xu <han.xu@nxp.com>;
> shawnguo@kernel.org
> Cc: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com; linux-
> spi@vger.kernel.org; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; richard@nod.at;
> miquel.raynal@bootlin.com; broonie@kernel.org
> Subject: Re: Questions about the Freescale/NXP QuadSPI controller
> 
> Ping.
> 
> I'm not sure if my message below went out to you at all. At least I can't find it
> in the ML archive.
> 
> I still hope someone can help with the questions below.
> 
> Meanwhile for the second point I did some tests myself with one chip on
> each of the two buses and it worked fine with my latest v2 patches.
> So I'm not sure at all why Yogesh has problems with his setup (two chips on
> the first bus).

Tried to test the v2 patch set on i.MX6SX SDB board but get the memory map failure.

[    1.298633] fsl-quadspi 21e4000.qspi: ioremap failed for resource [mem 0x70000000-0x7fffffff]
[    1.307330] fsl-quadspi 21e4000.qspi: Freescale QuadSPI probe failed
[    1.313922] fsl-quadspi: probe of 21e4000.qspi failed with error -12

This is the reason why dynamic ioremap added in previous driver, please refer to
 https://patchwork.ozlabs.org/patch/503655/

I cannot really test the functionality in this case, will get another platform without such issue and retry.

> 
> Thanks,
> Frieder
> 
> On 11.07.2018 14:13, Frieder Schrempf wrote:
> > Hi guys from NXP,
> >
> > we still have some issues/questions concerning the FSL QSPI IP, that
> > somehow block the new driver under the SPI memory framework [1].
> >
> > If anyone of you could comment on these, or help finding solutions,
> > this would be very much appreciated.
> >
> > 1. The SPI NOR driver was using a reset of the flash and AHB domain to
> > invalidate the AHB buffer [2]. But this needs quite a lot of time, so
> > we have a hack to use two regions in memory and switch between them
> > alternately to invalidate the cache [3]. As this is not so nice, do
> > you know of any other possibility to invalidate the flash?
> >
> > 2. We tried to reuse the mapped memory to access different chips on
> > different CS, by switching the QUADSPI_SFA1AD, QUADSPI_SFA2AD, etc.
> > accordingly [4]. This doesn't work as expected, but Yogesh found out,
> > that it works with a fixed memory map for each CS and by adding a
> > ioremap(), as the SPI NOR driver does [5]. Can someone explain this
> > behavior and why the ioremap is needed?
> >
> > 3. In case of a NOR page program operation, the driver is expected to
> > write the full page, even if it's larger than the TX buffer size.
> > Boris explained this here: [6].
> > So we need to find a way of triggering a refill of the TX buffer by
> > CPU or DMA if possible.
> >
> > Thank you in advance for your help,
> >
> > Frieder
> >
> > [1]
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> >
> chwork.ozlabs.org%2Fcover%2F939864%2F&amp;data=02%7C01%7Chan.xu
> %40nxp.
> >
> com%7C567dbf7050bc4b38dbea08d5f87925db%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301
> >
> 635%7C0%7C0%7C636688121577481337&amp;sdata=d%2BRazwVOV0z0wJ%
> 2BHrOthM6a
> > 50W0o8omAUOQ%2F3Ji%2Fs6M%3D&amp;reserved=0
> > [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.g
> it%
> > 2Ftree%2Fdrivers%2Fmtd%2Fspi-nor%2Ffsl-quadspi.c%3Fh%3Dv4.18-
> rc4%23n59
> >
> 1&amp;data=02%7C01%7Chan.xu%40nxp.com%7C567dbf7050bc4b38dbea0
> 8d5f87925
> >
> db%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63668812157748
> 1337&amp
> > ;sdata=48yLzR8tBHRgLh1rN1Nw1L45%2FNCe4m6idmzvpbi5jpc%3D&amp;re
> served=0
> >
> > [3]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > hub.com%2Ffschrempf%2Flinux%2Fblob%2Ffsl-qspi-next-
> 2%2Fdrivers%2Fspi%2
> > Fspi-fsl-
> qspi.c%23L511&amp;data=02%7C01%7Chan.xu%40nxp.com%7C567dbf705
> >
> 0bc4b38dbea08d5f87925db%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C6
> >
> 36688121577481337&amp;sdata=lf0Xwxr6RYrs5YHIIf9TO5RbyEgtr1qMus7p0
> vfUgh
> > c%3D&amp;reserved=0
> >
> > [4]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > hub.com%2Ffschrempf%2Flinux%2Fblob%2Ffsl-qspi-next-
> 2%2Fdrivers%2Fspi%2
> > Fspi-fsl-
> qspi.c%23L476&amp;data=02%7C01%7Chan.xu%40nxp.com%7C567dbf705
> >
> 0bc4b38dbea08d5f87925db%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C6
> >
> 36688121577481337&amp;sdata=NYmMKaTsff7%2FZ%2BO7nRjnsIWDFDrAN
> dXZfgpn0H
> > b6Nmw%3D&amp;reserved=0
> >
> > [5]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.g
> it%
> > 2Ftree%2Fdrivers%2Fmtd%2Fspi-nor%2Ffsl-quadspi.c%3Fh%3Dv4.18-
> rc4%23n90
> >
> 6&amp;data=02%7C01%7Chan.xu%40nxp.com%7C567dbf7050bc4b38dbea0
> 8d5f87925
> >
> db%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63668812157748
> 1337&amp
> > ;sdata=BSLjT%2BlwxocGJT3eJ1pUIYxsrBP%2FCdSt0Mthb%2Bx3ySE%3D&am
> p;reserv
> > ed=0
> >
> > [6]
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> >
> chwork.ozlabs.org%2Fpatch%2F928677%2F%231950278&amp;data=02%7C0
> 1%7Chan
> > .xu%40nxp.com%7C567dbf7050bc4b38dbea08d5f87925db%7C686ea1d3bc
> 2b4c6fa92
> >
> cd99c5c301635%7C0%7C0%7C636688121577491349&amp;sdata=LPUHvPVnX
> Qvp7OfIl
> > yH26FADDXqJI7%2B%2FsUClsfrGx7k%3D&amp;reserved=0
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
