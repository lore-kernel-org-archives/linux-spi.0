From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: imx: support to set watermark level via DTS
Date: Thu, 5 Jan 2017 14:48:29 +0200
Message-ID: <4649873e-aca5-90b3-cc97-0d2e103ce8dc@mentor.com>
References: <20170105061015.7816-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105061015.7816-1-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jiada,

On 01/05/2017 08:10 AM, Jiada Wang wrote:
> Previously watermark level is configured to fifosize/2,
> DMA mode can be used only when transfer length can be divided
> by 'watermark level * bpw', which makes DMA mode not practical.
> 
> This patch adds new DTS property 'dma-wml', user can configure
> DMA watermark level, by specify 'dma-wml' in corresponding ecspi
> node.
> 
> Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt |  2 ++
>  drivers/spi/spi-imx.c                                  | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 8bc95e2..1e9345f 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -19,6 +19,7 @@ See the clock consumer binding,
>  - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
>  		Documentation/devicetree/bindings/dma/dma.txt
>  - dma-names: DMA request names should include "tx" and "rx" if present.
> +- dma-wml: Specifies DMA watermark level

It is supposed to be an optional property, please add a new section.

I'm not sure about the property naming, the property may be considered
as a generic one and then it should not have 'fsl' prefix like yours one,
but then its description should be moved to bindings/spi/spi-bus.txt. 

On the other hand for a kind of generic property it might be desirable
to have two properties, DMA RX and DMA TX watermark (threshold) levels.

And the property may be defined as a combined DMA RX / DMA TX watermark
specific to the Freescale ECSPI controller (however I would propose to
separate them, since the hardware allows to do it), but then please add
'fsl' prefix.

>  
>  Obsolete properties:
>  - fsl,spi-num-chipselects : Contains the number of the chipselect
> @@ -35,4 +36,5 @@ ecspi@70010000 {
>  		   <&gpio3 25 0>; /* GPIO3_25 */
>  	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
>  	dma-names = "rx", "tx";
> +        dma-wml = <16>;

Please use tab symbols for indentation.

>  };
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index deb782f..5c0ce19 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -929,8 +929,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  	if (of_machine_is_compatible("fsl,imx6dl"))
>  		return 0;
>  
> -	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
> -
>  	/* Prepare for TX DMA: */
>  	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
>  	if (IS_ERR(master->dma_tx)) {
> @@ -1155,6 +1153,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	struct spi_imx_data *spi_imx;
>  	struct resource *res;
>  	int i, ret, irq;
> +	u32 wml;
>  
>  	if (!np && !mxc_platform_info) {
>  		dev_err(&pdev->dev, "can't get the platform data\n");
> @@ -1177,6 +1176,15 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	spi_imx->devtype_data = of_id ? of_id->data :
>  		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
>  
> +	if (of_property_read_u32(np, "dma-wml", &wml) == 0) {
> +		if (wml > spi_imx_get_fifosize(spi_imx) || wml == 0) {
> +			dev_warn(&pdev->dev, "mis-configured dma-wml\n");
> +			spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
> +		} else
> +			spi_imx->wml = wml;

checkpatch should complain regarding missing bracers on the "else" branch.

> +	} else
> +		spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
> +

Same is here.

Since the setting depends on the availability of DMA feature, it would be
better to read the property out from spi_imx_sdma_init():

	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;

	if (!of_property_read_u32(np, "dma-wml", &wml)) {
		if (!wml || wml > spi_imx_get_fifosize(spi_imx)) /* power of 2 also? */
			dev_warn(&pdev->dev, "mis-configured dma-wml\n");
		else
			spi_imx->wml = wml;
	}

>  	if (mxc_platform_info) {
>  		master->num_chipselect = mxc_platform_info->num_chipselect;
>  		master->cs_gpios = devm_kzalloc(&master->dev,
> 

For v2 please add to cc list:
* Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
* Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
* Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
