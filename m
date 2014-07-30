From: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] mtd: spi-nor: Correct device-id for n25q512a device
Date: Wed, 30 Jul 2014 04:17:51 +0000
Message-ID: <40bf530c679d46a4a0a73d3d22484f7c@CY1PR0301MB0857.namprd03.prod.outlook.com>
References: <1404795285-2929-1-git-send-email-Priyanka.Jain@freescale.com>
 <CAMuHMdV52qwThCezu=4NCpVBwbM2AjSK4cKXA+BdO=v_Yy2sBQ@mail.gmail.com>
 <20140730041431.GD11952@brian-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140730041431.GD11952@brian-ubuntu>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Brian,

Should I send another patch which just add
> > > +       { "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },
And let the original one as it is ?


Regards
Priyanka


> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, July 30, 2014 9:45 AM
> To: Geert Uytterhoeven
> Cc: Jain Priyanka-B32167; MTD Maling List; linux-spi
> Subject: Re: [PATCH] mtd: spi-nor: Correct device-id for n25q512a device
> 
> Hi Priyanka,
> 
> On Tue, Jul 08, 2014 at 09:38:19AM +0200, Geert Uytterhoeven wrote:
> > CC linux-mtd
> 
> (Thanks for forwarding, Geert)
> 
> > On Tue, Jul 8, 2014 at 6:54 AM, Priyanka Jain
> > <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > > Signed-off-by: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  drivers/mtd/spi-nor/spi-nor.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > b/drivers/mtd/spi-nor/spi-nor.c index c713c86..148bb51d 100644
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -487,7 +487,7 @@ const struct spi_device_id spi_nor_ids[] = {
> > >         { "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
> > >         { "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
> > >         { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
> > > -       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
> > > +       { "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },
> 
> We can't just change the ID, as this would break other devices.
> Apparently there are multiple similar devices with at least two different IDs.
> And we already have this patch queued up in l2-mtd.git (also in linux-next):
> 
> commit c14deddec1fbd8c9757c53a49dbfd2dc83265f21
> Author: grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org <grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
> Date:   Tue Apr 29 10:29:51 2014 -0500
> 
>     mtd: spi-nor: add support for flag status register on Micron chips
> 
> Feel free to test!
> 
> > >
> > >         /* PMC */
> > >         { "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> 
> Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
