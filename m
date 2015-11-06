From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
Date: Fri, 6 Nov 2015 15:00:04 +0900
Message-ID: <CAK7LNASRqcXsyNdjJZSmfzCRCH9xc+moy_7bgeiis3T47tCMyA@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
	<1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
	<20151105112847.GA18409@sirena.org.uk>
	<CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA@mail.gmail.com>
	<20151105122038.GF18409@sirena.org.uk>
	<CAK7LNASkXUb-S-MzmaA6KxJbnAPKnLbYvH8KtHPb=fzUrPK2ng@mail.gmail.com>
	<20151105150529.GN18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151105150529.GN18409-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-11-06 0:05 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Nov 05, 2015 at 09:32:15PM +0900, Masahiro Yamada wrote:
>
>> For compile test, right, "depends on RESET_CONTROLLER" is
>> redundant in the first place.
>
>> For run-time on real SoCs,the driver failed at the following point
>> without the reset-controller sub-system.
>
> Your changelog needs to say this clearly, right now what it's saying
> clearly doesn't correspond to what the change does.

OK.

This series is RFC and my main focus in on the 1/7.
I will wait for more comments against the first one.


-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
