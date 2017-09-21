From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH -next] spi: fix spi-sprd-adi build errors when
 COMPILE_TEST=y
Date: Thu, 21 Sep 2017 11:00:22 -0700
Message-ID: <55e65046-6184-9198-644f-1f253e219729@infradead.org>
References: <1e21f485-7f06-0566-afd4-74f2bfc9606e@infradead.org>
 <20170921164933.hvvwfm6kvha3d5my@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Baolin Wang <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170921164933.hvvwfm6kvha3d5my-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/21/17 09:49, Mark Brown wrote:
> On Thu, Sep 21, 2017 at 09:10:04AM -0700, Randy Dunlap wrote:
> 
>> +++ linux-next-20170921/drivers/spi/Kconfig
>> @@ -625,6 +625,7 @@ config SPI_SIRF
>>  config SPI_SPRD_ADI
>>  	tristate "Spreadtrum ADI controller"
>>  	depends on ARCH_SPRD || COMPILE_TEST
>> +	depends on HWSPINLOCK
>>  	help
>>  	  ADI driver based on SPI for Spreadtrum SoCs.
> 
> Why is this a more sensible fix than providing stubs for HWSPINLOCK?
> 

There are already stubs there. I'll send an updated patch.

-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
