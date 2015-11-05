From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 21:32:15 +0900
Message-ID: <CAK7LNASkXUb-S-MzmaA6KxJbnAPKnLbYvH8KtHPb=fzUrPK2ng@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
	<1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
	<20151105112847.GA18409@sirena.org.uk>
	<CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA@mail.gmail.com>
	<20151105122038.GF18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151105122038.GF18409-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-11-05 21:20 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Nov 05, 2015 at 09:11:47PM +0900, Masahiro Yamada wrote:
>> 2015-11-05 20:28 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>
>> > The dependency is on ARCH_SUNXI || COMPILE_TEST which is not the same as
>> > ARCH_SUNXI.
>
>> The compile test of this driver should pass even if RESET_CONTROLLER
>> is not defined.
>> So, it does not matter for COMPILE_TEST.
>
> If that is the case then the change here is that the dependency on
> RESET_CONTROLLER is just redundant which isn't what the commit message
> says.

For compile test, right, "depends on RESET_CONTROLLER" is
redundant in the first place.

For run-time on real SoCs,the driver failed at the following point
without the reset-controller sub-system.


    sspi->rstc = devm_reset_control_get(&pdev->dev, NULL);
    if (IS_ERR(sspi->rstc)) {
            dev_err(&pdev->dev, "Couldn't get reset controller\n");
            ret = PTR_ERR(sspi->rstc);
            goto err_free_master;
    }




-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
