From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: octeon: Split driver into Octeon specific and
 common parts
Date: Mon, 25 Jul 2016 13:37:38 +0200
Message-ID: <20160725113738.GB2849@hardcore>
References: <cover.1469174814.git.jglauber@cavium.com>
 <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber@cavium.com>
 <20160724205416.GA6345@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160724205416.GA6345-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jul 24, 2016 at 09:54:16PM +0100, Mark Brown wrote:
> On Sat, Jul 23, 2016 at 12:42:54PM +0200, Jan Glauber wrote:
> 
> > +	dev_info(&pdev->dev, "OCTEON SPI bus driver\n");
> 
> This is just noise, remove it.

I'll remove these in both drivers.

Thanks,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
