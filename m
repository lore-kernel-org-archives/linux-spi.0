From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Allow device tree devices to use DMA
Date: Sun, 20 Nov 2016 11:01:02 -0600
Message-ID: <946d60bc-ac14-7934-c1b3-e2de03831459@lechnology.com>
References: <1479530464-12538-1-git-send-email-david@lechnology.com>
 <79f186b5-ac71-189f-c19f-977670395043@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79f186b5-ac71-189f-c19f-977670395043-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/20/2016 06:59 AM, Sekhar Nori wrote:
> On Saturday 19 November 2016 10:11 AM, David Lechner wrote:
>> This makes SPI devices specified in a device tree use DMA when the master
>> controller has DMA configured.
>>
>> Since device tree is supposed to only describe the hardware, adding a
>> configuration option to device tree to enable DMA per-device would not be
>> acceptable. So, this is the best we can do for now to get SPI devices
>> working with DMA when using device tree.
>>
>> Unfortunately, this excludes the possibility of using one SPI device with
>> DMA and one without on the same master.
>>
>> I have tested this on LEGO MINDSTORMS EV3 using the NOR flash. Reading the
>> flash memory would fail with -EIO when DMA is not enabled for the device.
>>
>> Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
>> ---
>>  drivers/spi/spi-davinci.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index d36c11b..c6cf73a 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -388,6 +388,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
>>  static int davinci_spi_of_setup(struct spi_device *spi)
>>  {
>>  	struct davinci_spi_config *spicfg = spi->controller_data;
>> +	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
>>  	struct device_node *np = spi->dev.of_node;
>>  	u32 prop;
>>
>> @@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
>>  		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
>>  			spicfg->wdelay = (u8)prop;
>>  		spi->controller_data = spicfg;
>> +		/* Use DMA for device if master supports it */
>> +		if (dspi->dma_rx)
>
> This should be
>
> 		if (!(IS_ERR(dpsi->dma_rx) || IS_ERR(dspi->dma_tx))


There is the following code in davinci_spi_probe():

	ret = davinci_spi_request_dma(dspi);
	if (ret == -EPROBE_DEFER) {
		goto free_clk;
	} else if (ret) {
		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
		dspi->dma_rx = NULL;
		dspi->dma_tx = NULL;
	}

So, I does not look like it is possible to get anything other than NULL 
or a valid pointer for dpsi->dma_rx and that checking dpsi->dma_tx is 
not necessary.

So, I think if (dspi->dma_rx) is sufficient. In fact the same check is 
used during unwinding if the probe function fails.

>
>> +			spicfg->io_type = SPI_IO_TYPE_DMA;
>
> Otherwise looks good to me.
>
> Thanks,
> Sekhar
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
