From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Sun, 12 Jul 2015 12:10:52 +1000
Message-ID: <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A0A150.3060809-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I am on a business-trip right now, so I can not check the mailing list
that often and my access to a rpi to develop is also limited hence
the V3 patch set took some time to get out of the door and crossed
the responses you had sent.

> On 11.07.2015, at 14:53, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> Hopefully the license of that tar file allows for that. I didn't look.
Well, I just took the values from the released video driver for those values
where doe documentation is obviously wrong - essentially clarifying
the SPI_STAT register on page 25.

> As mentioned elsewhere, I'd hope all the shared aux register
> manipulations can be pushed into a shared driver.

I just found this email after having sent the latest version of the patch
that makes use of syscon/regmap to serialize access to the
 bcm2835_AUX_ENABLE register - that is all that it is really needed for.

>From my perspective it seems that a new driver just would produce
more code (to maintain) for something that the syscon driver already
provides. If someone starts to enable aux-uart, then it could go with
a new framework, but that is still more code that needs to get maintained
than just using syscon as that "shared" driver.

As for hardcoded ids, that may be the case, but I just wanted to keep
Device tree as minimal as necessary...
If we get to that situation then we can easily move that to some
other logic...

Finally with regards to interrupts: these are shared anyway so I
wonder why we would want to write an extra irq chip driver when
it works as is anyway.

If someone thinks that is of a performance advantage then this
extra layer of indirection could get written and we would only need
to change the device-tree to use the new irq vectors instead.

But we are really only talking about 2 drivers and 3 interrupt sources.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
