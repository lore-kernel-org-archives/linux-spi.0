From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Wed, 15 Jul 2015 08:59:46 -0700
Message-ID: <20150715155946.GB21362@localhost>
References: <cover.1433364398.git.hramrach@gmail.com>
 <20150604171547.GA1530@localhost.localdomain>
 <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
 <201507151352.27689.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	"linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201507151352.27689.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Michal,

On Wed, Jul 15, 2015 at 01:52:27PM +0200, Marek Vasut wrote:
> The problem is, if you add a new DT binding, you'd have to support it
> forever, no matter how bad idea that binding turned out to be.

Agreed, and a solid NAK to this patch. I could have sworn I gave such a
response when this was originally being discussed a month ago.

AFAICT, you have one of two general approaches available to you:

1. Fix up the SPI driver so that it knows how to break large SPI
transfers up into smaller segments that its constituent hardware (DMA
controllers, fast clocks, etc.) can handle.

2. Utilize/create a parameter within the SPI subsystem to communicate
that the SPI master has a limited max transfer size (notably: NOT a
per-device DT property, but a SPI API property), and modify SPI device
drivers (like m25p80) to honor it. Mark Brown seemed open to this, and I
thought he suggested it somewhere.

It is most definitely wrong to put this information solely in the slave
device DT (i.e., for the flash), when it is not a property of the flash
device at all. It's a property of the SPI master and/or its clocks and
DMA controllers.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
