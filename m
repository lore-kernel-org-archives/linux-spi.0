From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: Questions about the Freescale/NXP QuadSPI controller
Date: Thu, 6 Sep 2018 12:22:56 +0000
Message-ID: <VI1PR04MB10385D8A5E3E8ED9BFE35FCA99010@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-4-git-send-email-frieder.schrempf@exceet.de>
 <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
 <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
 <VI1PR0401MB2221D006E89A06B7D343A5E5972C0@VI1PR0401MB2221.eurprd04.prod.outlook.com>
 <20180804153728.0a99d28f@bbrezillon>
 <VI1PR04MB1038E34911BD570AFC9A45F699010@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20180906133600.404a22f4@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "richard@nod.at" <richard@nod.at>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 David Wolfe <david.wolfe@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Han Xu <han.xu@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180906133600.404a22f4@bbrezillon>
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

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, September 6, 2018 5:06 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> marek.vasut@gmail.com
> Cc: Han Xu <han.xu@nxp.com>; Frieder Schrempf
> <frieder.schrempf@exceet.de>; David Wolfe <david.wolfe@nxp.com>; Fabio
> Estevam <fabio.estevam@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; shawnguo@kernel.org; linux-
> mtd@lists.infradead.org; linux-spi@vger.kernel.org; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; miquel.raynal@bootlin.com;
> broonie@kernel.org
> Subject: Re: Questions about the Freescale/NXP QuadSPI controller
> 
> On Thu, 6 Sep 2018 11:11:57 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Saturday, August 4, 2018 7:07 PM
> > > To: Han Xu <han.xu@nxp.com>
> > > Cc: Frieder Schrempf <frieder.schrempf@exceet.de>; David Wolfe
> > > <david.wolfe@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> > > Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Yogesh Narayan
> Gaur
> > > <yogeshnarayan.gaur@nxp.com>; shawnguo@kernel.org; linux-
> > > mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> > > dwmw2@infradead.org; computersforpeace@gmail.com;
> > > marek.vasut@gmail.com; richard@nod.at; miquel.raynal@bootlin.com;
> > > broonie@kernel.org Subject: Re: Questions about the Freescale/NXP
> > > QuadSPI controller
> > >
> > > Hi Han,
> > >
> > > On Thu, 2 Aug 2018 21:58:48 +0000
> > > Han Xu <han.xu@nxp.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
> > > > > Sent: Thursday, August 2, 2018 8:09 AM
> > > > > To: David Wolfe <david.wolfe@nxp.com>; Fabio Estevam
> > > > > <fabio.estevam@nxp.com>; Prabhakar Kushwaha
> > > > > <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur
> > > > > <yogeshnarayan.gaur@nxp.com>; Han Xu <han.xu@nxp.com>;
> > > > > shawnguo@kernel.org
> > > > > Cc: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > > > > linux- spi@vger.kernel.org; dwmw2@infradead.org;
> > > > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > > > richard@nod.at; miquel.raynal@bootlin.com; broonie@kernel.org
> > > > > Subject: Re: Questions about the Freescale/NXP QuadSPI
> > > > > controller
> > > > >
> > > > > Ping.
> > > > >
> > > > > I'm not sure if my message below went out to you at all. At
> > > > > least I can't find it in the ML archive.
> > > > >
> > > > > I still hope someone can help with the questions below.
> > > > >
> > > > > Meanwhile for the second point I did some tests myself with one
> > > > > chip on each of the two buses and it worked fine with my latest
> > > > > v2 patches. So I'm not sure at all why Yogesh has problems with
> > > > > his setup (two chips on the first bus).
> > > >
> > > > Tried to test the v2 patch set on i.MX6SX SDB board but get the
> > > > memory map
> > > failure.
> > > >
> > > > [    1.298633] fsl-quadspi 21e4000.qspi: ioremap failed for
> > > > resource [mem
> > > 0x70000000-0x7fffffff]
> > > > [    1.307330] fsl-quadspi 21e4000.qspi: Freescale QuadSPI probe
> > > > failed [    1.313922] fsl-quadspi: probe of 21e4000.qspi failed
> > > > with error -12
> > > >
> > > > This is the reason why dynamic ioremap added in previous driver,
> > > > please refer to
> > > >
> > > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2
> > > > Fpat
> > > >
> > >
> chwork.ozlabs.org%2Fpatch%2F503655%2F&amp;data=02%7C01%7Cyogeshnar
> > > ayan
> > > > .gaur%40nxp.com%7Caed89ff1b0ac4936acd408d5fa0f7303%7C686ea1d3
> bc2
> > > b4c6fa
> > > >
> > >
> 92cd99c5c301635%7C0%7C0%7C636689866643724038&amp;sdata=lZnBc0m%
> > > 2BOp8yY
> > > > JBFcNBEa2HSoNMhmJjeM9cIoGeVs0E%3D&amp;reserved=0
> > >
> > > We can reduce the size of the iomap to 2k * 4, since this is all we
> > > use currently. Can you try to change the size of the ioremap call to
> > > 16k and tell us if it works.
> > >
> > > Unrelated to this issue, we still have 2 questions left unanswered:
> > >
> > > 1/ is there an easy way to invalidate AHB buffers? I mean, not
> > >    something that implies a full reset + several milliseconds of
> > > delay after the reset. Right now we trick the caching logic by
> > > mapping a portion that is twice the size of the buffer and switching
> > > from one sub-portion to this other to trigger a real read on each
> > > read access, but that's hack-ish, and I'd be surprised if HW
> > >    engineers hadn't planned for this "manual AHB buffer flush" case.
> > >
> >
> > I had a discussion with the HW IP owner, they said that IP command and
> > AHB command are two separate sets of accessing method to flash.
> > Memory coherency between IP and AHB command can't be maintained by the
> > hardware. So after every IP data write command (write, erase, write
> > reg) AHB RX buffer needs to be flushed.
> >
> > Software Reset is the safest way to achieve this.
> > Adding of the delay in several millisecond after setting of the Reset
> > Bits is too conservative, can be tried with the reduced value.
> 
> Do you know exactly how many cycles/nanoseconds we should wait? Is there a
> status reg that says when the block is ready to be used again?
> 

There is no specific cycles being mentioned in document and this was the design issue to not having these bits as w1c or any reg which provides the status.
Needs to explicitly set the RESET bits, wait for some time and then reset the RESET bit with 0.
We need to come-out with nanosecond number with the experiment.

> >
> > > 2/ if we use DMA, do you know what happens when the TX FIFO runs out
> > >    of data while the TX request is not finished yet. In PIO mode, it
> > >    seems the engine sends garbage on the bus when that happens, and
> > > we definitely don't want that.
> >
> > For this query, they have said TX FIFO is the max limit, if data send
> > more than TX FIFO size then it would results in un-defined behavior
> > and there would be data corruption.
> 
> Okay.
> Marek, I guess we have a good reason to accept patch [1] now.

Thanks

Regards
Yogesh Gaur

> 
> [1]https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fpatch%2F928677%2F&amp;data=02%7C01%7Cyogeshnara
> yan.gaur%40nxp.com%7Cf8c6c7f0083c4ddf0e0708d613ecec3c%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C636718305631257433&amp;sdata=3sI
> wpOn4pXDNsqfPSpJqLXKerll%2BoJ1i%2FV3WMY9cx5s%3D&amp;reserved=0

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
