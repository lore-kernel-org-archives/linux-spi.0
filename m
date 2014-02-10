From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: tegra114: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 09:53:03 -0700
Message-ID: <52F903EF.4030606@wwwdotorg.org>
References: <1392040096.4191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392040096.4191.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/10/2014 06:48 AM, Axel Lin wrote:
> Use master->max_speed_hz instead of tspi->spi_max_frequency, so spi core will
> handle checking transfer speed.
> 
> In additional, since commit 052eb2d49006 'spi: core: Set max_speed_hz of
> spi_device default to max_speed_hz of controller',
> spi core will also set default spi->max_speed_hz if it is not set.
> So remove the duplicate code in tegra_spi_setup.

The series,
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I wonder ...

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c

> @@ -1049,8 +1035,9 @@ static int tegra_spi_probe(struct platform_device *pdev)

> -	/* Parse DT */
> -	tegra_spi_parse_dt(pdev, tspi);
> +	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
> +				 &master->max_speed_hz))
> +		master->max_speed_hz = 25000000; /* 25MHz */

... if that DT parsing can be done in common code too?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
