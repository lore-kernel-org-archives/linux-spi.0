From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
	through dt
Date: Fri, 1 Aug 2014 21:24:52 +0300
Message-ID: <53DBDB74.3070205@ti.com>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
	<1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
	<20140801173506.GB30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Ian Campbell
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140801173506.GB30458-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/01/2014 08:35 PM, Mark Brown wrote:
> On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>>
>> Currently driver supports only configuration of GPIO CS through
>> platform data. This patch enhances the driver to configure GPIO
>> CS through DT. Also update the DT binding documentation to
>> reflect the availability of cs-gpios.
> 
> Ah, sorry - this is the unapplied patch from before.  It would have been
> much better to submit this as the second patch after your rework patch
> since this...
> 

I can do this, but It will wait for a week :(

>> -	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
>> -				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
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
> ...still looks excessively confusing - it is way more logic than I'd
> expect to see on every chip select.
> 

Yep. Finally, patch "[PATCH v2 2/2] spi: davinci: use spi_device.cs_gpio to store gpio cs per spi device"
simplifies logic above.

Regards,
-grygorii
