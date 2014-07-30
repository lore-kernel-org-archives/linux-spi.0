From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mtd: spi-nor: Correct device-id for n25q512a device
Date: Tue, 29 Jul 2014 21:14:31 -0700
Message-ID: <20140730041431.GD11952@brian-ubuntu>
References: <1404795285-2929-1-git-send-email-Priyanka.Jain@freescale.com>
 <CAMuHMdV52qwThCezu=4NCpVBwbM2AjSK4cKXA+BdO=v_Yy2sBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV52qwThCezu=4NCpVBwbM2AjSK4cKXA+BdO=v_Yy2sBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Priyanka,

On Tue, Jul 08, 2014 at 09:38:19AM +0200, Geert Uytterhoeven wrote:
> CC linux-mtd

(Thanks for forwarding, Geert)

> On Tue, Jul 8, 2014 at 6:54 AM, Priyanka Jain
> <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > Signed-off-by: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index c713c86..148bb51d 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -487,7 +487,7 @@ const struct spi_device_id spi_nor_ids[] = {
> >         { "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
> >         { "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
> >         { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
> > -       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
> > +       { "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },

We can't just change the ID, as this would break other devices.
Apparently there are multiple similar devices with at least two
different IDs. And we already have this patch queued up in l2-mtd.git
(also in linux-next):

commit c14deddec1fbd8c9757c53a49dbfd2dc83265f21
Author: grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org <grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Date:   Tue Apr 29 10:29:51 2014 -0500

    mtd: spi-nor: add support for flag status register on Micron chips

Feel free to test!

> >
> >         /* PMC */
> >         { "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
