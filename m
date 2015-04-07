From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first spi_setup
Date: Tue, 7 Apr 2015 07:45:30 +0200
Message-ID: <A080E422-054D-401A-9302-389487FA8042@martin.sperl.org>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org> <5523487B.70501@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5523487B.70501-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 07.04.2015, at 05:01, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> I believe the bcm283x have 2 types of SPI controller. There is 1
> instance of the HW that this driver controls (SPI0), and that has CS0,
> CS1. There are two instances of a different SPI HW block (SPI1, SPI2),
> and those each have CS0, CS1, CS2. At least, that's my interpretation of
> the table that shows the pinctrl module's per-pin alternate function values.

Yes and no - SPI1 and SPI2 are a totally different beasts as these are 
"auxiliar devices" that have 2x2 word fifos, no DMA and minimal interrupt
support and use a distinct register layout compared to SPI0. 
See BCM2835 Arm Peripherials page 20-27 for details.

Essentially these are intended to get used for low speed devices or devices
that run short transfers (<4-8 bytes)

So these devices would need a totally separate SPI driver, which this driver
does not and can not handle...

> Should that be an error? Not being able to find the gpiochip implies the
> code can't manipulate the CS lines at all, I think?
Will add an dev_warn_once and contine without optimizations - the code 
still does check for the cs_gpio, so we would run without it? 
It could just be a rename of the pinctrl driver that would trigger this.

You want it as an error?

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
