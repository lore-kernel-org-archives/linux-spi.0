From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] mtd: m25p80: Make the name of mtd_info fixed
Date: Mon, 10 Feb 2014 11:39:48 -0800
Message-ID: <20140210193948.GD18440@ld-irv-0074>
References: <1390717003-28699-1-git-send-email-b48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390717003-28699-1-git-send-email-b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jan 26, 2014 at 02:16:43PM +0800, Hou Zhiqiang wrote:
> To give spi flash layout using "mtdparts=..." in cmdline, we must
> give mtd_info a fixed name,because the cmdlinepart's parser will
> match the name given in cmdline with the mtd_info.
> 
> Now, if use OF node, mtd_info's name will be spi->dev->name. It
> consists of spi_master->bus_num, and the spi_master->bus_num maybe
> dynamically fetched.
> So, give the mtd_info a new fiexd name "name.cs", "name" is name of
> spi_device_id and "cs" is chip-select in spi_dev.
> 
> Signed-off-by: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> v2:
>  - add check for return value of function kasprintf.
>  - whether the spi_master->bus_num is dynamical is determined by spi
>    controller driver, and it can't be check in this driver. So, we can
>    not initial the mtd_info's name by distinguishing the spi_master
>    bus_num dynamically-allocated or not.

How about spi->master->bus_num < 0 ?

>  drivers/mtd/devices/m25p80.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index eb558e8..1f494d2 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -1011,8 +1011,12 @@ static int m25p_probe(struct spi_device *spi)
>  
>  	if (data && data->name)
>  		flash->mtd.name = data->name;
> -	else
> -		flash->mtd.name = dev_name(&spi->dev);
> +	else {
> +		flash->mtd.name = kasprintf(GFP_KERNEL, "%s.%d",
> +				id->name, spi->chip_select);

I don't think this name is specific enough. What if there are more than
one SPI controller? Then there could be one chip with the same
chip-select. You probably still need to incorporate the SPI master
somehow, even if it's not by using the bus number directly (because it's
dynamic).

> +		if (!flash->mtd.name)
> +			return -ENOMEM;
> +	}
>  
>  	flash->mtd.type = MTD_NORFLASH;
>  	flash->mtd.writesize = 1;

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
