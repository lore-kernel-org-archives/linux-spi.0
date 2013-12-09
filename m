From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove casting the return value which is a
 void pointer
Date: Mon, 09 Dec 2013 21:09:50 +0900
Message-ID: <003001cef4d7$8fa00ce0$aee026a0$%han@samsung.com>
References: <001801cef4ca$8c605e20$a5211a60$%han@samsung.com>
 <8761qyuv6g.fsf@mina86.com> <20131209115536.GR29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Cory Maccarrone' <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	'Michal Nazarewicz' <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20131209115536.GR29268-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, December 09, 2013 8:56 PM, Mark Brown wrote:
> On Mon, Dec 09, 2013 at 12:21:11PM +0100, Michal Nazarewicz wrote:
> > On Mon, Dec 09 2013, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > > -	spi100k->base = (void __iomem *)dev_get_platdata(&pdev->dev);
> > > +	spi100k->base = dev_get_platdata(&pdev->dev);
> 
> > I might be wrong, but I would assume that __iomem is the important bit
> > here and removing this cast will make linter unhappy.
> 
> Yes, I'd expect so.  Jingoo have you tested with sparse?

Oops, I didn't test sparse warning.
This patch makes sparse warning as below:

drivers/spi/spi-omap-100k.c:444:23: warning: incorrect type in assignment (different address spaces)
drivers/spi/spi-omap-100k.c:444:23:    expected void [noderef] <asn:2>*base
drivers/spi/spi-omap-100k.c:444:23:    got void *

Please, ignore this patch.
Sorry for annoying you. :-)

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
