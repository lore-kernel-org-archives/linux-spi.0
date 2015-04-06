From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first spi_setup
Date: Mon, 6 Apr 2015 19:58:15 +0200
Message-ID: <F4571783-619C-4664-B14F-207E2D3F60C3@martin.sperl.org>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org> <20150406172913.GW6023@sirena.org.uk> <12F93D4D-EDCB-4F48-B42B-049ECAD7F5E8@martin.sperl.org> <20150406174552.GY6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406174552.GY6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 06.04.2015, at 19:45, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> Requiring every system to update the DT to specify information that we
> can already get easily (and using a less readable format in that update)
> doesn't seem like a clear win for me...

If you prefer that, then apply it - i just wanted to offer both options!

One note though: as most systems will get "deploying" the rpi-foundation
pre-build kernels and their corresponding device tree it seems unlikely 
that a lot of alternate dts will get used...

So when they switch, then >99% of all users will be using the new code
plus the new device-tree that handles that.

That is why I see this as a good example of future bit-rot, where we
have to maintain 20+ lines versus about 5 lines with just a message...


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
