From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare
 calls for CCF
Date: Sat, 20 Aug 2016 01:36:02 -0700
Message-ID: <4a958a01-7772-dc9d-ff00-7e1cbad7ffe3@roeck-us.net>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471541667-30689-3-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/18/2016 10:34 AM, Geert Uytterhoeven wrote:
> While the custom minimal TXx9 clock implementation doesn't need or use
> clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
> they are mandatory when using the Common Clock Framework.
>
> Hence add them, to prepare for the advent of CCF.
>
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

> ---
> Tested on RBTX4927.
> ---
>  drivers/watchdog/txx9wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
> index c2da880292bc2f32..6f7a9deb27d05d25 100644
> --- a/drivers/watchdog/txx9wdt.c
> +++ b/drivers/watchdog/txx9wdt.c
> @@ -112,7 +112,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  		txx9_imclk = NULL;
>  		goto exit;
>  	}
> -	ret = clk_enable(txx9_imclk);
> +	ret = clk_prepare_enable(txx9_imclk);
>  	if (ret) {
>  		clk_put(txx9_imclk);
>  		txx9_imclk = NULL;
> @@ -144,7 +144,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  	return 0;
>  exit:
>  	if (txx9_imclk) {
> -		clk_disable(txx9_imclk);
> +		clk_disable_unprepare(txx9_imclk);
>  		clk_put(txx9_imclk);
>  	}
>  	return ret;
> @@ -153,7 +153,7 @@ exit:
>  static int __exit txx9wdt_remove(struct platform_device *dev)
>  {
>  	watchdog_unregister_device(&txx9wdt);
> -	clk_disable(txx9_imclk);
> +	clk_disable_unprepare(txx9_imclk);
>  	clk_put(txx9_imclk);
>  	return 0;
>  }
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
