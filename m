From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 7/8] spi: rspi: Add support for specifying CPHA/CPOL
Date: Tue, 31 Dec 2013 00:53:03 +0100
Message-ID: <15602504.DsQsiMiuEH@avalon>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org> <1387885248-28425-8-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387885248-28425-8-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Tuesday 24 December 2013 12:40:47 Geert Uytterhoeven wrote:
> Add support for specifying the SPI clock phase and polarity, based on the
> SDK reference code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/spi/spi-rspi.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 34674fe6df5d..850025278519 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -181,6 +181,7 @@ struct rspi_data {
>  	u8 spsr;
>  	u8 spdcr;
>  	u8 data_width;
> +	u16 spcmd;
>  	int irq[MAX_NUM_IRQ];
>  	unsigned int numirq;
>  	const struct spi_ops *ops;
> @@ -328,7 +329,7 @@ static int rspi_set_config_register(const struct
> rspi_data *rspi, rspi_write8(rspi, 0x00, RSPI_SPCR2);
> 
>  	/* Sets SPCMD */
> -	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | SPCMD_SSLKP,
> +	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | rspi->spcmd,
>  		     RSPI_SPCMD0);
> 
>  	/* Sets RSPI mode */
> @@ -383,7 +384,7 @@ static int qspi_set_config_register(const struct
> rspi_data *rspi, else
>  		spcmd = SPCMD_SPB_32BIT;
> 
> -	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | SPCMD_SSLKP | SPCMD_SPNDEN;
> +	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | rspi->spcmd | SPCMD_SPNDEN;
> 
>  	/* Resets transfer data length */
>  	rspi_write32(rspi, 0, QSPI_SPBMUL0);
> @@ -903,6 +904,12 @@ static int rspi_setup(struct spi_device *spi)
>  		spi->bits_per_word = 8;
>  	rspi->max_speed_hz = spi->max_speed_hz;
> 
> +	rspi->spcmd = SPCMD_SSLKP;
> +	if (spi->mode & SPI_CPOL)
> +		rspi->spcmd |= SPCMD_CPOL;
> +	if (spi->mode & SPI_CPHA)
> +		rspi->spcmd |= SPCMD_CPHA;
> +
>  	set_config_register(rspi, 8);
> 
>  	return 0;
> @@ -1092,6 +1099,7 @@ static int rspi_probe(struct platform_device *pdev)
>  	master->setup = rspi_setup;
>  	master->transfer = rspi_transfer;
>  	master->cleanup = rspi_cleanup;
> +	master->mode_bits = SPI_CPHA | SPI_CPOL;
> 
>  	for (i = 0; i < rspi->numirq; i++) {
>  		ret = devm_request_irq(&pdev->dev, rspi->irq[i], rspi_irq, 0,
-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
