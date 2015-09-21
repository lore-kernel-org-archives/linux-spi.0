From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Date: Mon, 21 Sep 2015 10:48:19 +0300
Message-ID: <55FFB643.1080208@linux.intel.com>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com> <87zj0rsqhe.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zj0rsqhe.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

On 09/12/2015 04:43 PM, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
>> build error here because it removed the type LPSS_SSP and I didn't notice
>> the type was used here too.
>>
>> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
>> accidentally by copying all enum pxa_ssp_type types from
>> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>>
>> Fix the build error by removing this incorrect binding.
>>
>> Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Reported-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.2
>> ---
>> v2: Added Fixes tag suggested by Robert Jarzmik
>
> Queued into pxa/fixes, thanks.
>
Gentle reminder, is this going to 4.3-rc3?

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
