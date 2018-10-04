From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
Date: Thu, 4 Oct 2018 14:12:04 +0200
Message-ID: <20181004141204.04168a22@bbrezillon>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181004110446.5e1bb255@bbrezillon>
        <VI1PR04MB10380FD9CE99E34BA27E55B699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181004111941.0da33ec0@bbrezillon>
        <VI1PR04MB1038E23CBFE9CFD5C2ECCD3299EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <VI1PR04MB10384B74E6E27435313CC73099EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB10384B74E6E27435313CC73099EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 4 Oct 2018 12:07:17 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Yogesh Narayan Gaur
> > Sent: Thursday, October 4, 2018 2:56 PM
> > To: 'Boris Brezillon' <boris.brezillon@bootlin.com>
> > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com;
> > linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> > mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH 1/4] spi: add support for octal I/O data transfer
> > 
> > Hi Boris,
> >   
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Thursday, October 4, 2018 2:50 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
> > >
> > > On Thu, 4 Oct 2018 09:14:36 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >  
> > > > Hi Boris,
> > > >  
> > > > > -----Original Message-----
> > > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > > Sent: Thursday, October 4, 2018 2:35 PM
> > > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > > > linux-kernel@vger.kernel.org Subject: Re: [PATCH 1/4] spi: add
> > > > > support for octal I/O data transfer
> > > > >
> > > > > Hi Yogesh,
> > > > >  
> [...]
> > > > > > +#define	SPI_RX_OCTAL
> > > > > > 0x2000			/* receive with 8 wires  
> > > > > */  
> > > > > >  	int			irq;
> > > > > >  	void			*controller_state;
> > > > > >  	void			*controller_data;  
> > > > >
> > > > > You're still not updating spi-mem.c to check those flags and
> > > > > SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8
> > > > > instead of 4).
> > > > >  
> > > > Yes and its strange that my octal mode communication is working fine
> > > > without adding support in spi-mem.c and that's why this has been
> > > > missed from me.  
> > >
> > > Are you based on top of spi-next?  
> > 
> > Ok, that might be the reason. I have rebased few days back.
> > Would rebase with current tip and add support in spi-mem interface too.  
> 
> I have rebased spi-next and currently on top but still my octal command support is working fine without any issue with current shared patch series, performed data sanity.
> 
> =>  git log  --pretty=oneline -3  
> 	496c415717b8bb7d37181127fcfad0ba450eb10d mtd: spi-nor: fsl-quadspi: Don't let -EINVAL on the bus
> 	2336d3a7b125683c9e8b25d6efa6064310d19dbe mtd: devices: m25p80: Make sure WRITE_EN is issued before each write
> 	e55841874471282d32eec595997afce43a5f55c0 mtd: spi-nor: Support controllers with limited TX FIFO size
> 
> GIT Repo - 	git://git.infradead.org/linux-mtd.git
> Branch -	remotes/origin/spi-nor/next
> 
> Also, I am not able to find string SPI_MEM_MAX_BUSWIDTH in current source code, can you share the GIT details where these changes are pushed.

It's in Mark's tree [1] (spi-next != spi-nor/next).

[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next
