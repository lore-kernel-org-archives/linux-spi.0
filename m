From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 18:45:52 -0700
Message-ID: <20160702014551.GB27937@apronin0.mtv.corp.google.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <20160701080230.GB6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160701080230.GB6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 01, 2016 at 09:02:30AM +0100, Mark Brown wrote:
> On Wed, Jun 29, 2016 at 08:54:24PM -0700, apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org wrote:
> > From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > 
> > Some SPI devices may go to sleep after a period of inactivity
> > on SPI. For such devices, if enough time has passed since the
> > last SPI transaction, toggle CS and wait for the device to
> > start before communicating with it.
> 
> This seems incredibly specialist, I can imagine someone might implement
> something like this but it really feels like something I'd expect the
> driver for the device to be doing rather than the core.  Is it really a
> bounce that's needed and not something like putting a small delay after
> asserting chip select?

Yes, I agree it's quite device-specific, though, I guess, more than a
single device can benefit from that. I'm playing with it now to see if
I can indeed move it to a more device-specific driver from generic spi.

It is indeed a bounce and a rather long delay to let the device actually
wake from a long sleep, go through internal startup, test, etc.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
