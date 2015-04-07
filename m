From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 22:28:49 +0200
Message-ID: <2749D1FE-97A3-42C0-BCAC-756732726D10@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org> <5523FA17.6040009@wwwdotorg.org> <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org> <20150407174003.GN6023@sirena.org.uk> <BD11C8AC-F517-4120-BBD6-07618EE86604@martin.sperl.org> <20150407182327.GP6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150407182327.GP6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 07.04.2015, at 20:23, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> No it doesn't.  It creates a single message with two transfers (which is
> what I'd expect any user doing this to do, there are others that don't
> use the SPI helper APIs).
Well after rereading it now - it does copying, so I was making a naiv
assumption that it would do a single transfer, but then there is the
SPI_3WIRE case that is special.

In principle it could run in a single transfer at the cost of some
memory (64 vs. 32 bytes) for anything that is not SPI_3WIRE. But then
spi_transfer is also in the order of 32 bytes....

This definitely would speed up things for a "typical" interrupt-driven
driver implementation using the transfer_one interface, as it would avoid
one interrupt and 2 context switches.

On the other hand this could also get optimized inside the framework at
the cost of copying twice and we would optimize other cases as well.
But that is some other project...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
