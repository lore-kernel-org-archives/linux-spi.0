From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: fix bogus SPI bus number
Date: Tue, 17 Oct 2017 14:20:34 +0200
Message-ID: <1508242834.2146.16.camel@pengutronix.de>
References: <20171017104519.878892-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Naresh Kamboju <naresh.kamboju-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171017104519.878892-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am Dienstag, den 17.10.2017, 12:44 +0200 schrieb Arnd Bergmann:
> lkft found a boot time regression on the Hikey board that has no
> aliases entry for spi buses. of_alias_get_highest_id() here
> returns -ENODEV, which is then used as the initial number for the
> IDR allocation, and that in turn triggers a WARN_ON:
> 
> WARNING: CPU: 3 PID: 53 at include/linux/idr.h:113
> spi_register_controller+0x890/0x940
> 
> This reworks the algorithm to turn any negative number into zero
> again, restoring the original behavior for the Hikey case.
> 
> Fixes: 9ce70d49fa80 ("spi: fix IDR collision on systems with both
> fixed and dynamic SPI bus numbers")
> Reported-by: Naresh Kamboju <naresh.kamboju-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Link: https://lkft.validation.linaro.org/scheduler/job/48009#L3147
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
> Not tested yet, please review carefully

I've already sent a v2 of the borked patch, which Mark apparently
applied to his fix/idr branch.

Regards,
Lucas

> ---
>  drivers/spi/spi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0483410e7cb3..4b6985ec962c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2116,9 +2116,11 @@ int spi_register_controller(struct
> spi_controller *ctlr)
>  	}
>  	if (ctlr->bus_num < 0) {
>  		mutex_lock(&board_lock);
> +		id = of_alias_get_highest_id("spi");
> +		if (id < 0)
> +			id = -1;
>  		id = idr_alloc(&spi_master_idr, ctlr,
> -			       of_alias_get_highest_id("spi") + 1,
> -			       0, GFP_KERNEL);
> +			       id + 1, 0, GFP_KERNEL);
>  		mutex_unlock(&board_lock);
>  		if (WARN(id < 0, "couldn't get idr"))
>  			return id;
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
