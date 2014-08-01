From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: add support to configure gpio cs through
 dt
Date: Fri, 01 Aug 2014 20:29:04 +0300
Message-ID: <53DBCE60.1010308@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com> <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com> <20140731193515.GO17528@sirena.org.uk> <53DBB202.1040509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	santosh.shilimkar-l0cyMroinI0@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53DBB202.1040509-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 08/01/2014 06:28 PM, Grygorii Strashko wrote:
> Hi Mark,
> On 07/31/2014 10:35 PM, Mark Brown wrote:
>> On Thu, Jul 31, 2014 at 08:33:15PM +0300, Grygorii Strashko wrote:
>>
>>> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
>>> +		/* SPI core parse and update master->cs_gpio */
>>>    		gpio_chipsel = true;
>>> +		gpio = spi->cs_gpio;
>>> +	} else if (pdata->chip_sel &&
>>> +		   chip_sel < pdata->num_chipselect &&
>>> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
>>> +		/* platform data defines chip_sel */
>>> +		gpio_chipsel = true;
>>> +		gpio = pdata->chip_sel[chip_sel];
>>> +	}
>>
>> This would all be a lot simpler and more direct if you were to arrange
>> to use cs_gpio in the struct spi_device, and move you closer to
>> converting to use more of the core functionality.
> 
> Unfortunately, I'm not sure this is good idea, because this part of
> code is used by Davinci arch which is non-DT platform.
> As result, this code was kept mostly unchanged.
> 
> I can try to rework it, but I'd like to do it as standalone patch.
> Is it ok for you?

I've just sent updated version with additional patch where
I reworked driver for using cs_gpio for  both DT and non-DT cases.
http://www.spinics.net/lists/arm-kernel/msg352382.html

Regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
