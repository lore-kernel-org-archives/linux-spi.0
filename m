From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v1 2/7] mtd: spi-nor: add DDR quad read support
Date: Thu, 24 Apr 2014 15:43:51 +0200
Message-ID: <201404241543.51752.marex@denx.de>
References: <a> <201404232145.57404.marex@denx.de> <20140424045332.GB29664@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140424045332.GB29664@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday, April 24, 2014 at 06:53:34 AM, Huang Shijie wrote:
> On Wed, Apr 23, 2014 at 09:45:57PM +0200, Marek Vasut wrote:
> > On Wednesday, April 23, 2014 at 12:16:50 PM, Huang Shijie wrote:
> > > This patch adds the DDR quad read support by the following:
> > >   [1] add SPI_NOR_DDR_QUAD read mode.
> > >   
> > >   [2] add DDR Quad read opcodes:
> > >        SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D
> > >   
> > >   [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
> > >   
> > >       Currently it only works for Spansion NOR.
> > >   
> > >   [3] set the dummy with 8 for DDR quad read.
> > >   
> > >       The m25p80.c can not support the DDR quad read, the SPI NOR
> > > 
> > > controller can set the dummy value in its driver, such as
> > > fsl-quadspi.c.
> > > 
> > > Test this patch for Spansion s25fl128s NOR flash.
> > > 
> > > Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > > 
> > >  drivers/mtd/spi-nor/spi-nor.c |   50
> > > 
> > > +++++++++++++++++++++++++++++++++++++++- include/linux/mtd/spi-nor.h  
> > > |
> > > 
> > >  8 +++++-
> > >  2 files changed, 54 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > b/drivers/mtd/spi-nor/spi-nor.c index 1a12f81..e2f69db 100644
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -74,6 +74,15 @@ static int read_cr(struct spi_nor *nor)
> > > 
> > >  static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
> > >  {
> > >  
> > >  	switch (nor->flash_read) {
> > > 
> > > +	case SPI_NOR_DDR_QUAD:
> > > +		/*
> > > +		 * The m25p80.c can not support the DDR quad read.
> > > +		 * We set the dummy cycles to 8 by default. If the SPI NOR
> > > +		 * controller driver has already set it before call the
> > > +		 * spi_nor_scan(), we just keep it as it is.
> > > +		 */
> > > +		if (nor->read_dummy)
> > > +			return nor->read_dummy;
> > 
> > Can the controller set this variable to zero ?
> 
> The default value of this variable is zero.  It it meaningless to set zero.
> The DDR Quad read definitely will use a non-zero dummy.

Can you back this by some documentation please ?

I mean, I know I am a hardass here, but please understand I'd like to understand 
the decisions that are being made.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
