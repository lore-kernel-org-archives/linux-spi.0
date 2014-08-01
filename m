From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: add support to configure gpio cs through
 dt
Date: Fri, 01 Aug 2014 18:28:02 +0300
Message-ID: <53DBB202.1040509@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com> <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com> <20140731193515.GO17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140731193515.GO17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,
On 07/31/2014 10:35 PM, Mark Brown wrote:
> On Thu, Jul 31, 2014 at 08:33:15PM +0300, Grygorii Strashko wrote:
> 
>> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
>> +		/* SPI core parse and update master->cs_gpio */
>>   		gpio_chipsel = true;
>> +		gpio = spi->cs_gpio;
>> +	} else if (pdata->chip_sel &&
>> +		   chip_sel < pdata->num_chipselect &&
>> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
>> +		/* platform data defines chip_sel */
>> +		gpio_chipsel = true;
>> +		gpio = pdata->chip_sel[chip_sel];
>> +	}
> 
> This would all be a lot simpler and more direct if you were to arrange
> to use cs_gpio in the struct spi_device, and move you closer to
> converting to use more of the core functionality.

Unfortunately, I'm not sure this is good idea, because this part of
code is used by Davinci arch which is non-DT platform.
As result, this code was kept mostly unchanged.

I can try to rework it, but I'd like to do it as standalone patch.
Is it ok for you?

> 
>> +		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
>> +			retval =
>> +				gpio_request(spi->cs_gpio, dev_name(&spi->dev));
>> +			if (retval) {
>> +				dev_err(&spi->dev,
>> +					"GPIO %d request failed\n",
>> +					spi->cs_gpio);
>> +				return -ENODEV;
>> +			}
>> +			gpio_direction_output(spi->cs_gpio,
>> +					      !(spi->mode & SPI_CS_HIGH));
>> +			internal_cs = false;
> 
> It's much better to use gpio_request_one() rather than using
> gpio_request(), it's one function apart from anything else.  The above
> is also discarding the return code of gpio_request() meaning it's broken
> for deferred probe.  The error code should also appear in the error
> message.
> 
Thanks, will update.

Regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
