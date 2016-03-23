From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 14:56:06 +0100
Message-ID: <20160323135606.GE19953@lunn.ch>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
 <20160323132637.GC19953@lunn.ch>
 <20160323133612.GO2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160323133612.GO2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 23, 2016 at 01:36:12PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2016 at 02:26:37PM +0100, Andrew Lunn wrote:
> 
> > The number of windows is limited. On i think the Armada XP, if you put
> > a PCIe device on every available PCIe bus, you can run out of
> > windows. This is why Thomas implemented dynamic allocation of the
> > Windows, so that only those that are needed are used.
> 
> > So i would not statically and globally allocate as many windows as
> > possible SPI devices.
> 
> > The fact that SPI can fall back to another mechanism if there are no
> > available windows, were as PCIe cannot, suggests that SPI should
> > dynamically allocate a window, and be prepared for it to fail.
> 
> > Since only one SPI device can be active at once on a SPI bus, one
> > window per bus makes sense, and keeps the required number of windows
> > to a minimum.
> 
> If we're under pressure for windows I'd go further and say that we
> should be dynamically allocating the windows only when they're actually
> in use (and modifying other drivers to do the same if that makes sense
> for them), unless it's somehow expensive to allocate windows that means
> that we should reduce the overall pressure.

Hi Mark

We are only under pressure in the extremes, i.e 10 PCIe busses in
use. Only allocating PCIe Windows when needed means in practice, we
have not had issues. We need to be mindful, and don't waste them, but
we don't need to consider them a scarce resource.

I don't see it being an issue for the SPI driver to allocate one on
probe and keeping it until release. I probably would object to it
allocating one per chip select line.

   Andrew


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
