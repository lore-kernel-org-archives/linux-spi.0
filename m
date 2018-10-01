From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Mon, 1 Oct 2018 11:09:46 +0200
Message-ID: <20181001110946.5330a90e@bbrezillon>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180929174023.51b1e284@bbrezillon>
        <7c10ced6-91af-187a-0c34-ce9b3e897e2e@exceet.de>
        <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 1 Oct 2018 09:02:32 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem
> > > *addr) {
> > > 	if (f->big_endian)
> > > 		iowrite32be(val, addr);
> > > 	else
> > > 		iowrite32(val, addr);
> > > }
> > >
> > >
> > > static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> > > 	if (f->big_endian)
> > > 		return ioread32be(addr);
> > > 	else
> > > 		return ioread32(addr);
> > > }  
> > 
> > I introduced the ->read/write() hooks in the QSPI driver because I
> > was told to remove the conditional in the read/write path, but I
> > can't really tell if this really makes any difference.
> >   
> Yes, I have taken these hooks by looking into the comments received
> for Frieder's QSPI patch series. For me this looks more clean and can
> be decided in the controller initialization sequence which hook would
> going to be invoked.


Well, depending on your CPU, the indirect branch (caused by the
function pointer call) might have an higher cost than the conditional
branch. Not sure we care about such micro-optimizations though.
Regarding the readability aspect, I still prefer my version, but I
guess that's a matter of taste.
