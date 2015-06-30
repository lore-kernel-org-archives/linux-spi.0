From: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Tue, 30 Jun 2015 19:21:52 +0300
Message-ID: <000601d0b350$e06315d0$a1294170$@mentor.com>
References: <1435250415-9147-1-git-send-email-andrew_gabbasov@mentor.com> <20150626114622.GW14071@sirena.org.uk> <000601d0b34a$9fa42170$deec6450$@mentor.com> <20150630160237.GR11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150630160237.GR11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-us
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Tuesday, June 30, 2015 7:03 PM
> To: Gabbasov, Andrew
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed
buffer
> 
> On Tue, Jun 30, 2015 at 06:37:07PM +0300, Andrew Gabbasov wrote:
> 
> > > The caller is supposed to be providing us with aligned memory here.
> > > However it could be helpful to do this so...
> 
> > Well, actually the rest of spi code does not rely on having a transfer
> > buffer page-aligned. And I don't see any reason to make such an
> > assumption here.
> > Especially that it is not fulfilled, at least by ubifs code.
> > Anyway, this fix seems to be useful indeed.
> 
> The requirement comes more from the underlying DMA code than from SPI
> itself, SPI mostly doesn't care.

OK, then it's all the more useful to have SPI code tolerant to arbitrary
input data
(like un-aligned addresses), so that it won't introduce its own unnecessary
restrictions.

Thanks.

Best regards,
Andrew


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
