From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
Date: Thu, 5 Mar 2020 08:21:38 -0800
Message-ID: <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
 <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
 <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
 <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55edba5c-78d6-12e2-eff6-f16c204badee-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 3/5/20 8:20 AM, John Garry wrote:
> On 05/03/2020 16:01, Joe Perches wrote:
>> On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
>>> On 05/03/2020 15:15, Joe Perches wrote:
>>>> commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
>>>> controller driver") likely inadvertently used a select statement
>>>> with a CONFIG_ prefix, remove the prefix.
>>>>
>>>> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
>>>
>>> It's a pity checkpatch can't pick this stuff up...
>>
>> You are free to write a rule and submit a patch.
>>
> 
> I'm not opposed to the idea...
> 
>> The grammar is pretty hard to verify from a patch
>> fragment though.
>>
>> There are 2 existing nominal false positives.
>>
>> $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
>> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
>> drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> 
> Ah, that's in the help text. I guess that those can be ignored simply based on the indentation.
> 
> I also see these:
> 
> drivers/i2c/busses/Kconfig:       to also select CONFIG_TYPEC_FUSB302=m.
> drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV
> 
> The 2nd looks like it's incorrect.

Yes, we just got a patch for that one today.

> 
> And then also:
> $ git grep 'depends on\b.*\bCONFIG_' -- '*/Kconfig*'
> samples/Kconfig:        depends on CONFIG_ANDROID_BINDERFS
> 
> Thanks,
> John


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
