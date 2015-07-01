From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/s3c24xx: remove unnecessary memset of s3c24xx_spi
Date: Wed, 1 Jul 2015 12:25:44 +0800
Message-ID: <CAGS+omAnwhxKzfBm18oETgCKM2r3qtVpS9VR=GzbQhU6ujzVrQ@mail.gmail.com>
References: <1435687438.27701.12.camel@ceres>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?B?5p+v6aOe6ZuE?= <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435687438.27701.12.camel@ceres>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jul 1, 2015 at 2:03 AM, Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Memory for this struct is allocated by spi_alloc_master() using
> kzalloc() so it doesn't need to be set to 0 one more time.
>
> Signed-off-by: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Yup, I just noticed this too when reviewing the mediatek SPI driver.

For both patches:
Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

> ---
>  drivers/spi/spi-s3c24xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index f747ca2..f36bc32 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -501,7 +501,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>         }
>
>         hw = spi_master_get_devdata(master);
> -       memset(hw, 0, sizeof(struct s3c24xx_spi));
>
>         hw->master = master;
>         hw->pdata = pdata = dev_get_platdata(&pdev->dev);
> --
> 1.9.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
