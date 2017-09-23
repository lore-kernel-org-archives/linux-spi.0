From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Fri, 22 Sep 2017 18:46:46 -0700
Message-ID: <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170922092621.uq2xsvxangeetewi-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/22/17 02:26, Mark Brown wrote:
> On Thu, Sep 21, 2017 at 11:02:31AM -0700, Randy Dunlap wrote:
> 
>> spi-sprd-adi.c:(.text+0x3ee): undefined reference to `__hwspin_unlock'
>>
>> v2: allow build with or without HWSPINLOCK, but restrict to =m
>> if HWSPINLOCK=m.
>>
>> Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> 
> Please put inter version changelogs after the --- as covered in
> SubmittingPatches.  This still seems like the stubs aren't doing the

Yep.

> right thing - if we can use hwspinlocks in a module when they're enabled
> I'd expect to be able to build the stubs that way too.

Sorry, I'm not understanding what you are trying to say on that one.

The hwspinlock stubs are present if HWSPINLOCK is not enabled (when
<linux/hwspinlock.h> is #included).

The following kconfig combinations build:

HWSPINLOCK	SPI_SPRD_ADI
	n		y
	n		m
	y		y
	y		m
	m		m
but this combo is not allowed (with the patch) or causes build errors
(without the patch):
	m		y

-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
