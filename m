From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 7/7] spi: imx: defer spi initialization, if DMA engine
 is pending
Date: Sat, 14 Nov 2015 11:03:25 +0100
Message-ID: <564706ED.70102@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-8-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105085926.GK8526@pengutronix.de> <563B8157.9030104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563B8157.9030104-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 05.11.2015 17:18, Anton Bondarenko wrote:
> On 05.11.2015 09:59, Sascha Hauer wrote:
>> On Sun, Nov 01, 2015 at 03:41:41PM +0100, Anton Bondarenko wrote:
>>> From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>>
>>> If SPI device supports DMA mode, but DMA controller is not yet
>>> available due to e.g. a delay in the corresponding kernel module
>>> initialization, retry to initialize SPI driver later on instead of
>>> falling back into PIO only mode.
>>>
>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>
>> Ok, so 6/7 is only part of the deferral story. Maybe squash the two
>> patches into one?
>>
>> Sascha
>
> I would like to keep these two changes separately since I have a small
> concern about this exact change.
>
> Let's assume such scenario:
> - ECSPI configured to use DMA in device tree and DMA controller
> description specified. But there is no driver for this controller in
> kernel.
> In this case dmaengine will always return -EDEFER and driver postpone
> spi-imx initialization. So finally there will be no SPI support even in
> PIO mode.
> Or for example spi-imx will be compiled into kernel, but DMA controller
> driver will be on SPI-NOR based rootfs.
>
> So the question is "Should we allow user to use incorrect combination of
> kernel configuration and DTS and work at least with some limitation?" Or
> should we try to guarantee device tree file requirement to use DMA.
>
> Any thoughts?
>
> Regards, Anton

Does anyone has other comments regarding this commit?

Regards, Anton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
