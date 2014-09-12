From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: SPI and module auto-loading
Date: Fri, 12 Sep 2014 11:50:23 +0200
Message-ID: <5412C1DF.3040707@collabora.co.uk>
References: <54119DB6.8020807@collabora.co.uk> <20140911193325.GT4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140911193325.GT4015-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/11/2014 09:33 PM, Mark Brown wrote:
> On Thu, Sep 11, 2014 at 03:03:50PM +0200, Javier Martinez Canillas wrote:
> 
>> This can be easily worked around (and probably why it never was an issue) if
>> the OF and SPI tables are kept in sync but I don't know if that is a hard
>> requirement for all use-cases (e.g: a SPI driver that is DT only?).
> 
> I'm not sure I see that as an interesting use case, it seems better to
> have drivers usable without DT and it's trivial to do so.
>

Yes, it's trivial but seems like an unnecessary duplication for me. AFAICT the
OF tables are only used to match the devices in spi_match_device() but if both
the OF and SPI tables must be kept in sync to properly report the module
aliases to user-space then I wonder if the OF tables shouldn't just be removed
from the SPI drivers since spi_match_device() will succeed anyways when
calling spi_match_id().

>> I'm sending an RFC patch [1] to know what you think about it.
>> [1]
>> From a7cd35209a597a578df6c801e5ff7b63b584bf3e Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>> Date: Thu, 11 Sep 2014 14:31:04 +0200
>> Subject: [PATCH RFC] spi: core: report OF style modalias when probing using DT
> 
> We already have a perfectly good way of sending patches.
> 

Of course I know how to post patches properly but proposing a patch was not my
intention here since as I said this could break module auto-loading for many
drivers that rely on the current behavior. What I wanted was to explain with
code how the SPI core could report uevents in order to be consistent with what
other subsystems do (e.g: platform drivers):

http://lxr.free-electrons.com/source/drivers/base/platform.c#L717

I should probably had used sharing instead of sending but as a non-native
english speaker sometimes I don't always choose the best wording.

Anyway, I was just raising the issue because if a driver only defines an OF
table and not a SPI table, the driver will be probed correctly but module
auto-loading will not work. So even when it looks like having a SPI id table
is not a requirement for OF, it really is and I think that is not documented.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
