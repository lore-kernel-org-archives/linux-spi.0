From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc2] SPI -- Freescale iMX SPI
	controller driver
Date: Tue, 19 Feb 2008 00:05:40 -0800
Message-ID: <200802190005.41396.david-b@pacbell.net>
References: <FLEPLOLKEPNLMHOILNHPCEJPECAA.a.paterniani@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linux ARM Kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: "Andrea Paterniani" <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <FLEPLOLKEPNLMHOILNHPCEJPECAA.a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 18 February 2008, Andrea Paterniani wrote:
> This patch fixes 2 bugs:
> > flush() function revised.
> > End of transfers management revised.

But what bugs were fixed??  "Revised" is useless to anyone trying
to understand changes in a driver.


> > Some cosmetics changes.

Again, describe these...

> 
> Signed-off-by: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
> ---
> 
> diff -uprN -X linux-2.6.25-rc2/Documentation/dontdiff linux-2.6.25-rc2/drivers/spi/spi_imx.c
> linux-2.6.25-rc2-spi_imx/drivers/spi/spi_imx.c
> --- linux-2.6.25-rc2/drivers/spi/spi_imx.c	2008-02-18 15:44:24.000000000 +0100
> +++ linux-2.6.25-rc2-spi_imx/drivers/spi/spi_imx.c	2008-02-18 15:44:24.000000000 +0100
> @@ -270,19 +270,26 @@ struct chip_data {
> 
>  static void pump_messages(struct work_struct *work);
> 
> -static int flush(struct driver_data *drv_data)
> +static void flush(struct driver_data *drv_data)
>  {
> -	unsigned long limit = loops_per_jiffy << 1;
> -	void __iomem *regs = drv_data->regs;
> -	volatile u32 d;
> +	void __iomem *regs = drv_data->regs;

Something's odd with your patch generation; that "regs = ..." line
didn't change at all.


> +	u32 control;
> 
>  	dev_dbg(&drv_data->pdev->dev, "flush\n");
> +
> +	/* Wait for end of transaction */
>  	do {
> -		while (readl(regs + SPI_INT_STATUS) & SPI_STATUS_RR)
> -			d = readl(regs + SPI_RXDATA);
> -	} while ((readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH) && limit--);

No endless looping, good (although done badly, since the
timeout should be fixed and not dependent on whatever 2/HZ
happens to be) ...


> +		control = readl(regs + SPI_CONTROL);
> +	} while (control & SPI_CONTROL_XCH);

... replaced by endless looping??  Bad!!  Please restore
a limit mechanism.  (Fixing it would be good.)


> +
> +	/* Release chip select if requested, transfer delays are
> +	   handled in pump_transfers */
> +	if (drv_data->cs_change)
> +		drv_data->cs_control(SPI_CS_DEASSERT);
> 
> -	return limit;
> +	/* Disable SPI to flush FIFOs */
> +	writel(control & ~SPI_CONTROL_SPIEN, regs + SPI_CONTROL);
> +	writel(control, regs + SPI_CONTROL);

I'm not following.  If you're going to flush FIFOs, that
needs to be done before deasserting chipselect.  But on the
other hand, once the transaction has ended, why would a FIFO
possibly be non-empty?  If the idea is to discard RX data,
that should show up in the comments... and maybe even as a
better function name.  (You're changing all callers anyway,
to have no return value, so fixing the name is easy.)


>  }
> 
>  static void restore_state(struct driver_data *drv_data)
> @@ -570,6 +577,7 @@ static void giveback(struct spi_message
>  	writel(0, regs + SPI_INT_STATUS);
>  	writel(0, regs + SPI_DMA);
> 
> +	/* Unconditioned deselct */
>  	drv_data->cs_control(SPI_CS_DEASSERT);
> 
>  	message->state = NULL;
> @@ -592,13 +600,10 @@ static void dma_err_handler(int channel,
>  	/* Disable both rx and tx dma channels */
>  	imx_dma_disable(drv_data->rx_channel);
>  	imx_dma_disable(drv_data->tx_channel);
> -
> -	if (flush(drv_data) == 0)
> -		dev_err(&drv_data->pdev->dev,
> -				"dma_err_handler - flush failed\n");
> -
>  	unmap_dma_buffers(drv_data);
> 
> +	flush(drv_data);
> +
>  	msg->state = ERROR_STATE;
>  	tasklet_schedule(&drv_data->pump_transfers);
>  }
> @@ -612,8 +617,7 @@ static void dma_tx_handler(int channel,
>  	imx_dma_disable(channel);
> 
>  	/* Now waits for TX FIFO empty */
> -	writel(readl(drv_data->regs + SPI_INT_STATUS) | SPI_INTEN_TE,
> -			drv_data->regs + SPI_INT_STATUS);
> +	writel(SPI_INTEN_TE, drv_data->regs + SPI_INT_STATUS);

That doesn't exactly "wait" for anything does it?  Comment needs fixing...


>  }
> 
>  static irqreturn_t dma_transfer(struct driver_data *drv_data)
> @@ -621,19 +625,17 @@ static irqreturn_t dma_transfer(struct d
>  	u32 status;
>  	struct spi_message *msg = drv_data->cur_msg;
>  	void __iomem *regs = drv_data->regs;
> -	unsigned long limit;
> 
>  	status = readl(regs + SPI_INT_STATUS);
> 
> -	if ((status & SPI_INTEN_RO) && (status & SPI_STATUS_RO)) {
> +	if ((status & (SPI_INTEN_RO | SPI_STATUS_RO)) == (SPI_INTEN_RO | SPI_STATUS_RO)) {
>  		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
> 
> +		imx_dma_disable(drv_data->tx_channel);
>  		imx_dma_disable(drv_data->rx_channel);
>  		unmap_dma_buffers(drv_data);
> 
> -		if (flush(drv_data) == 0)
> -			dev_err(&drv_data->pdev->dev,
> -				"dma_transfer - flush failed\n");
> +		flush(drv_data);
> 
>  		dev_warn(&drv_data->pdev->dev,
>  				"dma_transfer - fifo overun\n");
> @@ -649,20 +651,16 @@ static irqreturn_t dma_transfer(struct d
> 
>  		if (drv_data->rx) {
>  			/* Wait end of transfer before read trailing data */
> -			limit = loops_per_jiffy << 1;
> -			while ((readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH) &&
> -					limit--);
> -
> -			if (limit == 0)
> -				dev_err(&drv_data->pdev->dev,
> -					"dma_transfer - end of tx failed\n");
> -			else
> -				dev_dbg(&drv_data->pdev->dev,
> -					"dma_transfer - end of tx\n");
> +			while (readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH);

Again ... there *SHOULD* be a limit on such looping.
It shouldn't be 2/HZ, though having it depend on the
clock rate used to talk to the device may make sense.

It's also good style to have cpu_relax() inside such
loops.


> 
>  			imx_dma_disable(drv_data->rx_channel);
>  			unmap_dma_buffers(drv_data);
> 
> +			/* Release chip select if requested, transfer delays are
> +			   handled in pump_transfers() */
> +			if (drv_data->cs_change)
> +				drv_data->cs_control(SPI_CS_DEASSERT);
> +
>  			/* Calculate number of trailing data and read them */
>  			dev_dbg(&drv_data->pdev->dev,
>  				"dma_transfer - test = 0x%08X\n",
> @@ -676,19 +674,12 @@ static irqreturn_t dma_transfer(struct d
>  			/* Write only transfer */
>  			unmap_dma_buffers(drv_data);
> 
> -			if (flush(drv_data) == 0)
> -				dev_err(&drv_data->pdev->dev,
> -					"dma_transfer - flush failed\n");
> +			flush(drv_data);
>  		}
> 
>  		/* End of transfer, update total byte transfered */
>  		msg->actual_length += drv_data->len;
> 
> -		/* Release chip select if requested, transfer delays are
> -		   handled in pump_transfers() */
> -		if (drv_data->cs_change)
> -			drv_data->cs_control(SPI_CS_DEASSERT);
> -
>  		/* Move to next transfer */
>  		msg->state = next_transfer(drv_data);
> 
> @@ -711,44 +702,43 @@ static irqreturn_t interrupt_wronly_tran
> 
>  	status = readl(regs + SPI_INT_STATUS);
> 
> -	while (status & SPI_STATUS_TH) {
> +	if (status & SPI_INTEN_TE) {
> +		/* TXFIFO Empty Interrupt on the last transfered word */
> +		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
>  		dev_dbg(&drv_data->pdev->dev,
> -			"interrupt_wronly_transfer - status = 0x%08X\n", status);
> +			"interrupt_wronly_transfer - end of tx\n");
> 
> -		/* Pump data */
> -		if (write(drv_data)) {
> -			writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
> -				regs + SPI_INT_STATUS);
> +		flush(drv_data);
> 
> -			dev_dbg(&drv_data->pdev->dev,
> -				"interrupt_wronly_transfer - end of tx\n");
> +		/* Update total byte transfered */
> +		msg->actual_length += drv_data->len;
> 
> -			if (flush(drv_data) == 0)
> -				dev_err(&drv_data->pdev->dev,
> -					"interrupt_wronly_transfer - "
> -					"flush failed\n");
> +		/* Move to next transfer */
> +		msg->state = next_transfer(drv_data);
> 
> -			/* End of transfer, update total byte transfered */
> -			msg->actual_length += drv_data->len;
> +		/* Schedule transfer tasklet */
> +		tasklet_schedule(&drv_data->pump_transfers);
> 
> -			/* Release chip select if requested, transfer delays are
> -			   handled in pump_transfers */
> -			if (drv_data->cs_change)
> -				drv_data->cs_control(SPI_CS_DEASSERT);
> +		return IRQ_HANDLED;
> +	} else {
> +		while (status & SPI_STATUS_TH) {
> +			dev_dbg(&drv_data->pdev->dev,
> +				"interrupt_wronly_transfer - status = 0x%08X\n",
> +				status);
> 
> -			/* Move to next transfer */
> -			msg->state = next_transfer(drv_data);
> +			/* Pump data */
> +			if (write(drv_data)) {
> +				/* End of TXFIFO writes,
> +				   now wait until TXFIFO is empty */
> +				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
> +				return IRQ_HANDLED;
> +			}
> 
> -			/* Schedule transfer tasklet */
> -			tasklet_schedule(&drv_data->pump_transfers);
> +			status = readl(regs + SPI_INT_STATUS);
> 
> -			return IRQ_HANDLED;
> +			/* We did something */
> +			handled = IRQ_HANDLED;
>  		}
> -
> -		status = readl(regs + SPI_INT_STATUS);
> -
> -		/* We did something */
> -		handled = IRQ_HANDLED;
>  	}
> 
>  	return handled;
> @@ -758,45 +748,31 @@ static irqreturn_t interrupt_transfer(st
>  {
>  	struct spi_message *msg = drv_data->cur_msg;
>  	void __iomem *regs = drv_data->regs;
> -	u32 status;
> +	u32 status, control;
>  	irqreturn_t handled = IRQ_NONE;
>  	unsigned long limit;
> 
>  	status = readl(regs + SPI_INT_STATUS);
> 
> -	while (status & (SPI_STATUS_TH | SPI_STATUS_RO)) {
> +	if (status & SPI_INTEN_TE) {
> +		/* TXFIFO Empty Interrupt on the last transfered word */
> +		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
>  		dev_dbg(&drv_data->pdev->dev,
> -			"interrupt_transfer - status = 0x%08X\n", status);
> -
> -		if (status & SPI_STATUS_RO) {
> -			writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
> -				regs + SPI_INT_STATUS);
> -
> -			dev_warn(&drv_data->pdev->dev,
> -				"interrupt_transfer - fifo overun\n"
> -				"    data not yet written = %d\n"
> -				"    data not yet read    = %d\n",
> -				data_to_write(drv_data),
> -				data_to_read(drv_data));
> -
> -			if (flush(drv_data) == 0)
> -				dev_err(&drv_data->pdev->dev,
> -					"interrupt_transfer - flush failed\n");
> -
> -			msg->state = ERROR_STATE;
> -			tasklet_schedule(&drv_data->pump_transfers);
> +			"interrupt_transfer - end of tx\n");
> 
> -			return IRQ_HANDLED;
> -		}
> -
> -		/* Pump data */
> -		read(drv_data);
> -		if (write(drv_data)) {
> -			writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
> -				regs + SPI_INT_STATUS);
> +		if (msg->state == ERROR_STATE) {
> +			/* RXFIFO overrun was detected and message aborted */
> +			flush(drv_data);
> +		} else {
> +			/* Wait for end of transaction */
> +			do {
> +				control = readl(regs + SPI_CONTROL);
> +			} while (control & SPI_CONTROL_XCH);
> 
> -			dev_dbg(&drv_data->pdev->dev,
> -				"interrupt_transfer - end of tx\n");
> +			/* Release chip select if requested, transfer delays are
> +			   handled in pump_transfers */
> +			if (drv_data->cs_change)
> +				drv_data->cs_control(SPI_CS_DEASSERT);
> 
>  			/* Read trailing bytes */
>  			limit = loops_per_jiffy << 1;
> @@ -810,27 +786,54 @@ static irqreturn_t interrupt_transfer(st
>  				dev_dbg(&drv_data->pdev->dev,
>  					"interrupt_transfer - end of rx\n");
> 
> -			/* End of transfer, update total byte transfered */
> +			/* Update total byte transfered */
>  			msg->actual_length += drv_data->len;
> 
> -			/* Release chip select if requested, transfer delays are
> -			   handled in pump_transfers */
> -			if (drv_data->cs_change)
> -				drv_data->cs_control(SPI_CS_DEASSERT);
> -
>  			/* Move to next transfer */
>  			msg->state = next_transfer(drv_data);
> +		}
> 
> -			/* Schedule transfer tasklet */
> -			tasklet_schedule(&drv_data->pump_transfers);
> +		/* Schedule transfer tasklet */
> +		tasklet_schedule(&drv_data->pump_transfers);
> 
> -			return IRQ_HANDLED;
> -		}
> +		return IRQ_HANDLED;
> +	} else {
> +		while (status & (SPI_STATUS_TH | SPI_STATUS_RO)) {
> +			dev_dbg(&drv_data->pdev->dev,
> +				"interrupt_transfer - status = 0x%08X\n",
> +				status);
> +
> +			if (status & SPI_STATUS_RO) {
> +				/* RXFIFO overrun, abort message end wait
> +				   until TXFIFO is empty */
> +				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
> +
> +				dev_warn(&drv_data->pdev->dev,
> +					"interrupt_transfer - fifo overun\n"
> +					"    data not yet written = %d\n"
> +					"    data not yet read    = %d\n",
> +					data_to_write(drv_data),
> +					data_to_read(drv_data));
> +
> +				msg->state = ERROR_STATE;
> +
> +				return IRQ_HANDLED;
> +			}
> 
> -		status = readl(regs + SPI_INT_STATUS);
> +			/* Pump data */
> +			read(drv_data);
> +			if (write(drv_data)) {
> +				/* End of TXFIFO writes,
> +				   now wait until TXFIFO is empty */
> +				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
> +				return IRQ_HANDLED;
> +			}
> 
> -		/* We did something */
> -		handled = IRQ_HANDLED;
> +			status = readl(regs + SPI_INT_STATUS);
> +
> +			/* We did something */
> +			handled = IRQ_HANDLED;
> +		}
>  	}
> 
>  	return handled;
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
