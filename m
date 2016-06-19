From: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: do not fail if the CS line is not connected
Date: Sun, 19 Jun 2016 15:09:02 +0900
Message-ID: <20160619060902.GB424@jack.zhora.eu>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
 <20160617122803.GN26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160617122803.GN26099-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> > > > In this case do not fail and defer to the SPI device drivers the
> > > > responsibility to check whether the num-cs is '0'.
> 
> > > A SPI controller always has one chip seelct, it may not be controllable
> > > but it's at least logically present.
> 
> > This is true, but there are cases where the CS is not connected
> > and this case needs to be treated separately to allow the device
> > to work.
> 
> In what way?  It is just as easy for a device with no physical chip
> select to have a logical chip select of 0 that it does nothing with as
> it is for that device to handle any other number.

That is indeed my case: the s3c64xx doesn't send anything, unless
I manually enable CS (from the next patches I need to write '0'
in the CS register). But I need smoething to tell to the
device that the CS line is not connected, for example a flag in
the DTS.

It comes natural to me to set "num-cs = <0>" instead of defining
a new property. In this case I will consider that there is no CS
line, even though there is a CS controller.

Thanks,
Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
