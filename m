From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: use DMA by default if supported
Date: Mon, 30 May 2016 10:43:28 +0300
Message-ID: <574BEF20.8090105@linux.intel.com>
References: <1464375468-11510-1-git-send-email-dan@emutex.com>
 <87oa7rgvcz.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org,
	haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oa7rgvcz.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/27/2016 10:21 PM, Robert Jarzmik wrote:
> Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org> writes:
>
> Let me add Jarkko and Mika to the review, they were active in the driver's DMA
> area lately.
>
> Cheers.
>
> --
> Robert
>
> [1] Dan's patch
>> Currently, even if the PXA2xx SPI master supports DMA, it won't be
>> enabled unless (i) the slave device is enumerated through ACPI, or
>> (ii) the slave device is registered with board-specific
>> controller_data specified.  Even then, there isn't a field in the
>> controller_data that explicitly enables dma - it just gets enabled
>> if the master supports it and controller_data is non-NULL.
>>
>> This means that drivers which register SPI devices on a bus without
>> awareness of this controller cannot avail of DMA performance gains.
>>
>> This patch allows DMA transfers to be used if supported.
>>
Makes sense to me. I've noticed this too but haven't actually touched it 
if some legacy stuff depends on it. Given that legacy PXA DMA support 
has been dropped it's probably time to get this cleanup too.

Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
