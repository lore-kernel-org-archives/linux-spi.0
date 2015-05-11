From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
Date: Mon, 11 May 2015 15:46:46 -0700
Message-ID: <20150511224646.GJ32500@ld-irv-0074>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
 <CAMuHMdXeen3cU2bb8TXxxtdDjgMCU_FS1Yxdu1b-Tq2xE+x0ZA@mail.gmail.com>
 <554D24DA.8060601@wwwdotorg.org>
 <20150508213414.GE32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150508213414.GE32500@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi DT maintainers,

On Fri, May 08, 2015 at 02:34:14PM -0700, Brian Norris wrote:
> On Fri, May 08, 2015 at 03:04:26PM -0600, Stephen Warren wrote:
> > On 05/08/2015 02:57 PM, Geert Uytterhoeven wrote:
> > >On Fri, May 8, 2015 at 8:43 PM, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>On Fri, May 08, 2015 at 10:00:12AM -0600, Stephen Warren wrote:
> > >>>Equally, "nor-jedec" doesn't sound like the right name. It doesn't
> > >>>differentiate between SPI and parallel NOR flash, which presumably
> > >>>need different compatible values, since the programming model is
> > >>>quite different, and the compatible value is supposed to
> > >>>define/imply the SW-visible programming model.
> > >>
> > >>It's definitely for SPI only. There was much discussion about this a
> > >>few months back. Somewhere along the way, it was mentioned that the
> > >>context (SPI slave is a child of SPI master) would make this clear. I'm
> > >>still not sure why we didn't end up with something more descriptive,
> > >>though, like "spi-nor,nor-jedec".
> > >
> > >What about "jedec,spi-nor"?
> > 
> > That seems unique enough to me, or the options below if they're
> > actually applicable.
> 
> That could be OK with me. If I can get the magic blessing from the DT
> folks, then I'll send patches to update everything.

Can I get an 'ack' for this change? We merged a binding for "nor-jedec"
in 4.1-rc1, with review (but no explicit 'ack') from Mark, and a few
DTS's are starting to use it. But we're now seeing objections, with a
request to change this to "jedec,spi-nor". I don't care too much, but I
can understand Stephen's point.

Anyway, I don't want to go through too many more patch cycles without an
explicit ack here on the "jedec,spi-nor" binding (i.e.,
s/nor-jedec/jedec,spi-nor/g). With an ack, then I can make sure the
binding and current users get changed before 4.1 is minted, and prevent
other ARM subarchitectures from pulling in the "wrong" binding for 4.2.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
