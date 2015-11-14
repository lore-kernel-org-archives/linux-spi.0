From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/7] spi: imx: return error from dma channel request
Date: Sat, 14 Nov 2015 11:05:31 +0100
Message-ID: <5647076B.3080709@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-7-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105085637.GJ8526@pengutronix.de> <563B7D1C.7010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563B7D1C.7010105-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 05.11.2015 17:00, Anton Bondarenko wrote:
> On 05.11.2015 09:56, Sascha Hauer wrote:
>> On Sun, Nov 01, 2015 at 03:41:40PM +0100, Anton Bondarenko wrote:
>>> From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>>
>>> On SDMA initialization return exactly the same error, which is
>>> reported by dma_request_slave_channel_reason(), it is a preceding
>>> change to defer SPI DMA initialization, if SDMA module is not yet
>>> available.
>>
>> Maybe something like: "fix probe deferral when dmaengine is not yet
>> available" in the subject line will better express that this is a patch
>> that should be applied ASAP. Also you can move this up to the front of
>> the series when resending.
>>
>> Sascha
>>
>
> This patch itself does not implement deferral for spi-imx if dmaengine
> not ready. The patch targets 2 things: give a bit more detailed error
> information of SPI dma slave channel initialization error and provide a
> basis for the next patch ([PATCH v3 7/7] spi: imx: defer spi
> initialization, if DMA engine is pending).
>
> Regards, Anton

Does anyone has other comments regarding this commit?

Regards, Anton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
