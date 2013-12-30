From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 3/8] spi: rspi: Add support for more than one interrupt
Date: Tue, 31 Dec 2013 00:38:49 +0100
Message-ID: <2037815.gDYqhVmlrl@avalon>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org> <1387885248-28425-4-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387885248-28425-4-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Tuesday 24 December 2013 12:40:43 Geert Uytterhoeven wrote:
> Add support for up to 3 interrupts, based on the SDK reference code.
> This is needed for RZ/A1H.
> 
> Minimum 1 and maximum 3 interrupts can be passed via platform device
> resources.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> ---
>  drivers/spi/spi-rspi.c   |   57 +++++++++++++++++++++++++++----------------
>  include/linux/spi/rspi.h |    2 +-
>  2 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 46232e3b6e8c..c7bbc54ef785 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1,7 +1,7 @@
>  /*
>   * SH RSPI driver
>   *
> - * Copyright (C) 2012  Renesas Solutions Corp.
> + * Copyright (C) 2012, 2013  Renesas Solutions Corp.
>   *
>   * Based on spi-sh.c:
>   * Copyright (C) 2011 Renesas Solutions Corp.
> @@ -167,6 +167,7 @@
>  #define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number 
*/
> 
>  #define DUMMY_DATA		0x00
> +#define MAX_NUM_IRQ		3
> 
>  struct rspi_data {
>  	void __iomem *addr;
> @@ -178,12 +179,13 @@ struct rspi_data {
>  	spinlock_t lock;
>  	struct clk *clk;
>  	u8 spsr;
> +	int irq[MAX_NUM_IRQ];

Should this field be called irqs ?

> +	unsigned int numirq;

This driver seems to use underscores to separate words in variable names, 
maybe you could use num_irq (or num_irqs) instead.

>  	const struct spi_ops *ops;
> 
>  	/* for dmaengine */
>  	struct dma_chan *chan_tx;
>  	struct dma_chan *chan_rx;
> -	int irq;
> 
>  	unsigned dma_width_16bit:1;
>  	unsigned dma_callbacked:1;
> @@ -462,7 +464,7 @@ static int rspi_send_dma(struct rspi_data *rspi, struct
> spi_transfer *t) const void *buf = NULL;
>  	struct dma_async_tx_descriptor *desc;
>  	unsigned len;
> -	int ret = 0;
> +	int i, ret = 0;

i is an unsigned loop index, could you please make it an unsigned int ?

>  	if (rspi->dma_width_16bit) {
>  		void *tmp;
> @@ -499,7 +501,8 @@ static int rspi_send_dma(struct rspi_data *rspi, struct
> spi_transfer *t) * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine
> will be * called. So, this driver disables the IRQ while DMA transfer.
>  	 */
> -	disable_irq(rspi->irq);
> +	for (i = 0; i < rspi->numirq; i++)
> +		disable_irq(rspi->irq[i]);
> 
>  	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD, RSPI_SPCR);
>  	rspi_enable_irq(rspi, SPCR_SPTIE);
> @@ -518,7 +521,8 @@ static int rspi_send_dma(struct rspi_data *rspi, struct
> spi_transfer *t) ret = -ETIMEDOUT;
>  	rspi_disable_irq(rspi, SPCR_SPTIE);
> 
> -	enable_irq(rspi->irq);
> +	for (i = 0; i < rspi->numirq; i++)
> +		enable_irq(rspi->irq[i]);
> 
>  end:
>  	rspi_dma_unmap_sg(&sg, rspi->chan_tx, DMA_TO_DEVICE);
> @@ -628,7 +632,7 @@ static int rspi_receive_dma(struct rspi_data *rspi,
> struct spi_transfer *t) void *dummy = NULL, *rx_buf = NULL;
>  	struct dma_async_tx_descriptor *desc, *desc_dummy;
>  	unsigned len;
> -	int ret = 0;
> +	int i, ret = 0;

Same here.

>  	if (rspi->dma_width_16bit) {
>  		/*
> @@ -685,7 +689,8 @@ static int rspi_receive_dma(struct rspi_data *rspi,
> struct spi_transfer *t) * DMAC needs SPTIE, but if SPTIE is set, this IRQ
> routine will be * called. So, this driver disables the IRQ while DMA
> transfer.
>  	 */
> -	disable_irq(rspi->irq);
> +	for (i = 0; i < rspi->numirq; i++)
> +		disable_irq(rspi->irq[i]);
> 
>  	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD, RSPI_SPCR);
>  	rspi_enable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
> @@ -708,7 +713,8 @@ static int rspi_receive_dma(struct rspi_data *rspi,
> struct spi_transfer *t) ret = -ETIMEDOUT;
>  	rspi_disable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
> 
> -	enable_irq(rspi->irq);
> +	for (i = 0; i < rspi->numirq; i++)
> +		enable_irq(rspi->irq[i]);
> 
>  end:
>  	rspi_dma_unmap_sg(&sg, rspi->chan_rx, DMA_FROM_DEVICE);
> @@ -918,7 +924,7 @@ static int rspi_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct spi_master *master;
>  	struct rspi_data *rspi;
> -	int ret, irq;
> +	int i, ret, irq;

Same here.

>  	char clk_name[16];
>  	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
>  	const struct spi_ops *ops;
> @@ -931,12 +937,6 @@ static int rspi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "platform_get_irq error\n");
> -		return -ENODEV;
> -	}
> -
>  	master = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
>  	if (master == NULL) {
>  		dev_err(&pdev->dev, "spi_alloc_master error.\n");
> @@ -948,6 +948,19 @@ static int rspi_probe(struct platform_device *pdev)
>  	rspi->ops = ops;
>  	rspi->master = master;
> 
> +	for (i = 0; i < MAX_NUM_IRQ; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			if (rspi->numirq)
> +				break;
> +			dev_err(&pdev->dev, "platform_get_irq error\n");
> +			ret = -ENODEV;
> +			goto error1;
> +		}
> +		rspi->irq[i] = irq;
> +		rspi->numirq++;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rspi->addr = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rspi->addr)) {
> @@ -979,14 +992,16 @@ static int rspi_probe(struct platform_device *pdev)
>  	master->transfer = rspi_transfer;
>  	master->cleanup = rspi_cleanup;
> 
> -	ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
> -			       dev_name(&pdev->dev), rspi);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "request_irq error\n");
> -		goto error1;
> +	for (i = 0; i < rspi->numirq; i++) {
> +		ret = devm_request_irq(&pdev->dev, rspi->irq[i], rspi_irq, 0,
> +				       dev_name(&pdev->dev), rspi);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "request_irq %d error\n",
> +				rspi->irq[i]);
> +			goto error1;
> +		}
>  	}

Just an idea, what about combining the two loops ?

> -	rspi->irq = irq;
>  	ret = rspi_request_dma(rspi, pdev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
> diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
> index a25bd6f65e7f..3f55232f74ff 100644
> --- a/include/linux/spi/rspi.h
> +++ b/include/linux/spi/rspi.h
> @@ -1,7 +1,7 @@
>  /*
>   * Renesas SPI driver
>   *
> - * Copyright (C) 2012  Renesas Solutions Corp.
> + * Copyright (C) 2012, 2013  Renesas Solutions Corp.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by

This change seems to be unrelated. You might want to squash it into patch 1/8.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
