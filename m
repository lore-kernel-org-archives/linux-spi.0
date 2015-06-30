From: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Tue, 30 Jun 2015 18:37:07 +0300
Message-ID: <000601d0b34a$9fa42170$deec6450$@mentor.com>
References: <1435250415-9147-1-git-send-email-andrew_gabbasov@mentor.com> <20150626114622.GW14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150626114622.GW14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-us
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Friday, June 26, 2015 2:46 PM
> To: Gabbasov, Andrew
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed
buffer
> 
> On Thu, Jun 25, 2015 at 11:40:15AM -0500, Andrew Gabbasov wrote:
> > spi_map_buf() processes mapping of vmalloc-ed buffers in a special
> > way, making mapping of every page separately. However, if the buffer
> > is not aligned to page boundary (e.g. sub-array in a vmalloc-ed
> > array), it fills the scatter table with page-size unaligned pieces,
> > that cross page boundaries. This is incorrect and can, for example,
> > cause memory corruption and various crashes when working with ubifs on
spi-
> nor chips.
> 
> The caller is supposed to be providing us with aligned memory here.
> However it could be helpful to do this so...

Well, actually the rest of spi code does not rely on having a transfer
buffer
page-aligned. And I don't see any reason to make such an assumption here.
Especially that it is not fulfilled, at least by ubifs code.
Anyway, this fix seems to be useful indeed.

> > -	const int sgs = DIV_ROUND_UP(len, desc_len);
> > +	const int sgs = DIV_ROUND_UP(vmalloced_buf ?
> > +					len + offset_in_page(buf) : len,
> > +				     desc_len);
> 
> No, please write this legibly without the ternery operator.

OK, I'll try to make this piece of code more distinct.
I'm submitting v2 of the patch.

Thanks.

Best regards,
Andrew


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
