From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Mon, 18 Jun 2018 21:15:36 +0200
Message-ID: <20180618211536.0bf44f55@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615155541.4f43e9bb@bbrezillon>
        <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Yogesh,

On Mon, 18 Jun 2018 13:32:27 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com] 
> Sent: Friday, June 15, 2018 7:26 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; dwmw2@infradead.org
> Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broonie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; computersforpeace@gmail.com
> Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
> 
> On Fri, 15 Jun 2018 13:42:12 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Boris,
> > 
> > I am still debugging the issue.
> > With some analysis, able to check that proper values are not being written for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.
> > 
> > In current code, value of map_addr are being assigned to these register.
> >              map_addr = q->memmap_phy +
> >                         2 * q->devtype_data->ahb_buf_size;
> > 
> >      qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> > 
> > But instead of "q->devtype_data->ahb_buf_size" it should be flash size.  
> 
> No, because we're only using 2 * ->ahb_buf_size in the direct mapping for each device, and we're modifying the mapping dynamically based on the selected device. Maybe we got the logic wrong though.
> 
> Yes, for register QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD, we need to save starting actual address from where this flash is getting started.
> Thus, if my first flash size is 64MB, then register QUADSPI_SFA2AD would have value of q->memmap_phy + 0x4000000 i.e. (QUADSPI_SFA1AD + sizeof First Flash)
> If second flash is of size 32MB, then register QUADSPI_SFB1AD would have value of value of QUADSPI_SFA2AD + sizeof second flash.

Again, no, that's not what I'm trying to do, and the fact that it
worked fine with CS0 makes me think you don't need to map the whole
device to get it to work, just 2 * ->ahb_buf_size per device.

> 
> > For my case flash size is 0x4000000 and with this hard coded value I am able to perform Write and Erase operation.
> > One more change, I have to do is adding the flash_size when writing the base_address in SFAR register for case when "mem->spi->chip_select == 1"
> > 	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);  
> 
> I don't want to expose the full device in the direct mapping yet (that's part of the direct-mapping API I posted here [1]). What this version of the driver does is, map only 2 time the ahb_size so that we can bypass the internal cache of the QSPI engine.
> 
> To perform any operation on second flash, we need to provide it's base address should be saved in SFAR register for this particular operation.

That's what we tried to do, we tried to make all CS start at 0 when they
are used and declare unused CS at having a size of 0.

So, say you're trying to access CS1, you should have the following
ranges:

CS0: 0 -> 0 (size = 0)
CS1: 0 -> 2 * ->ahb_buf_size (size = 2 * ->ahb_buf_size)
CS2: 2 * ->ahb_buf_size -> 2 * ->ahb_buf_size (size = 0)
CS3: 2 * ->ahb_buf_size -> 2 * ->ahb_buf_size (size = 0)

now, if you're trying to access CS3:

CS0: 0 -> 0 (size = 0)
CS1: 0 -> 0 (size = 0)
CS2: 0 -> 0 (size = 0)
CS3: 0 -> 2 * ->ahb_buf_size (size = 2 * ->ahb_buf_size)

maybe this approach does not work, but that's not clearly stated as
'not supported' in the datasheet.

> Exposing only 2 time of ahb_size is design decision but value in SFAR register should be correct.
> 
> > 
> > Thus, there should be mechanism or the entry in structure where we can have the information of the size of the connected slave device.  
> 
> Because that's exactly the kind of thing I'd like to avoid. What if the device is bigger than the reserved memory region? What if the sum of all devices does not fit in there? Here I tried to support all cases by just mapping the portion of memory we need.
> 
> So IMO, there should be mechanism to have value of start address of each slave device. This might can be done from DTS entry of each slave device connected to the controller.

Let's not put that in the DT. If we really can't re-use 0 as the start
address and make some ranges 0 in size, then let's reserve 2 *
->ahb_buf_size per chip, and be done with it.

This should leave us enough space in the AHB mem range to then support
temporary direct mappings through the direct mapping API.

Regards,

Boris
