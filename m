From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v1 1/7] mtd: spi-nor: fix the wrong dummy value
Date: Thu, 24 Apr 2014 12:50:29 +0800
Message-ID: <20140424045027.GA29664@localhost>
References: <a> <1398248215-26768-2-git-send-email-b32955@freescale.com>
 <201404232141.27005.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201404232141.27005.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 23, 2014 at 09:41:26PM +0200, Marek Vasut wrote:
> On Wednesday, April 23, 2014 at 12:16:49 PM, Huang Shijie wrote:
> > For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then 8.
> > The dummy cycles is actually 8 for SPI fast/dual/quad read.
> > 
> > This patch makes preparations for the DDR quad read, it fixes the wrong
> > dummy value for both the spi-nor.c and m25p80.c.
> > 
> > Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> This patch is actually V2, right ?
yes.

I mentioned it in the cover letter. Since other patches are the V1.
I did not change it to v2.
> 
> > ---
> >  drivers/mtd/devices/m25p80.c  |    5 ++++-
> >  drivers/mtd/spi-nor/spi-nor.c |    2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> > index 1557d8f..693e25f 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -128,9 +128,12 @@ static int m25p80_read(struct spi_nor *nor, loff_t
> > from, size_t len, struct spi_device *spi = flash->spi;
> >  	struct spi_transfer t[2];
> >  	struct spi_message m;
> > -	int dummy = nor->read_dummy;
> > +	unsigned int dummy = nor->read_dummy;
> >  	int ret;
> > 
> > +	/* convert the dummy cycles to the number of byte */
> 
> 'bytes', plural ...
I will change it in the next version.

thanks.

Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
