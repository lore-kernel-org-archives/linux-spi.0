From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/3] spi: s3c64xx: fix runtime PM handling
Date: Wed, 19 Aug 2015 21:36:20 +0200
Message-ID: <55D4DAB4.4000901@gmail.com>
References: <55D39E41.8010908@gmail.com> <55D3CF4B.5060208@samsung.com> <55D41A0C.2060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <55D41A0C.2060107@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 19.08.2015 um 07:54 schrieb Heiner Kallweit:
> Am 19.08.2015 um 02:35 schrieb Krzysztof Kozlowski:
>> On 19.08.2015 06:06, Heiner Kallweit wrote:
>>> The patch fixes / extends the runtime PM handling.
>>> - Currently the driver instructs the SPI core to use auto-suspend
>>>   but doesn't configure it. Add the necessary calls and let it
>>>   autosuspend after probe.
>>
>> After quick look at the driver I think it does not use autosuspend
>> fully. It just sets master->auto_runtime_pm (so the core code will use
>> autosuspend) but its own calls to pm_runtime_put() are regular ones.
>> Shouldn't this be enhanced as well?
> Right, the pm_runtime_put calls in s3c64xx_spi_setup should be
> replaced as well. Will provide an updated patch.
>>
>>> - In case the driver registration fails runtime PM needs to be
>>>   properly disabled.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/spi/spi-s3c64xx.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>>> index c4d3b06..15a6de1 100644
>>> --- a/drivers/spi/spi-s3c64xx.c
>>> +++ b/drivers/spi/spi-s3c64xx.c
>>> @@ -32,6 +32,7 @@
>>>  #define MAX_SPI_PORTS		6
>>>  #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>>>  #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
>>> +#define AUTOSUSPEND_TIMEOUT     2000
>>>  
>>>  /* Registers and bit-fields */
>>>  
>>> @@ -1180,13 +1181,15 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>>  	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
>>>  	       sdd->regs + S3C64XX_SPI_INT_EN);
>>>  
>>> +	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_TIMEOUT);
>>> +	pm_runtime_use_autosuspend(dev);
>>>  	pm_runtime_set_active(dev);
>>>  	pm_runtime_enable(dev);
>>>  
>>>  	ret = devm_spi_register_master(dev, master);
>>>  	if (ret != 0) {
>>>  		dev_err(dev, "cannot register SPI master: %d\n", ret);
>>> -		goto err3;
>>> +		goto err4;
>>>  	}
>>>  
>>>  	dev_dbg(dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
>>> @@ -1195,8 +1198,14 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>>  					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
>>>  					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
>>>  
>>> +	pm_runtime_mark_last_busy(dev);
>>> +	pm_runtime_autosuspend(dev);
>>
>> There is a high chance that device will be suspended already at this
>> point because pm_runtime_put() in setup. In most cases (when SPI is
>> started) this won't do anything so we are back at first of my questions
>> - shouldn't you update pm_runtime_put() calls?
> Yes, these calls should be updated.
>>
>> Additionally (which is not related to your patch) shouldn't we
>> pm_runtime_get() at some point in probe() to be sure that it won't be
>> suspended to early?
> Not 100% sure at this moment, I will check.
Kernel documentation says:
"Note, if the device may execute pm_runtime calls during the probe (such as
if it is registers with a subsystem that may call back in) then the
pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
appropriate to ensure that the device is not put back to sleep during the
probe. This can happen with systems such as the network device layer."

I don't think this applies to SPI but I'm not expert enough to guarantee.
At least no other SPI driver using runtime PM protects the probe function this way.
Therefore I would dare to leave it as it is, especially as there don't seem
to be any related known problems with SPI drivers.

Regards, Heiner
>>
>>> +
>>>  	return 0;
>>>  
>>> +err4:
>>> +	pm_runtime_disable(dev);
>>> +	pm_runtime_set_suspended(dev);
>>
>> Please separate fixes from enhancements into different patches.
> OK, will do so.
>>
>> Best regards,
>> Krzysztof
>>
>>>  err3:
>>>  	clk_disable_unprepare(sdd->src_clk);
>>>  err2:
>>>
>>
>>
> 
