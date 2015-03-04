From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [RFC/PATCH 2/2] spi: dw-spi: Pointers select 16b vs. 32b DesignWare
 access
Date: Wed, 4 Mar 2015 16:07:45 -0600
Message-ID: <54F78231.6070005@opensource.altera.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>	 <1425501075-17081-3-git-send-email-tthayer@opensource.altera.com> <1425502525.14897.185.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425502525.14897.185.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

On 03/04/2015 02:55 PM, Andy Shevchenko wrote:
> On Wed, 2015-03-04 at 14:31 -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>
>> Altera's Arria10 SoC requires a 32 bit access for peripherals.
>> The current spi-dw driver uses 16bit accesses in some locations.
>> Use function pointers to support 32 bit accesses and not break
>> legacy 16 bit access.
>
> Besides comment to cover letter few more here.
>
>>
>> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

<snip>

>>
>>   static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>>   {
>> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
>> +	u32 irq_status = dws->dwread(dws, DW_SPI_ISR);
>>
>>   	/* Error handling */
>>   	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
>> -		dw_readw(dws, DW_SPI_TXOICR);
>> -		dw_readw(dws, DW_SPI_RXOICR);
>> -		dw_readw(dws, DW_SPI_RXUICR);
>> +		dws->dwread(dws, DW_SPI_TXOICR);
>> +		dws->dwread(dws, DW_SPI_RXOICR);
>> +		dws->dwread(dws, DW_SPI_RXUICR);
>
> Better to issue separate patch first which substitutes those 3 by 1
>
> dw_readw(dws, DW_SPI_ICR);
>

Yes, I'll do that.

>
>>   		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
>>   		return IRQ_HANDLED;
>>   	}
>> @@ -329,7 +329,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>>   static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>>   {
>>   	struct dw_spi *dws = dev_id;
>> -	u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
>> +	u32 irq_status = dws->dwread(dws, DW_SPI_ISR) & 0x3f;
>>
>>   	if (!irq_status)
>>   		return IRQ_NONE;
>> @@ -473,10 +473,11 @@ static void pump_transfers(unsigned long data)
>>   	 *	2. clk_div is changed
>>   	 *	3. control value changes
>>   	 */
>> -	if (dw_readw(dws, DW_SPI_CTRL0) != cr0 || cs_change || clk_div || imask) {
>> +	if (dws->dwread(dws, DW_SPI_CTRL0) != cr0 ||
>> +	    cs_change || clk_div || imask) {
>>   		spi_enable_chip(dws, 0);
>>
>> -		dw_writew(dws, DW_SPI_CTRL0, cr0);
>> +		dws->dwwrite(dws, DW_SPI_CTRL0, cr0);
>>
>>   		spi_set_clk(dws, chip->clk_div);
>>   		spi_chip_sel(dws, spi, 1);
>
> If possible, can you re-base on top of my patchset an re-test?
>
> http://www.spinics.net/lists/linux-spi/msg03004.html
>

Yes. I can do this. I tested the 16 bit accesses on our Cyclone5 board 
and the 32 bit accesses on the Arria10 board.

>> @@ -486,7 +487,7 @@ static void pump_transfers(unsigned long data)
>>   		if (imask)
>>   			spi_umask_intr(dws, imask);
>>   		if (txlevel)
>> -			dw_writew(dws, DW_SPI_TXFLTR, txlevel);
>> +			dws->dwwrite(dws, DW_SPI_TXFLTR, txlevel);
>>
>>   		spi_enable_chip(dws, 1);
>>   	}
>> @@ -618,11 +619,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>>   		u32 fifo;
>>
>>   		for (fifo = 1; fifo < 256; fifo++) {
>> -			dw_writew(dws, DW_SPI_TXFLTR, fifo);
>> -			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
>> +			dws->dwwrite(dws, DW_SPI_TXFLTR, fifo);
>> +			if (fifo != dws->dwread(dws, DW_SPI_TXFLTR))
>>   				break;
>>   		}
>> -		dw_writew(dws, DW_SPI_TXFLTR, 0);
>> +		dws->dwwrite(dws, DW_SPI_TXFLTR, 0);
>>
>>   		dws->fifo_len = (fifo == 1) ? 0 : fifo;
>>   		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
>> @@ -647,6 +648,11 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>   	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
>>   	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
>>
>> +	if (!dws->dwread)
>> +		dws->dwread = dw_readw;
>> +	if (!dws->dwwrite)
>> +		dws->dwwrite = dw_writew;
>> +
>>   	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
>>   			dws->name, dws);
>>   	if (ret < 0) {
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index 3d32be6..5ca2407 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -150,6 +150,8 @@ struct dw_spi {
>>   #ifdef CONFIG_DEBUG_FS
>>   	struct dentry *debugfs;
>>   #endif
>> +	u32 (*dwread)(struct dw_spi *dws, u32 offset);
>> +	void (*dwwrite)(struct dw_spi *dws, u32 offset, u16 val);
>
> u16?!

Yes, I was trying to minimize legacy code changes to the variables in 
spi-dw.c.  Also the function pointer parameters match for both 16 bit 
and 32 bit. They're promoted in the 32 bit functions.

>>   };
>>
>>   static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>> @@ -157,14 +159,14 @@ static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>>   	return __raw_readl(dws->regs + offset);
>>   }
>>
>> -static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
>> +static inline void dw_writel(struct dw_spi *dws, u32 offset, u16 val)
>
> So, why u16?
>
>>   {
>> -	__raw_writel(val, dws->regs + offset);
>> +	__raw_writel((u32)val, dws->regs + offset);
>
> Seems like a mess here. Could you figure out, please, what should be
> done?

This is the 32 bit promotion I mentioned above.

>
>>   }
>>
>> -static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
>> +static inline u32 dw_readw(struct dw_spi *dws, u32 offset)
>>   {
>> -	return __raw_readw(dws->regs + offset);
>> +	return (u32)__raw_readw(dws->regs + offset);
>
> why readw?
>

This change meant the function pointer parameters matched.

>>   }
>>
>>   static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
>
>
> We have exactly 4 functions. What is wrong to use proper ones?
>

I will revisit the function pointer parameters.

> So, I would appreciate to hear an answer to the question in cover letter
> reply and if you reorganizes code to use proper functions.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
