From: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] spi: s3c64xx: use unsigned type for fifo handling
 variables
Date: Wed, 6 Jul 2016 00:01:21 +0900
Message-ID: <20160705150121.GF1257@jack.zhora.eu>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
 <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
 <20160705145556.GD6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160705145556.GD6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> > The 'quirks' variable cannot ever be negative, therefore use u8
> > instead of int. The 8 bit size is given from the fact that
> > currently the quirks variable has very few statuses.
> > 
> > The rx_lvl_offset and tx_st_done store shift values, so that u8
> > is a proper size.
> > 
> > fifo_lvl_mask stores a series of masks, to be in we will keep the
> > 32 bit size.
> 
> What's the advantage of these changes?  This feels like microptimisation
> of something that shouldn't be a big performance issue and it's not
> always the case that the compiler does something more sensible with
> smaller or unsigned types.  I'm not saying don't do it, I'm just saying
> that it's not clear to me what the win is.

not much indeed. Just something that was a little bothering me
while I was reading through.

Please, feel free to drop it.

Thanks,
Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
