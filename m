From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
Date: Fri, 8 May 2015 14:34:14 -0700
Message-ID: <20150508213414.GE32500@ld-irv-0074>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
 <CAMuHMdXeen3cU2bb8TXxxtdDjgMCU_FS1Yxdu1b-Tq2xE+x0ZA@mail.gmail.com>
 <554D24DA.8060601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554D24DA.8060601-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 08, 2015 at 03:04:26PM -0600, Stephen Warren wrote:
> On 05/08/2015 02:57 PM, Geert Uytterhoeven wrote:
> >On Fri, May 8, 2015 at 8:43 PM, Brian Norris
> ><computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>On Fri, May 08, 2015 at 10:00:12AM -0600, Stephen Warren wrote:
> >>>On 05/08/2015 12:21 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> >>>>Starting with commits
> >>>>8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" bind=
ing")
> >>>>1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection=
")
> >>>>we have "nor-jedec" binding indicating support for JEDEC identifi=
cation.
> >>>
> >>>The documentation looks quite incomplete. "nor-jedec" sounds like
> >>>it's intended to be something generic. As such, it should be
> >>>documented in e.g.
> >>>Documentation/devicetree/bindings/mtd/nor-jedec.txt, not buried in
> >>>one particular flash device's binding. If it's not intended to be
> >>>generic, why isn't the existing "winbond,w25q32dw" enough?
> >>
> >>It is generic, though there are plenty of additional manufacturer/d=
evice
> >>pairs that could go on top of it. m25p80 was (one of?) the first
> >>supported, so the naming has been based on legacy, and we're in the
> >>process of unwinding a bit of that. If it helps, we could move the =
doc
> >>to .../mtd/spi-nor,nor-jedec.txt or something like that.
> >>
> >>>Equally, "nor-jedec" doesn't sound like the right name. It doesn't
> >>>differentiate between SPI and parallel NOR flash, which presumably
> >>>need different compatible values, since the programming model is
> >>>quite different, and the compatible value is supposed to
> >>>define/imply the SW-visible programming model.
> >>
> >>It's definitely for SPI only. There was much discussion about this =
a
> >>few months back. Somewhere along the way, it was mentioned that the
> >>context (SPI slave is a child of SPI master) would make this clear.=
 I'm
> >>still not sure why we didn't end up with something more descriptive=
,
> >>though, like "spi-nor,nor-jedec".
> >
> >What about "jedec,spi-nor"?
>=20
> That seems unique enough to me, or the options below if they're
> actually applicable.

That could be OK with me. If I can get the magic blessing from the DT
folks, then I'll send patches to update everything.

> >Is this "SERIAL FLASH DISCOVERABLE PARAMETERS (SFDP)"?
> >https://www.jedec.org/standards-documents/docs/jesd216b
> >(Don't have time to register with jedec now...)
> >
> >If yes, "jedec,sfdp"? "jedec,jesd216b"?

It's not SFDP. We're looking at SPI flash that are detected simply by
the READ ID (9Fh) opcode. SFDP is on newer SPI flash which support the
5Ah opcode, for reading a parameter table. (I'd like to support this
soon, actually, and one of those sorts of strings might work.)

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
