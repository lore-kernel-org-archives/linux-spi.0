From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCH] spi: acpi: remove superfluous parameter check
Date: Thu, 12 Mar 2020 15:28:41 +0100
Message-ID: <20200312142841.GC791432@oden.dyn.berto.se>
References: <20200312134507.10000-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200312134507.10000-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Wolfram,

Thanks for your work.

On 2020-03-12 14:45:07 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> 
> to_spi_device() already checks 'dev'. No need to do it before calling
> it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>

> ---
> 
> Found while fiddling with bus_find_device_by_acpi_dev() in the I2C
> subsystem.
> 
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 755221bc3745..75978b6c5834 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4034,7 +4034,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
>  	struct device *dev;
>  
>  	dev = bus_find_device_by_acpi_dev(&spi_bus_type, adev);
> -	return dev ? to_spi_device(dev) : NULL;
> +	return to_spi_device(dev);
>  }
>  
>  static int acpi_spi_notify(struct notifier_block *nb, unsigned long value,
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
