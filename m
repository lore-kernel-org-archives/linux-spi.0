From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
 gpio_request_one
Date: Wed, 29 Jul 2015 11:05:05 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D9FF@hhmail02.hh.imgtec.org>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
 <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
 <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw@mail.gmail.com>
 <20150727164015.GB11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Stable kernel (v4.1)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Please find the new patch in http://marc.info/?l=linux-spi&m=143816718611912&w=2

Thanks,
Sifan

> -----Original Message-----
> From: Sifan Naeem
> Sent: 27 July 2015 17:54
> To: 'Mark Brown'; Andrew Bresticker
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Stable kernel (v4.1)
> Subject: RE: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
> gpio_request_one
> 
> Thanks Mark, Andrew.
> 
> I'll rework this and submit a new patch.
> 
> Thanks,
> Sifan
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> > Sent: 27 July 2015 17:40
> > To: Andrew Bresticker
> > Cc: Sifan Naeem; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Stable kernel (v4.1)
> > Subject: Re: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
> > gpio_request_one
> >
> > On Mon, Jul 27, 2015 at 09:34:41AM -0700, Andrew Bresticker wrote:
> > > On Mon, Jul 27, 2015 at 5:11 AM, Sifan Naeem
> > > <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > wrote:
> >
> > > > spfi_setup may be called many times bye the spi framework, but
> > > > gpio_request_one can only be called once without freeing,
> > > > repeatedly calling gpio_request_one will cause an error to be
> > > > thrown, which causes the request to spi_setup to be marked as failed.
> >
> > > > We can simply use gpio_direction_output to set the direction of
> > > > the gpio instead of gpio_request_one to put the gpio in to initial
> > > > state, after which the spi framework can control the chipselect
> > > > line via gpio using gpio_set_value.
> >
> > > I don't think we want to leave the CS GPIOs un-requested.  Instead,
> > > we could either request them all at probe() time (and then set
> > > direction in setup()) or have a per-spi_device flag that indicates
> > > whether or not the GPIO has been requested.
> >
> > Not requesting the GPIOs at all would just be a straight up bug.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
