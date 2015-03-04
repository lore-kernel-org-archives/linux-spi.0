From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/2] spi: dw-spi: Pointers select 16b vs. 32b
 DesignWare access
Date: Wed, 04 Mar 2015 22:55:25 +0200
Message-ID: <1425502525.14897.185.camel@linux.intel.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>
	 <1425501075-17081-3-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, grant.likely@linaro.org, jkosina@suse.cz,
	pawel.moll@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, tthayer.linux@gmail.com,
	axel.lin@ingics.com, baruch@tkos.co.il, jg1.han@samsung.com,
	galak@codeaurora.org
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425501075-17081-3-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2015-03-04 at 14:31 -0600, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Altera's Arria10 SoC requires a 32 bit access for peripherals.
> The current spi-dw driver uses 16bit accesses in some locations.
> Use function pointers to support 32 bit accesses and not break
> legacy 16 bit access.

Besides comment to cover letter few more here.

> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  drivers/spi/spi-dw-mmio.c |    7 ++++++-
>  drivers/spi/spi-dw.c      |   38 ++++++++++++++++++++++----------------
>  drivers/spi/spi-dw.h      |   10 ++++++----
>  3 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index eb03e12..ee77005 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -76,8 +76,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  
>  	num_cs = 4;
>  
> -	if (pdev->dev.of_node)
> +	if (pdev->dev.of_node) {
>  		of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
> +		if (of_property_read_bool(pdev->dev.of_node, "32bit_access")) {
> +			dws->dwread = dw_readl;
> +			dws->dwwrite = dw_writel;
> +		}
> +	}
>  
>  	dws->num_cs = num_cs;
>  
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 05af817..614de7f 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -149,7 +149,7 @@ static inline u32 tx_max(struct dw_spi *dws)
>  	u32 tx_left, tx_room, rxtx_gap;
>  
>  	tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
> -	tx_room = dws->fifo_len - dw_readw(dws, DW_SPI_TXFLR);
> +	tx_room = dws->fifo_len - dws->dwread(dws, DW_SPI_TXFLR);
>  
>  	/*
>  	 * Another concern is about the tx/rx mismatch, we
> @@ -170,7 +170,7 @@ static inline u32 rx_max(struct dw_spi *dws)
>  {
>  	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
>  
> -	return min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR));
> +	return min_t(u32, rx_left, dws->dwread(dws, DW_SPI_RXFLR));
>  }
>  
>  static void dw_writer(struct dw_spi *dws)
> @@ -186,7 +186,7 @@ static void dw_writer(struct dw_spi *dws)
>  			else
>  				txw = *(u16 *)(dws->tx);
>  		}
> -		dw_writew(dws, DW_SPI_DR, txw);
> +		dws->dwwrite(dws, DW_SPI_DR, txw);
>  		dws->tx += dws->n_bytes;
>  	}
>  }
> @@ -194,10 +194,10 @@ static void dw_writer(struct dw_spi *dws)
>  static void dw_reader(struct dw_spi *dws)
>  {
>  	u32 max = rx_max(dws);
> -	u16 rxw;
> +	u32 rxw;
>  
>  	while (max--) {
> -		rxw = dw_readw(dws, DW_SPI_DR);
> +		rxw = dws->dwread(dws, DW_SPI_DR);
>  		/* Care rx only if the transfer's original "rx" is not null */
>  		if (dws->rx_end - dws->len) {
>  			if (dws->n_bytes == 1)
> @@ -299,13 +299,13 @@ EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
>  
>  static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>  {
> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
> +	u32 irq_status = dws->dwread(dws, DW_SPI_ISR);
>  
>  	/* Error handling */
>  	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
> -		dw_readw(dws, DW_SPI_TXOICR);
> -		dw_readw(dws, DW_SPI_RXOICR);
> -		dw_readw(dws, DW_SPI_RXUICR);
> +		dws->dwread(dws, DW_SPI_TXOICR);
> +		dws->dwread(dws, DW_SPI_RXOICR);
> +		dws->dwread(dws, DW_SPI_RXUICR);

Better to issue separate patch first which substitutes those 3 by 1

dw_readw(dws, DW_SPI_ICR);


>  		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
>  		return IRQ_HANDLED;
>  	}
> @@ -329,7 +329,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>  static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  {
>  	struct dw_spi *dws = dev_id;
> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
> +	u32 irq_status = dws->dwread(dws, DW_SPI_ISR) & 0x3f;
>  
>  	if (!irq_status)
>  		return IRQ_NONE;
> @@ -473,10 +473,11 @@ static void pump_transfers(unsigned long data)
>  	 *	2. clk_div is changed
>  	 *	3. control value changes
>  	 */
> -	if (dw_readw(dws, DW_SPI_CTRL0) != cr0 || cs_change || clk_div || imask) {
> +	if (dws->dwread(dws, DW_SPI_CTRL0) != cr0 ||
> +	    cs_change || clk_div || imask) {
>  		spi_enable_chip(dws, 0);
>  
> -		dw_writew(dws, DW_SPI_CTRL0, cr0);
> +		dws->dwwrite(dws, DW_SPI_CTRL0, cr0);
>  
>  		spi_set_clk(dws, chip->clk_div);
>  		spi_chip_sel(dws, spi, 1);

If possible, can you re-base on top of my patchset an re-test?

http://www.spinics.net/lists/linux-spi/msg03004.html


> @@ -486,7 +487,7 @@ static void pump_transfers(unsigned long data)
>  		if (imask)
>  			spi_umask_intr(dws, imask);
>  		if (txlevel)
> -			dw_writew(dws, DW_SPI_TXFLTR, txlevel);
> +			dws->dwwrite(dws, DW_SPI_TXFLTR, txlevel);
>  
>  		spi_enable_chip(dws, 1);
>  	}
> @@ -618,11 +619,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>  		u32 fifo;
>  
>  		for (fifo = 1; fifo < 256; fifo++) {
> -			dw_writew(dws, DW_SPI_TXFLTR, fifo);
> -			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
> +			dws->dwwrite(dws, DW_SPI_TXFLTR, fifo);
> +			if (fifo != dws->dwread(dws, DW_SPI_TXFLTR))
>  				break;
>  		}
> -		dw_writew(dws, DW_SPI_TXFLTR, 0);
> +		dws->dwwrite(dws, DW_SPI_TXFLTR, 0);
>  
>  		dws->fifo_len = (fifo == 1) ? 0 : fifo;
>  		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
> @@ -647,6 +648,11 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
>  	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
>  
> +	if (!dws->dwread)
> +		dws->dwread = dw_readw;
> +	if (!dws->dwwrite)
> +		dws->dwwrite = dw_writew;
> +
>  	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
>  			dws->name, dws);
>  	if (ret < 0) {
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 3d32be6..5ca2407 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -150,6 +150,8 @@ struct dw_spi {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
>  #endif
> +	u32 (*dwread)(struct dw_spi *dws, u32 offset);
> +	void (*dwwrite)(struct dw_spi *dws, u32 offset, u16 val);

u16?!

>  };
>  
>  static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
> @@ -157,14 +159,14 @@ static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>  	return __raw_readl(dws->regs + offset);
>  }
>  
> -static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
> +static inline void dw_writel(struct dw_spi *dws, u32 offset, u16 val)

So, why u16?

>  {
> -	__raw_writel(val, dws->regs + offset);
> +	__raw_writel((u32)val, dws->regs + offset);

Seems like a mess here. Could you figure out, please, what should be
done?

>  }
>  
> -static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
> +static inline u32 dw_readw(struct dw_spi *dws, u32 offset)
>  {
> -	return __raw_readw(dws->regs + offset);
> +	return (u32)__raw_readw(dws->regs + offset);

why readw?

>  }
>  
>  static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)


We have exactly 4 functions. What is wrong to use proper ones?

So, I would appreciate to hear an answer to the question in cover letter
reply and if you reorganizes code to use proper functions.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

