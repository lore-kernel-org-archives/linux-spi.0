From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from
 DTS
Date: Tue, 18 Mar 2014 22:04:11 -0500
Message-ID: <1395198251.12479.267.camel@snotra.buserror.net>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
	 <1394789757-40732-2-git-send-email-B48286@freescale.com>
	 <20140314191922.GA366@sirena.org.uk>
	 <c4b28b01b2f544ca9d264eaee2542257@DM2PR03MB301.namprd03.prod.outlook.com>
	 <20140317130109.GE11706@sirena.org.uk>
	 <9186860716f446f9a5773e7e47d39114@DM2PR03MB301.namprd03.prod.outlook.com>
	 <CAMuHMdWHSVPDZ9q9rw0FZqNrR+E0q9pQcYLRiseopoM-K-5svg@mail.gmail.com>
	 <01e4d20dc3d94e2f8f7252225932c774@DM2PR03MB301.namprd03.prod.outlook.com>
	 <1395180522.12479.214.camel@snotra.buserror.net>
	 <83b4fe0227144d3f89543dfa92399dcd@DM2PR03MB301.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: 'Geert Uytterhoeven' <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Hu Mingkai-B21284 <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Hou Zhiqiang-B48286 <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <83b4fe0227144d3f89543dfa92399dcd-ufbTtyGzTTTk7ZsBhlipOOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2014-03-18 at 21:49 -0500, Hou Zhiqiang-B48286 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, March 19, 2014 6:09 AM
> > To: Hou Zhiqiang-B48286
> > Cc: 'Geert Uytterhoeven'; Mark Brown; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org;
> > mark.rutland-5wv7dgnIgG8@public.gmane.org; ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> > grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; Hu Mingkai-B21284
> > Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number
> > from DTS
> > 
> > On Tue, 2014-03-18 at 04:34 -0500, Hou Zhiqiang-B48286 wrote:
> > >
> > > > -----Original Message-----
> > > > From: geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> > > > [mailto:geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > > > On Behalf Of Geert Uytterhoeven
> > > > Sent: Tuesday, March 18, 2014 4:56 PM
> > > > To: Hou Zhiqiang-B48286
> > > > Cc: Mark Brown; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org;
> > > > pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> > > > ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> > > > grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; Wood Scott-B07421; Hu Mingkai-B21284
> > > > Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus
> > > > number from DTS
> > > >
> > > > On Tue, Mar 18, 2014 at 8:40 AM, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org
> > > > <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > > > >> > > The DT already has support for specifying flash layouts,
> > > > >> > > can't those be used (for example via chosen if they're not
> > > > >> > > fixed for the
> > > > board)?
> > > > >> > > Or if it's just picking the correct filesystem then UUIDs and
> > > > >> > > labels are the standard way to do things.
> > > > >>
> > > > >> > The DT specifying flash layouts is ok. There is another way to
> > > > >> > make the flash layouts using command line, but it is not safe
> > > > >> > because of the dynamic bus_num. It is not the reason that the
> > > > >> > way of DT is supported flash layouts, to live the other way
> > unsafe, right?
> > > > >>
> > > > >> This sounds to me like we need a better way of talking about
> > > > >> flash device names on the Linux command line rather than a way to
> > > > >> fix the bus number - for example, being able to refer to them
> > > > >> using a fixed property like the physical address.  Being able to
> > > > >> refer to devices via an alias assigned in the DT would also be
> > > > >> useful (and more readable), I think there may already be a
> > > > >> mechanism for doing that which would need to be plumbed in but I'm
> > not 100% sure.
> > > > >
> > > > > The bus number is the variable designed to distinguish one spi
> > > > > controller from others. Why spi controller's physical address must
> > > > > be use instead of bus number?
> > > >
> > > > Because the bus number is dynamic, while the physical address
> > > > doesn't change, so it can be used to uniqely identify the device
> > > > before booting the kernel.
> > > > Cfr. "spi1" vs. "e6e20000.spi".
> > > >
> > >
> > > The precondition of dynamic bus number is initial it with -1 in the
> > > controller driver. But now I need a reasonable bus number, I don't want
> > a dynamic one.
> > > Why does use the controller's physical address to take the role of bus
> > > number to distinguish controllers.
> > 
> > Where are you going to get this "reasonable" non-dynamic number from?
> > How are you going to ensure there are no conflicts with other SPI
> > controllers (e.g. on a dynamic add-on card)?
> > 
> "other than negative (== assign one dynamically), bus_num is fully
> board-specific.  usually that simplifies to being SOC-specific.
> example:  one SOC has three SPI controllers, numbered 0..2,
> and one board's schematics might show it using SPI-2.  software
> would normally use bus_num=2 for that controller."
> The above paragraph is description of bus_num in spi.h. The "reasonable"
> is from it.
> Other controllers should also include this property, otherwise it will be
> dynamic. So there is not conflict.

So instead of using something concrete like a physical address, you want
to use a number from a manual.  Again, what happens in a system where
SPI controllers can be added dynamically (forget about whether this is
possible on the systems you care about), or even statically from a
different source (e.g. board logic)?  How does the driver know what
number the manual assigns to a given controller?  Why would you even
want to deal with this when using the physical address is so easy?

> > Physical addresses work well because they are tied to something real,
> > rather than an arbitrary enumeration.  Our NAND controllers use the
> > physical address for the MTD name.  Device tree NOR flash allows the
> > device tree to set the mtd name[1], and otherwise falls back on the
> > platform device name, which contains the physical address.
> >
> I know the physical work well, but there is a mechanism of bus number.
> As the description say above, isn't it reasonable?

No.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
