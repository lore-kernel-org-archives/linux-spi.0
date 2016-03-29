From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 29 Mar 2016 21:49:09 +0200
Message-ID: <21028994.N5ajfyoUoV@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de> <29105031.S6XB0bXn2i@wuerfel> <20160329164758.GQ2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160329164758.GQ2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 29 March 2016 09:47:58 Mark Brown wrote:
> 
> > I think it makes a lot of sense to define a separate window for each CS
> > at boot time, just so you don't have to reprogram the windows manually.
> > After all, the entire point of the direct mode is to avoid having to
> > do any of the setup work, and have the SPI master set the right CS
> > itself based on the MBus ID that is used for accessing the slave mmio
> > window. This is also required if we want to enable things like
> > XIP (DaX) mappings for file systems on a SPI-NOR flash.
> 
> Well, in the cases where we have one device on the bus then it's not a
> big deal since we can check what the last thing we set was.  The direct
> access stuff is going to have trouble if we have multiple devices on the
> bus since we try to mix it with non-MMIO access we run the risk of
> conflicting simultaneous use unless we continue to route everything
> through the SPI subsystem (like we do with the current flash read
> support).
> 
> It really only makes a difference if the reprogramming process happens a
> lot and is expensive relative to the transfers and that doesn't seem
> like something I'd expect.

Maybe we can avoid that if we enforce at the driver level that we
use the same mode for all slaves? The way I read the manual, I think
that's how it is intended at least.

Also, as mentioned we don't have any machine with more than one SPI
slave so far, so we don't really need to overengineer it and can
go for the simplest implementation in the SPI master driver.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
