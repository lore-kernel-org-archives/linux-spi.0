From: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: qup: Remove .owner field for driver
Date: Tue, 14 Oct 2014 11:47:57 +0530
Message-ID: <543CC015.6090709@smartplayin.com>
References: <1412840528-31508-1-git-send-email-kiran.padwal@smartplayin.com> <20141013130918.GY27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141013130918.GY27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday 13 October 2014 06:39 PM, Mark Brown wrote:
> On Thu, Oct 09, 2014 at 01:12:08PM +0530, Kiran Padwal wrote:
>> There is no need to init .owner field.
>>
>> Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> "mmc: remove .owner field for drivers using module_platform_driver"
>>
>> This patch removes the superfluous .owner field for drivers which
>> use the module_platform_driver API, as this is overridden in
>> platform_driver_register anyway."
> 
> Two problems:
>  - I'm missing patches 1 and 2.

These patches are same like this one,
[1] https://lkml.org/lkml/2014/10/9/58
[2] https://lkml.org/lkml/2014/10/9/52

>  - This only changes one driver but essentially every SPI driver
>    initializes .owner - why is only thi sone driver being changed?
> 

Nothing more intention, but just remove superfluous .owner field for drivers which
use the module_platform_driver API, as this is overridden in
platform_driver_register anyway.

Thanks,
--Kiran
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
