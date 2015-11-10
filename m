From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/7] spi: imx: replace fixed timeout with calculated
 one
Date: Tue, 10 Nov 2015 21:20:06 +0100
Message-ID: <56425176.9060805@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-3-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105084723.GI8526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151105084723.GI8526-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 05.11.2015 09:47, Sascha Hauer wrote:
>> @@ -890,12 +891,40 @@ static void spi_imx_dma_tx_callback(void *cookie)
>>   	complete(&spi_imx->dma_tx_completion);
>>   }
>>
>> +static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
>> +{
>> +	unsigned long coef1 = 1;
>> +	unsigned long coef2 = MSEC_PER_SEC;
>> +	unsigned long timeout = 0;
>> +
>> +	/* Swap coeficients to avoid div by 0 */
>> +	if (spi_imx->spi_bus_clk < MSEC_PER_SEC) {
>> +		coef1 = MSEC_PER_SEC;
>> +		coef2 = 1;
>> +	}
>> +
>> +	/* Time with actual data transfer */
>> +	timeout += DIV_ROUND_UP(8 * size * coef1,
>> +				spi_imx->spi_bus_clk / coef2);
>> +
>> +	/* Take CS change delay related to HW */
>> +	timeout += DIV_ROUND_UP((size - 1) * 4 * coef1,
>> +				spi_imx->spi_bus_clk / coef2);
>> +
>> +	/* Add extra second for scheduler related activities */
>> +	timeout += MSEC_PER_SEC;
>> +
>> +	/* Double calculated timeout */
>> +	return msecs_to_jiffies(2 * timeout);
>> +}
>
> I think you can simplify this function to:
>
> 	timeout = size * 8 / spi_imx->spi_bus_clk;
> 	timeout += 2;
>
> 	return msecs_to_jiffies(timeout * MSEC_PER_SEC);
>
> The rationale is that when size * 8 / spi_imx->spi_bus_clk is 0 then we
> can add another second and be fine. No need to calculate this more
> accurate, in the end it's important to catch the timeout. If we do this
> one or two seconds too late doesn't matter.
>
> Sascha
>

Sascha,

What about something like this:
	timeout = size * (8 + 4) / spi_imx->spi_bus_clk;
	timeout += 2;

	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);

I think we still need to take into account 4 CLKs between each burst.

Regards, Anton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
