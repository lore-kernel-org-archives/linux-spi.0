From: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 1/3] spi: imx: GPIO chip select DT property should not
 be required
Date: Tue, 7 Nov 2017 07:45:22 +0100
Message-ID: <354ae9de-d3b4-72b9-f39c-0cde89052303@pengutronix.de>
References: <20171106194618.9421-1-tpiepho@impinj.com>
 <20171106194618.9421-2-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106194618.9421-2-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 06.11.2017 20:46, Trent Piepho wrote:
> The driver will fail to load if the device tree property for gpio chip
> selects is not specified.  Change the driver to make the property optional.
> Also have the driver respect the "num-cs" property in the standard way.
> 
> This way one can use the native CS lines using standard bindings instead of
> being forced to specify a gpio-cs of <0>.
> 
> Since native CS do not work in a commonly useful manner with this
> hardware/driver, note in the documention that most users probably should
> use GPIO based CS lines rather than native.
> 
> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> CC: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>


Reviewed-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>


> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 18 ++++++++++++------
>  drivers/spi/spi-imx.c                                  | 18 ++++++++++--------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 5bf13960f7f4..e3c48b20b1a6 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -12,24 +12,30 @@ Required properties:
>    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
> -- cs-gpios : Specifies the gpio pins to be used for chipselects.
>  - clocks : Clock specifiers for both ipg and per clocks.
>  - clock-names : Clock names should include both "ipg" and "per"
>  See the clock consumer binding,
>  	Documentation/devicetree/bindings/clock/clock-bindings.txt
> -- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> -		Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names: DMA request names should include "tx" and "rx" if present.
>  
> -Obsolete properties:
> -- fsl,spi-num-chipselects : Contains the number of the chipselect
> +Recommended properties:
> +- cs-gpios : GPIOs to use as chip selects, see spi-bus.txt.  While the native chip
> +select lines can be used, they appear to always generate a pulse between each
> +word of a transfer.  Most use cases will require GPIO based chip selects to
> +generate a valid transaction.
>  
>  Optional properties:
> +- num-cs :  Number of total chip selects, see spi-bus.txt.
> +- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> +Documentation/devicetree/bindings/dma/dma.txt.
> +- dma-names: DMA request names, if present, should include "tx" and "rx".
>  - fsl,spi-rdy-drctl: Integer, representing the value of DRCTL, the register
>  controlling the SPI_READY handling. Note that to enable the DRCTL consideration,
>  the SPI_READY mode-flag needs to be set too.
>  Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
>  
> +Obsolete properties:
> +- fsl,spi-num-chipselects : Contains the number of the chipselect
> +
>  Example:
>  
>  ecspi@70010000 {
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 301cdb721bad..ad54f8258513 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1523,6 +1523,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  	spi_imx->devtype_data = devtype_data;
>  
> +	/* Get number of chip selects, either platform data or OF */
>  	if (mxc_platform_info) {
>  		master->num_chipselect = mxc_platform_info->num_chipselect;
>  		master->cs_gpios = devm_kzalloc(&master->dev,
> @@ -1532,7 +1533,13 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  		for (i = 0; i < master->num_chipselect; i++)
>  			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> - 	}
> +	} else {
> +		u32 num_cs;
> +
> +		if (!of_property_read_u32(np, "num-cs", &num_cs))
> +			master->num_chipselect = num_cs;
> +		/* If not preset, default value of 1 is used */
> +	}
>  
>  	spi_imx->bitbang.chipselect = spi_imx_chipselect;
>  	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
> @@ -1619,13 +1626,8 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		goto out_clk_put;
>  	}
>  
> -	if (!spi_imx->slave_mode) {
> -		if (!master->cs_gpios) {
> -			dev_err(&pdev->dev, "No CS GPIOs available\n");
> -			ret = -EINVAL;
> -			goto out_clk_put;
> -		}
> -
> +	/* Request GPIO CS lines, if any */
> +	if (!spi_imx->slave_mode && master->cs_gpios) {
>  		for (i = 0; i < master->num_chipselect; i++) {
>  			if (!gpio_is_valid(master->cs_gpios[i]))
>  				continue;
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
