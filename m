From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Fri, 25 Jul 2014 22:45:14 +0100
Message-ID: <20140725224514.10f13885@alan.etchedpixels.co.uk>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
	<5426556.OzZIXLrofJ@wuerfel>
	<1406285147.8530.13.camel@smile.fi.intel.com>
	<5237362.DJsH7MtqlU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5237362.DJsH7MtqlU@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> The current plan I think is to convert all platforms to use DT
> or ACPI so they get the right data from tables passed by the
> platform. I'm a bit puzzled about why Intel wants to support the
> non-ACPI non-DT case again. If we have to support this case anyway,
> what good will ACPI do us on those platforms?

Because some industries move very very slowly so still don't believe in
requiring ACPI or ACPI capable operating systems.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
