From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: fsl-espi: replace of_get_property with
 of_property_read_u32
Date: Tue, 27 Sep 2016 07:39:20 +0200
Message-ID: <10e52aa2-9327-8aa3-0132-74c1feefa165@gmail.com>
References: <1d67ce99-42ea-c816-da35-e64575cca8ff@web.de>
 <faa8bb6f-a644-5779-6a65-a6d8394bd17f@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <faa8bb6f-a644-5779-6a65-a6d8394bd17f-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 17.09.2016 um 15:44 schrieb Heiner Kallweit:
> Replace of_get_property with of_property_read_u32, thus simplifying
> the code and improving readability.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-espi.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
The other three patches of the series you applied already. Any comment
on this one?
Or did your comment on another patch (which you applied nevertheless),
to improve the commit message and better explain the benefit,
actually refer to this one?

> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> index 7451585..1f97cce 100644
> --- a/drivers/spi/spi-fsl-espi.c
> +++ b/drivers/spi/spi-fsl-espi.c
> @@ -545,9 +545,8 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
>  	struct spi_master *master;
>  	struct mpc8xxx_spi *mpc8xxx_spi;
>  	struct device_node *nc;
> -	const __be32 *prop;
> -	u32 regval, csmode;
> -	int i, len, ret;
> +	u32 regval, csmode, cs, prop;
> +	int ret;
>  
>  	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
>  	if (!master)
> @@ -599,29 +598,29 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
>  	/* Init eSPI CS mode register */
>  	for_each_available_child_of_node(master->dev.of_node, nc) {
>  		/* get chip select */
> -		prop = of_get_property(nc, "reg", &len);
> -		if (!prop || len < sizeof(*prop))
> -			continue;
> -		i = be32_to_cpup(prop);
> -		if (i < 0 || i >= pdata->max_chipselect)
> +		ret = of_property_read_u32(nc, "reg", &cs);
> +		if (ret || cs >= pdata->max_chipselect)
>  			continue;
>  
>  		csmode = CSMODE_INIT_VAL;
> +
>  		/* check if CSBEF is set in device tree */
> -		prop = of_get_property(nc, "fsl,csbef", &len);
> -		if (prop && len >= sizeof(*prop)) {
> +		ret = of_property_read_u32(nc, "fsl,csbef", &prop);
> +		if (!ret) {
>  			csmode &= ~(CSMODE_BEF(0xf));
> -			csmode |= CSMODE_BEF(be32_to_cpup(prop));
> +			csmode |= CSMODE_BEF(prop);
>  		}
> +
>  		/* check if CSAFT is set in device tree */
> -		prop = of_get_property(nc, "fsl,csaft", &len);
> -		if (prop && len >= sizeof(*prop)) {
> +		ret = of_property_read_u32(nc, "fsl,csaft", &prop);
> +		if (!ret) {
>  			csmode &= ~(CSMODE_AFT(0xf));
> -			csmode |= CSMODE_AFT(be32_to_cpup(prop));
> +			csmode |= CSMODE_AFT(prop);
>  		}
> -		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i), csmode);
>  
> -		dev_info(dev, "cs=%d, init_csmode=0x%x\n", i, csmode);
> +		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(cs), csmode);
> +
> +		dev_info(dev, "cs=%u, init_csmode=0x%x\n", cs, csmode);
>  	}
>  
>  	/* Enable SPI interface */
> @@ -660,16 +659,16 @@ static int of_fsl_espi_get_chipselects(struct device *dev)
>  {
>  	struct device_node *np = dev->of_node;
>  	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
> -	const u32 *prop;
> -	int len;
> +	u32 num_cs;
> +	int ret;
>  
> -	prop = of_get_property(np, "fsl,espi-num-chipselects", &len);
> -	if (!prop || len < sizeof(*prop)) {
> +	ret = of_property_read_u32(np, "fsl,espi-num-chipselects", &num_cs);
> +	if (ret) {
>  		dev_err(dev, "No 'fsl,espi-num-chipselects' property\n");
>  		return -EINVAL;
>  	}
>  
> -	pdata->max_chipselect = *prop;
> +	pdata->max_chipselect = num_cs;
>  	pdata->cs_control = NULL;
>  
>  	return 0;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
