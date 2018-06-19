From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 19 Jun 2018 10:46:27 +0200
Message-ID: <20180619104627.31cfd22e@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
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
        <20180618211536.0bf44f55@bbrezillon>
        <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
        <20180619092832.3b6c8f22@bbrezillon>
        <DB6PR0402MB2838FAF5CF0B0883EFAA3A9B99700@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB6PR0402MB2838FAF5CF0B0883EFAA3A9B99700@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 19 Jun 2018 08:31:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > 
> > Could you please use a mailer that is quoting things correctly. I
> > have a hard time differentiating your replies from mine.  
> 
> Sorry for this, have changed my mailer settings.

Thanks for doing. It's still not perfect, but it's definitely better.

> 
> > 
> > On Tue, 19 Jun 2018 07:10:37 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > Let us take below layout of memory address space map.
> > > QuadSPI Controller can access range from 0x2000_0000 -
> > > 0x2FFF_FFFF i.e. 256  
> > MB address space reserved and it is having 4 slave devices
> > connected.  
> > > These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are
> > > connected at below address 0x2000_0000, 0x2400_0000, 0x2A00_0000,
> > > 0x2C00_0000 i.e. there is gap of 32MB from 0x2800_0000 to
> > > 0x29FF_FFFF.  
> > 
> > Okay, I'm fine with pre-reserving 32MB per chip select.
> >   
> > >
> > > As per my understanding of the controller, flash XX top address,
> > > register should  
> > have below values:  
> > >   QUADSPI_SFA1AD - 0x0
> > >   QUADSPI_SFA2AD - 0x400_0000
> > >   QUADSPI_SFB1AD - 0xA00_0000
> > >   QUADSPI_SFB2AD - 0xC00_0000
> > > And Register QUADSPI_SFAR should point to the range for the flash
> > > in which  
> > operation is happening.  
> 
> My mistake values of these register would be for said case are:
> QUADSPI_SFA1AD - 0x400_0000
> QUADSPI_SFA2AD - 0x800_0000
> QUADSPI_SFB1AD - 0xC00_0000
> QUADSPI_SFB2AD - 0x1000_0000
> 
> i.e. as per controller each register is having the Top address for
> serial flash connected at A1/A2/B1/B2 respectively.

This is still wrong ;-). I guess you mean:

QUADSPI_SFA1AD - 0x2400_0000
QUADSPI_SFA2AD - 0x2800_0000
QUADSPI_SFB1AD - 0x2C00_0000
QUADSPI_SFB2AD - 0x3000_0000

> 
> > 
> > Wait, I thought it was supposed to be an absolute address, not one
> > relative to the 0x20000000 offset.
> >   
> > >
> > > Please check Table10-32, page 1657, in [1] for more details on
> > > flash address  
> > assignment.
> > 
> > Yes, I still don't see where it says that having one of the range
> > with a zero size is forbidden, or anything mentioning a required
> > alignment. 
> > >
> > > But say if I assign address to register QUADSPI_SFA2AD as "0 + 2
> > > * -
> > >ahb_buf_size" then this address value is not correct as per the
> > >value range  
> > explained in above mentioned table.
> > 
> > Why? If the SFA1AD is set to zero, that should not, right?  
> What this table says that for TOP_ADDR_MEMA1 defines the top address
> for flash connected at A1 and any address space between
> TOP_ADDR_MEMA1 and QSPI_AMBA_BASE will be routed to Serial Flash A1.
> In my example case TOP_ADDR_MEMA1 is 0x400_0000 If assign value to
> SFAR register is "0 + 2 * ->ahb_buf_size", then this would lie in
> access range of Serial Flash A1 and access happens to A1 flash
> whereas we want access to A2 flash.

No, not if SFA1AD is 0x20000000, because then the address range for CS0
would be 0x20000000 -> 0x20000000.

If you look at the code, you'll see that I adjust the CS mapping
dynamically, making the one being access use the range
0x20000000 -> (0x20000000 + 2 * ->ahb_buf_size) and assigning a 0-size
range for the other ones (either 0x20000000 -> 0x20000000 or
(0x20000000 + 2 * ->ahb_buf_size) -> (0x20000000 + 2 * ->ahb_buf_size))

> 
> For access of serial flash A2, any address space access between
> TOP_ADDR_MEMA2 and TOP_ADDR_MEMA1 would be routed to serial flash A2.
> Thus to access A2 flash, SFAR would be in range from 0x400_0000 and
> 0x800_0000

I understand what you're explaining, what I don't get is why the QSPI
IP doesn't cope with a 0-size range. If you have SFA1AD set to
0x20000000 and SFA2AD set so 0x20000800, I would except any access to
the 0x20000000 -> 0x20000800 range to be routed to CS1 not CS0. But
apparently it's not working like that.
