From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Thu, 27 Feb 2014 16:59:58 +0800
Message-ID: <530EFE8E.5050303@freescale.com>
References: <1393491060-28074-1-git-send-email-phdm@macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393491060-28074-1-git-send-email-phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=D3=DA 2014=C4=EA02=D4=C227=C8=D5 16:51, Philippe De Muyter =D0=B4=B5=C0=
:
> -	clk_disable_unprepare(spi_imx->clk_ipg);
> -	clk_disable_unprepare(spi_imx->clk_per);
yes. we do not need to disable the clocks,
but we'd better to unprepare these two clocks.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
