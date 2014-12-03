From: Iain Baron <Iain.Baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
Subject: RE: [PATCH] spi-altera: Fix NULL pointer dereference in
 spi_bitbang_transfer_one
Date: Wed, 3 Dec 2014 15:16:41 +0000
Message-ID: <6438CE2D8332724FAD5D85EF6ED23E1912952563@NEWTONS4THSBS.newtons4th.local>
References: <1417605949-11447-1-git-send-email-iain.baron@newtons4th.com>
 <20141203130324.GY7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203130324.GY7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: 03 December 2014 13:03
> 
> If we can safely handle not having the callback then we should fix the
> call site to safely handle a null pointer rather than adding dummy
> callbacks.  That way this is fixed once for all drivers that need it.

Is it better to test for a null pointer at the spi-bitbang call-site, or get spi-bitbang to add a dummy callback of its own in spi_bitbang_start? The former has the overhead of a test every call, even for those drivers that provide the callback, while the latter has the overhead of a dummy call only for those drivers that don't.

At present, spi_bitbang_start assumes that if bitbang->txrx_bufs is defined, then bitbang->setup_transfer is also defined without checking it.

> I'd expect to see some code that checks to see if the caller is trying
> to change paramters.

If you mean in the spi-altera code: The spi-altera driver does not know what the hardware fixed parameters are, so it can't make a decision about whether the caller is trying to change them to something else.

If you mean in the spi-bitbang code: The code appears to do this with the do_setup test, but it will always do a setup for the very first transfer in a message regardless, invoking the missing callback.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
