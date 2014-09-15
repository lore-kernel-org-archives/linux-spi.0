From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: request cs_gpio's from probe
Date: Mon, 15 Sep 2014 16:06:42 +0300
Message-ID: <5416E462.7010406@ti.com>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com> <20140913162858.GG7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<m-karicheri2-l0cyMroinI0@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140913162858.GG7960-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/13/2014 07:28 PM, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 05:54:00PM +0300, Grygorii Strashko wrote:
> 
>>   static void davinci_spi_cleanup(struct spi_device *spi)
>>   {
>> -	if (spi->cs_gpio >= 0)
>> -		gpio_free(spi->cs_gpio);
>>   }
> 
> This function is now empty so should be removed.  I've applied for now
> but please send a followup fixing this.
> 

The function davinci_spi_cleanup() will be reused by following patch
"[PATCH v3] spi: davinci: add support for adding delay between word's transmissions"
http://www.spinics.net/lists/devicetree/msg49141.html

So, in broonie/spi.git/for-next it will not be empty.

Again, I've missed description of this dependency, sorry for that.

Regards,
-grygorii

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
