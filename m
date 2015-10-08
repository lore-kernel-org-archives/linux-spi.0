From: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 5/8] spi: imx: Add support for loopback for ECSPI
 controllers
Date: Thu, 8 Oct 2015 17:28:28 +0800
Message-ID: <20151008092827.GB6101@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <ca96561d8010acf587a93d0f357774bf77efbe16.1442923630.git.anton_bondarenko@mentor.com>
 <20150930084219.GE2709@shlinux2>
 <04376A3D786BD947B28569C998A374A62E280E0F@NA-MBX-02.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Wang, Jiada (ESD)" <Jiada_Wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	"Zapolskiy, Vladimir" <Vladimir_Zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: "Bondarenko, Anton" <Anton_Bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <04376A3D786BD947B28569C998A374A62E280E0F-0dz9ie/QGrkPOGHby5MvPNQH9K4/4qFeAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Oct 01, 2015 at 12:16:49AM +0000, Bondarenko, Anton wrote:
> On 30.09.2015 10:42, Robin Gong wrote:
> > On Fri, Sep 25, 2015 at 07:57:12PM +0200, Anton Bondarenko wrote:
> >> @@ -370,8 +374,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
> >>  	if (config->mode & SPI_CS_HIGH)
> >>  		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
> >>  
> >> +	if (config->mode & SPI_LOOP)
> >> +		lpb |= MX51_ECSPI_LOOP;
> >> +
> >>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> >>  	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
> >> +	writel(lpb, spi_imx->base + MX51_ECSPI_TEST);
> > It's better write this MX51_ECSPI_TEST only in LOOP mode.
> LOOP mode can be set dynamically. This mean we should be able to set and clear the flag.
> Currently only LOOP flag is used. I did not find any problems with writing 0 in the rest
> fields of TEST register.
Yes, I know writing 0 is harmless, but we never need to touch this register if
SPI_LOOP flags not set, I'd like below:
	if (config->mode & SPI_LOOP) {
		lpb |= MX51_ECSPI_LOOP;
		writel(lgb, spi_imx->base + MX51_ECSPI_TEST);
	}

> >>  
> >>  	/*
> >>  	 * Wait until the changes in the configuration register CONFIGREG
> >> @@ -1276,12 +1287,13 @@ static int spi_imx_probe(struct platform_device *pdev)
> >>  	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
> >>  	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
> >>  	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
> >> -	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> >> +	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA |
> >> +				SPI_CS_HIGH;
> > Any change?
> Will be fixed in V3
> >>  
> >> -	init_completion(&spi_imx->xfer_done);
> >> +	if (is_imx5x_ecspi(spi_imx))
> >> +		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
> >>  
> >> -	spi_imx->devtype_data = of_id ? of_id->data :
> >> -		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
> >> +	init_completion(&spi_imx->xfer_done);
> >>  
> >>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>  	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
> >> -- 
> >> 2.5.2
> >>
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
