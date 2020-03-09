From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in
 SPI_MCR
Date: Mon, 09 Mar 2020 19:05:09 +0100
Message-ID: <c35b3c34123b43b26204a2cf360e7ec1@walle.cc>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-2-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309145624.10026-2-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> 
> The SPI_MCR_PCSIS macro assumes that the controller has a number of 
> chip
> select signals equal to 6. That is not always the case, but actually is
> described through the driver-specific " signals equal to 6. That is not
> always the case, but actually is described through the driver-specific
> "spi-num-chipselects" device tree binding.

Repeated sentence? Was this your intention?

-michael

> LS1028A for example only has
> 4 chip selects.
> 
> Don't write to the upper bits of the PCSIS field, which are reserved in
> the reference manual.
> 
> Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 
> platform")
> Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0683a3fbd48c..0ce26c1cbf62 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -22,7 +22,7 @@
> 
>  #define SPI_MCR				0x00
>  #define SPI_MCR_MASTER			BIT(31)
> -#define SPI_MCR_PCSIS			(0x3F << 16)
> +#define SPI_MCR_PCSIS(x)		((x) << 16)
>  #define SPI_MCR_CLR_TXF			BIT(11)
>  #define SPI_MCR_CLR_RXF			BIT(10)
>  #define SPI_MCR_XSPI			BIT(3)
> @@ -1197,7 +1197,10 @@ static const struct regmap_config
> dspi_xspi_regmap_config[] = {
> 
>  static void dspi_init(struct fsl_dspi *dspi)
>  {
> -	unsigned int mcr = SPI_MCR_PCSIS;
> +	unsigned int mcr;
> +
> +	/* Set idle states for all chip select signals to high */
> +	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->num_chipselect - 1, 0));
> 
>  	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
>  		mcr |= SPI_MCR_XSPI;
