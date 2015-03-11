From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCHv3] spi: dw-spi: Convert 16bit accesses to 32bit accesses
Date: Wed, 11 Mar 2015 16:11:57 -0500
Message-ID: <5500AF9D.8030906@opensource.altera.com>
References: <1426101644-5816-1-git-send-email-tthayer@opensource.altera.com>	 <1426101644-5816-2-git-send-email-tthayer@opensource.altera.com> <1426102087.14897.279.camel@linux.intel.com>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	<wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426102087.14897.279.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

On 03/11/2015 02:28 PM, Andy Shevchenko wrote:
> On Wed, 2015-03-11 at 14:20 -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>
> Thanks my couple of comments below. And I will test your next version
> tomorrow if everything okay on your side (regarding to my comments)
>

Yes, I will make these all these changes and send out an update shortly. 
Thanks for reviewing!

>> Altera's Arria10 SoC interconnect requires a 32 bit write for APB
>> peripherals. The current spi-dw driver uses 16bit accesses in
>> some locations. A review of the Designware SPI IP databook
>> indicates the registers will support 32b read and writes to
>> remain consistent with the AHB bus.
>
> Better to exchange this with what you put on cover letter, i.e. cite
> documentation here, but describe in common there.
>
>>
>> Request for test with existing platforms. Currently tested
>> on Altera CycloneV and Arria10.
>
>>
>> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>> ---
>> r1: Use function pointers to select 16b or 32b accesses.
>>
>> r2: Use 32b version of function pointers for 16b reads and
>> writes.
>>
>> r3: Convert 16b reads and writes to 32b reads and writes. The
>> DW_apb_ssi databook (section 6-1) states:
>> All registers in the DW_apb_ssi are addressed at 32-bit boundaries
>> to remain consistent with the AHB bus. Where the physical size of
>> any register is less than 32-bits wide, the upper unused bits of
>> the 32-bit boundary are reserved. Writing to these bits has no
>> effect; reading from these bits returns 0.
>> ---
>>   drivers/spi/spi-dw.c |   34 +++++++++++++++++-----------------
>>   drivers/spi/spi-dw.h |   10 ----------
>>   2 files changed, 17 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index 0f01069..9451c8a 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -157,7 +157,7 @@ static inline u32 tx_max(struct dw_spi *dws)
>>   	u32 tx_left, tx_room, rxtx_gap;
>>
>>   	tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
>> -	tx_room = dws->fifo_len - dw_readw(dws, DW_SPI_TXFLR);
>> +	tx_room = dws->fifo_len - dw_readl(dws, DW_SPI_TXFLR);
>>
>>   	/*
>>   	 * Another concern is about the tx/rx mismatch, we
>> @@ -178,13 +178,13 @@ static inline u32 rx_max(struct dw_spi *dws)
>>   {
>>   	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
>>
>> -	return min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR));
>> +	return min_t(u32, rx_left, dw_readl(dws, DW_SPI_RXFLR));
>>   }
>>
>>   static void dw_writer(struct dw_spi *dws)
>>   {
>>   	u32 max = tx_max(dws);
>> -	u16 txw = 0;
>> +	u32 txw = 0;
>
> Do we really need to touch types? Can you try without this kind of
> changes?
>

Yes. It compiles and runs without issues. I changed the types because 
truncating/extending doesn't seem as efficient but I'm fine with leaving 
them - fewer changes.

>>
>>   	while (max--) {
>>   		/* Set the tx word if the transfer's original "tx" is not null */
>> @@ -194,18 +194,17 @@ static void dw_writer(struct dw_spi *dws)
>>   			else
>>   				txw = *(u16 *)(dws->tx);
>>   		}
>> -		dw_writew(dws, DW_SPI_DR, txw);
>> +		dw_writel(dws, DW_SPI_DR, txw);
>>   		dws->tx += dws->n_bytes;
>>   	}
>>   }
>>
>>   static void dw_reader(struct dw_spi *dws)
>>   {
>> -	u32 max = rx_max(dws);
>> -	u16 rxw;
>> +	u32 rxw, max = rx_max(dws);
>>
>>   	while (max--) {
>> -		rxw = dw_readw(dws, DW_SPI_DR);
>> +		rxw = dw_readl(dws, DW_SPI_DR);
>>   		/* Care rx only if the transfer's original "rx" is not null */
>>   		if (dws->rx_end - dws->len) {
>>   			if (dws->n_bytes == 1)
>> @@ -228,11 +227,11 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
>>
>>   static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>>   {
>> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
>> +	u32 irq_status = dw_readl(dws, DW_SPI_ISR);
>>
>>   	/* Error handling */
>>   	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
>> -		dw_readw(dws, DW_SPI_ICR);
>> +		dw_readl(dws, DW_SPI_ICR);
>>   		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
>>   		return IRQ_HANDLED;
>>   	}
>> @@ -257,7 +256,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>>   {
>>   	struct spi_master *master = dev_id;
>>   	struct dw_spi *dws = spi_master_get_devdata(master);
>> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
>> +	u32 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
>>
>>   	if (!irq_status)
>>   		return IRQ_NONE;
>> @@ -288,7 +287,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
>>   	struct dw_spi *dws = spi_master_get_devdata(master);
>>   	struct chip_data *chip = spi_get_ctldata(spi);
>>   	u8 imask = 0;
>> -	u16 txlevel = 0;
>> +	u32 txlevel = 0;
>>   	u16 clk_div = 0;
>>   	u32 speed = 0;
>>   	u32 cr0 = 0;
>> @@ -354,7 +353,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
>>   		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
>>   	}
>>
>> -	dw_writew(dws, DW_SPI_CTRL0, cr0);
>> +	dw_writel(dws, DW_SPI_CTRL0, cr0);
>>
>>   	/* Check if current transfer is a DMA transaction */
>>   	if (master->can_dma && master->can_dma(master, spi, transfer))
>> @@ -374,8 +373,9 @@ static int dw_spi_transfer_one(struct spi_master *master,
>>   			return ret;
>>   		}
>>   	} else if (!chip->poll_mode) {
>> -		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
>> -		dw_writew(dws, DW_SPI_TXFLTR, txlevel);
>> +		txlevel = min_t(u32, dws->fifo_len / 2,
>> +				dws->len / dws->n_bytes);
>> +		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
>>
>>   		/* Set the interrupt mask */
>>   		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
>> @@ -499,11 +499,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>>   		u32 fifo;
>>
>>   		for (fifo = 1; fifo < 256; fifo++) {
>> -			dw_writew(dws, DW_SPI_TXFLTR, fifo);
>> -			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
>> +			dw_writel(dws, DW_SPI_TXFLTR, fifo);
>> +			if (fifo != dw_readl(dws, DW_SPI_TXFLTR))
>>   				break;
>>   		}
>> -		dw_writew(dws, DW_SPI_TXFLTR, 0);
>> +		dw_writel(dws, DW_SPI_TXFLTR, 0);
>>
>>   		dws->fifo_len = (fifo == 1) ? 0 : fifo;
>>   		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index 41f77e2..6c91391 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -150,16 +150,6 @@ static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
>>   	__raw_writel(val, dws->regs + offset);
>>   }
>>
>> -static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
>> -{
>> -	return __raw_readw(dws->regs + offset);
>> -}
>> -
>> -static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
>> -{
>> -	__raw_writew(val, dws->regs + offset);
>> -}
>> -
>>   static inline void spi_enable_chip(struct dw_spi *dws, int enable)
>>   {
>>   	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
