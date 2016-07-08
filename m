From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] bindings: spi-samsung: add exynos5433 spi compatible
Date: Fri, 08 Jul 2016 21:56:48 +0900
Message-ID: <20160708125648.GK23620@samsunx.samsung>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-3-git-send-email-andi.shyti@samsung.com>
 <CGME20160708125125epcas1p25209218b03d625369dc9f9495a66b750@epcas1p2.samsung.com>
 <577FA1CB.30805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <577FA1CB.30805-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> >  
> >  - reg: physical base address of the controller and length of memory mapped
> >    region.
> > 
> 
> Thanks for the patch, nice work. I see that you ignored parts of my
> offline comments so I guess you leave that work to others (describe
> required clock properties, deprecate exynos7-spi). I'll send the follow
> up then.

I was actually doing the follow up, I think it's a different
concept and therefore goes on a different patch.

Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
