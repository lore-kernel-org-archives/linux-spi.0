From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH/RFC 1/2] spi: sh-msiof: Add DT support to DMA setup
Date: Fri, 20 Jun 2014 13:52:59 +0100
Message-ID: <20140620125259.GL30188@leverpostej>
References: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
 <1403259638-13774-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403259638-13774-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Fri, Jun 20, 2014 at 11:20:37AM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The format of the DMA specifiers depends on the DT bindings for SHDMA,
> which are still under development.
> 
>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 17 +++++++++++++--
>  drivers/spi/spi-sh-msiof.c                         | 25 ++++++++++++++++------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> index f24baf3b6cc1..fc56e312c0bc 100644
> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> @@ -7,7 +7,13 @@ Required properties:
>  			 Examples with soctypes are:
>  			 "renesas,msiof-r8a7790" (R-Car H2)
>  			 "renesas,msiof-r8a7791" (R-Car M2)
> -- reg                  : Offset and length of the register set for the device
> +- reg                  : A list of offsets and lengths of the register sets for
> +			 the device.
> +			 If only one register set is present, it is to be used
> +			 by both the CPU and the DMA engine.
> +			 If two register sets are present, the first is to be
> +			 used by the CPU, and the second is to be used by the
> +			 DMA engine.

I'm missing something here. I'm we're providing the DMA engines through
DMA specifiers below, then why do we need the DMA engine address here?
Surely they're separate device nodes?

The code update doesn't seem to do anything with the additional reg
entry.

Thanks,
Mark.

>  - interrupt-parent     : The phandle for the interrupt controller that
>  			 services interrupts for this device
>  - interrupts           : Interrupt specifier
> @@ -17,6 +23,10 @@ Required properties:
>  Optional properties:
>  - clocks               : Must contain a reference to the functional clock.
>  - num-cs               : Total number of chip-selects (default is 1)
> +- dmas                 : Must contain a list of two references to DMA
> +			 specifiers, one for transmission, and one for
> +			 reception.
> +- dma-names            : Must contain a list of two DMA names, "tx" and "rx".
>  
>  Optional properties, deprecated for soctype-specific bindings:
>  - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
> @@ -31,9 +41,12 @@ Example:
>  
>  	msiof0: spi@e6e20000 {
>  		compatible = "renesas,msiof-r8a7791";
> -		reg = <0 0xe6e20000 0 0x0064>;
> +		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
>  		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
> +		dmas = <&dma0 R8A7791_DMA_MSIOF0_TX CHCR_TX_32BIT>,
> +		       <&dma0 R8A7791_DMA_MSIOF0_RX CHCR_RX_32BIT>;
> +		dma-names = "tx", "rx";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "disabled";
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 9922ed3a4441..1772d591d6ca 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -964,10 +964,11 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	chan = dma_request_channel(mask, shdma_chan_filter,
> -				  (void *)(unsigned long)id);
> +	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +				(void *)(unsigned long)id, dev,
> +				dir == DMA_MEM_TO_DEV ? "tx" : "rx");
>  	if (!chan) {
> -		dev_warn(dev, "dma_request_channel failed\n");
> +		dev_warn(dev, "dma_request_slave_channel_compat failed\n");
>  		return NULL;
>  	}
>  
> @@ -994,11 +995,21 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
>  	struct platform_device *pdev = p->pdev;
>  	struct device *dev = &pdev->dev;
>  	const struct sh_msiof_spi_info *info = dev_get_platdata(dev);
> +	unsigned int dma_tx_id, dma_rx_id;
>  	const struct resource *res;
>  	struct spi_master *master;
>  
> -	if (!info || !info->dma_tx_id || !info->dma_rx_id)
> -		return 0;	/* The driver assumes no error */
> +	if (dev->of_node) {
> +		/* In the OF case we will get the slave IDs from the DT */
> +		dma_tx_id = 0;
> +		dma_rx_id = 0;
> +	} else if (info && info->dma_tx_id && info->dma_rx_id) {
> +		dma_tx_id = info->dma_tx_id;
> +		dma_rx_id = info->dma_rx_id;
> +	} else {
> +		/* The driver assumes no error */
> +		return 0;
> +	}
>  
>  	/* The DMA engine uses the second register set, if present */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> @@ -1007,13 +1018,13 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
>  
>  	master = p->master;
>  	master->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
> -						   info->dma_tx_id,
> +						   dma_tx_id,
>  						   res->start + TFDR);
>  	if (!master->dma_tx)
>  		return -ENODEV;
>  
>  	master->dma_rx = sh_msiof_request_dma_chan(dev, DMA_DEV_TO_MEM,
> -						   info->dma_rx_id,
> +						   dma_rx_id,
>  						   res->start + RFDR);
>  	if (!master->dma_rx)
>  		goto free_tx_chan;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
