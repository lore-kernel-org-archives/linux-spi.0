From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
Date: Mon, 3 Sep 2018 10:36:00 +0200
Message-ID: <20180903103600.3efabbac@bbrezillon>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180831135807.22255bce@karo-electronics.de>
        <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Yogesh,

On Mon, 3 Sep 2018 04:47:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Lothar,
> 
> > -----Original Message-----
> > From: Lothar Waßmann [mailto:LW@KARO-electronics.de]
> > Sent: Friday, August 31, 2018 5:28 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; mark.rutland@arm.com; robh@kernel.org; linux-
> > kernel@vger.kernel.org; frieder.schrempf@exceet.de;
> > computersforpeace@gmail.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
> > 
> > Hi,
> > 
> > On Fri, 31 Aug 2018 15:59:58 +0530 Yogesh Gaur wrote:  
> > > Add 'size' data variable in spi_device struct.
> > > This is to save the size of the connected slave device.
> > >
> > > After slave device scan, spi_nor_scan, size being assigned to this
> > > from MTD layer.
> > >
> > > SFDP read is being requested before completion of spi_nor_scan()
> > > routine, thus populate device size before making read request to the
> > > SPI controller.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > ---
> > >  drivers/mtd/devices/m25p80.c  | 6 ++++++
> > > drivers/mtd/spi-nor/spi-nor.c | 2 ++
> > >  include/linux/spi/spi.h       | 2 ++
> > >  3 files changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/mtd/devices/m25p80.c
> > > b/drivers/mtd/devices/m25p80.c index fe260cc..6c7ad86 100644
> > > --- a/drivers/mtd/devices/m25p80.c
> > > +++ b/drivers/mtd/devices/m25p80.c
> > > @@ -124,6 +124,10 @@ static ssize_t m25p80_read(struct spi_nor *nor,  
> > loff_t from, size_t len,  
> > >  	/* convert the dummy cycles to the number of bytes */
> > >  	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > >
> > > +	/* for case of SFDP header read commands, populate spi device size */
> > > +	if (flash->spimem->spi->size == 0)
> > > +		flash->spimem->spi->size = nor->mtd.size;
> > > +  
> > If the 'size' is an spimem specific variable it should be added to the spi_mem
> > struct rather than the spi_device struct.  
> 
> Sure, would move 'size' from struct spi_device to the struct spi_mem.

Before you send a new version doing that, I'd like to understand why
you need this information. Can you wait a bit so I have some time to
review the driver?

Thanks,

Boris
