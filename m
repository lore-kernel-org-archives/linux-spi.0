From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH V2] gpio: add driver for MAX7300 I2C GPIO extender
Date: Thu, 19 Nov 2009 18:06:26 +0300
Message-ID: <20091119150626.GA6057@oksana.dev.rtsoft.ru>
References: <20091118231052.GA23699@oksana.dev.rtsoft.ru>
 <1258639349-5457-1-git-send-email-w.sang@pengutronix.de>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Juergen Beisert <j.beisert-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1258639349-5457-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 19, 2009 at 03:02:29PM +0100, Wolfram Sang wrote:
> Add the MAX7300-I2C variant to the MAX7301-SPI version. They share most parts
> of the driver (i.e. the logic) and the read/write-register functions get
> encapsulated. It is thus possible to use both variants simultaneously.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Juergen Beisert <j.beisert-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> ---

Wolfram, thanks for your work on this.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 2ad0128..a1d2608 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -65,6 +65,24 @@ config GPIO_SYSFS
>  
>  # put expanders in the right section, in alphabetical order
>  
> +comment "GPIO expanders for multiple busses"
> +
> +config GPIO_MAX7301
> +	tristate "Maxim MAX730x GPIO expander"

I believe this should be 'depends on I2C || SPI_MASTER'.

> +	help
> +	  GPIO driver for Maxim MAX7300/7301 GPIO expanders.
> +	  Also select which bus you want to use.
> +
> +if GPIO_MAX7301
> +config GPIO_MAX7301_I2C
> +	bool "I2C support (for MAX7300)"
> +	depends on I2C
> +
> +config GPIO_MAX7301_SPI
> +	bool "SPI support (for MAX7301)"
> +	depends on SPI_MASTER
> +endif
> +
>  comment "Memory mapped GPIO expanders:"
[...]
> +static int max7301_i2c_write(struct device *dev, unsigned int reg,
> +				unsigned int val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);

This is a matter of taste, but I'd add an empty line here.

> +	return i2c_smbus_write_byte_data(client, reg, val);
> +}
> +
> +static int max7301_i2c_read(struct device *dev, unsigned int reg)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);

And here.

> +	return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int __devinit max7300_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
[...]
> +#endif /* CONFIG_GPIO_MAX7301_I2C */
> +
>  static int __init max7301_init(void)
>  {
> -	return spi_register_driver(&max7301_driver);
> +	int ret;
> +	ret = max7300_add_driver(&max7300_driver);

Please add an empty line after 'int ret;'.


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2
