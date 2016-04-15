From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: pic32-sqi: add SPI driver for PIC32 SQI
 controller.
Date: Fri, 15 Apr 2016 11:59:55 +0530
Message-ID: <57108A63.50803@microchip.com>
References: <1460553778-1662-1-git-send-email-purna.mandal@microchip.com>
 <1460553778-1662-2-git-send-email-purna.mandal@microchip.com>
 <20160414055546.GA18024@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160414055546.GA18024-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/14/2016 11:25 AM, Mark Brown wrote:

> On Wed, Apr 13, 2016 at 06:52:58PM +0530, Purna Chandra Mandal wrote:
>
>> +	enable = readl(sqi->regs + PESQI_INT_ENABLE_REG);
>> +	status = readl(sqi->regs + PESQI_INT_STAT_REG);
>> +	if (!status)
>> +		return IRQ_NONE;
>> +
> For robustness the check should be if there was anything handled, not if
> there was anything set.

In PESQI controller INT_STAT_REG specifies interrupting reason(s) as usual,
but mostly to confirm completion of on-going DMA operation. It is sticky,
no way to acknowledge the interrupt source except masking the source.
In short, whole interrupt logic is mere extension of status polling logic.

And in driver isr logic is completely depended on the INT_STAT_REG; if status
is zero no handling can be done and is unexpected!

>> +static dma_addr_t pic32_sqi_map_transfer(struct pic32_sqi *sqi,
>> +					 struct spi_transfer *transfer)
>> +{
>> +	struct device *dev = &sqi->master->dev;
> Don't open code DMA mapping of the buffers, use the core support.

Make sense. Will use core support.

>> +	reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	sqi->regs = devm_ioremap_resource(&pdev->dev, reg);
>> +	if (!sqi->regs) {
>> +		dev_err(&pdev->dev, "mem map failed\n");
> devm_ioremap_resource() will log for you.

ack.

>> +	clk_prepare_enable(sqi->sys_clk);
>> +	clk_prepare_enable(sqi->base_clk);
> Check the return value please.

Will add.

>> +	/* install irq handlers */
>> +	ret = devm_request_irq(&pdev->dev, sqi->irq, pic32_sqi_isr,
>> +			       0, dev_name(&pdev->dev), sqi);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "request-irq %d, failed ?\n", sqi->irq);
>> +		goto err_free_ring;
>> +	}
> This will free before the clocks are disabled.  Are you sure that's
> safe?  It's generally not good to mix devm_ and non-devm operations
> especially things like these that aren't simple frees of data.  It is
> safer to use a normal request_irq().

Yes, will use request_irq() instead.

>> +static int pic32_sqi_remove(struct platform_device *pdev)
>> +{
>> +	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
>> +
>> +	clk_disable_unprepare(sqi->base_clk);
>> +	clk_disable_unprepare(sqi->sys_clk);
>> +
>> +	/* release memory */
>> +	ring_desc_ring_free(sqi);
> This will free the descriptor ring before the interrupt...

ack, Will correct disable/free order.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
