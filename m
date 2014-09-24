From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: pl022: Add support for chip select extension
Date: Wed, 24 Sep 2014 10:23:12 +0100
Message-ID: <20140924092312.GS5182@n2100.arm.linux.org.uk>
References: <20140916183431.GX7960@sirena.org.uk> <1410936418-26443-1-git-send-email-anders.berg@avagotech.com> <20140924083205.GZ4015@sirena.org.uk> <20140924083331.GA4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140924083331.GA4015-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Sep 24, 2014 at 09:33:31AM +0100, Mark Brown wrote:
> On Wed, Sep 24, 2014 at 09:32:05AM +0100, Mark Brown wrote:
> > On Wed, Sep 17, 2014 at 08:46:58AM +0200, Anders Berg wrote:
> > > Add support for a extended PL022 which has an extra register for controlling up
> > > to five chip select signals. This controller is found on the AXM5516 SoC.
> > > Unfortunately the PrimeCell identification registers are identical to a
> > > standard ARM PL022. To work around this, the peripheral ID must be overridden
> > > in the device tree using the "arm,primecell-periphid" property with the value
> > > 0x000b6022.
> > 
> > Applied, thanks.
> 
> Actually there's still the amba/bus.h update in here - I'll hold off for
> a while yet so Russell has a chance to review.

It's fine.  I'd prefer to have seen the vendor list ordered in some way
(since it's neither alphabetical nor numerical with its existing three
entries) but that would be the subject of a separate patch.

Acked-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
