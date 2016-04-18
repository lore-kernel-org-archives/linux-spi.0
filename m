From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5] spi: orion.c: Add direct access mode
Date: Mon, 18 Apr 2016 13:32:49 +0200
Message-ID: <4248364.c0REkIZjj0@wuerfel>
References: <1460974417-32375-1-git-send-email-sr@denx.de> <4437692.8jaX7AeWuo@wuerfel> <20160418110415.GT3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418110415.GT3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday 18 April 2016 12:04:15 Mark Brown wrote:
> On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:
> 
> > This would be easier if have a conclusive proof that 1MB per CS always enough.
> > Is this something that is guaranteed in the SPI spec or the documentation for
> > this controller?
> 
> There's no spec for SPI but if there were it'd be hard to see it
> imposing a limit, one can transfer data as long as the bus is clocked
> (which some things like ADCs and DACs make use of).
> 

I just reread Stefan's patch and realized that I had fundamentally
misunderstood how the transfer is done: I thought the offset inside of
the window was used to address a NOR flash directly, but it seems
it is just used to send arbitrarily long commands.

This means that the 1MB window is probably a reasonable size (provided
that the (most importantly) the SPI-NOR driver can guarantee that it
never exceeds this).

It also means that we are probably better off using the single-window mode
of the SPI controller, where all CS lines share a single mbus window.
The only real difference here is that we can map all endpoints using a
single contiguous window into the CPU address space if we want, or we
can still map them separately on a given board if that results in a nicer
layout.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
