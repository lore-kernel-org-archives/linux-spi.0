From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: s3c64xx: extend driver to make full use of runtime
 PM autosuspend
Date: Thu, 20 Aug 2015 07:39:18 +0200
Message-ID: <55D56806.10805@gmail.com>
References: <55D4DF0C.8080104@gmail.com> <55D5154E.3090502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D5154E.3090502-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 20.08.2015 um 01:46 schrieb Krzysztof Kozlowski:
> On 20.08.2015 04:54, Heiner Kallweit wrote:
>> Extend the driver to make full use of runtime PM autosuspend.
>> Before only the SPI core was instructed to use autosuspend
>> by setting master->auto_runtime_pm. Nevertheless due to the missing
>> pm_runtime_use_autosuspend call autosuspend wasn't active.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> 
> I am a little bit confused... it's the same patch? It's not marked as
> resend, not marked as v2 and there is no changelog...
> 
> Best regards,
> Krzysztof
The structure of the patchset significantly changed, therefore I didn't
mark it as v2. But you're right, should have done it.
Will send a v2 incl. the changes based on your remarks + changelog.

Regards, Heiner

>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 8a6ab88..8365c88 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -32,6 +32,7 @@
>>  #define MAX_SPI_PORTS		6
>>  #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>>  #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
>> +#define AUTOSUSPEND_TIMEOUT	2000
>>  
>>  /* Registers and bit-fields */
>>  
>> @@ -859,13 +860,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>  		}
>>  	}
>>  
>> -	pm_runtime_put(&sdd->pdev->dev);
>> +	pm_runtime_mark_last_busy(&sdd->pdev->dev);
>> +	pm_runtime_put_autosuspend(&sdd->pdev->dev);
>>  	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
>>  		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
>>  	return 0;
>>  
>>  setup_exit:
>> -	pm_runtime_put(&sdd->pdev->dev);
>> +	pm_runtime_mark_last_busy(&sdd->pdev->dev);
>> +	pm_runtime_put_autosuspend(&sdd->pdev->dev);
>>  	/* setup() returns with device de-selected */
>>  	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
>>  		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
>> @@ -1180,6 +1183,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>  	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
>>  	       sdd->regs + S3C64XX_SPI_INT_EN);
>>  
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>  	pm_runtime_set_active(&pdev->dev);
>>  	pm_runtime_enable(&pdev->dev);
>>  
>> @@ -1195,6 +1200,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>  					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
>>  					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
>>  
>> +	pm_runtime_mark_last_busy(&pdev->dev);
>> +	pm_runtime_autosuspend(&pdev->dev);
>> +
>>  	return 0;
>>  
>>  err4:
>>
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
