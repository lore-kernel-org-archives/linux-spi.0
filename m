From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [spi-devel-general] [PATCH] gpio: add driver for MAX7300 I2C
 GPIO extender
Date: Thu, 19 Nov 2009 02:10:52 +0300
Message-ID: <20091118231052.GA23699@oksana.dev.rtsoft.ru>
References: <1258546646-11586-1-git-send-email-w.sang@pengutronix.de>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Juergen Beisert <j.beisert-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1258546646-11586-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 18, 2009 at 01:17:26PM +0100, Wolfram Sang wrote:
> Add the MAX7300-I2C variant to the MAX7301-SPI version. They share most parts
> of the driver (i.e. the logic) and the read/write-register functions get
> encapsulated. It is thus possible to use both variants simultaneously.
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 2ad0128..a1d2608 100644
[...]
> +MODULE_ALIAS("spi:max7301");
> +
> +#define max7301_add_driver(drv) spi_register_driver(drv)
> +#define max7301_del_driver(drv) spi_unregister_driver(drv)
> +#else
> +#define max7301_add_driver(drv) (0)
> +#define max7301_del_driver(drv) do { } while(0)
> +#endif /* CONFIG_GPIO_MAX7301_SPI */
[...]
>  static int __init max7301_init(void)
>  {
> -	return spi_register_driver(&max7301_driver);
> +	int ret;
> +	ret = max7300_add_driver(&max7300_driver);
> +	if (ret)
> +		return ret;
> +	ret = max7301_add_driver(&max7301_driver);

Nowadays you can use device table matching, as an example see
commit 8cec03eee4a771f949c70cff07775c9bb21d4642 ("hwmon: lm70:
convert to device table matching").

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2
