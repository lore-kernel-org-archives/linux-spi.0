From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 4 Jun 2015 06:31:45 +0200
Message-ID: <CAOMqctQeg0Sj1pGOQsK1nNB6=-H9koH_5nrXYBq_NKeVt369dw@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <201506040103.09555.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoore@altera.c
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201506040103.09555.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 4 June 2015 at 01:03, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> On Wednesday, June 03, 2015 at 11:26:41 PM, Michal Suchanek wrote:
>> On sunxi the SPI controller currently does not have DMA support and fails
>> any transfer larger than 63 bytes.
>>
>> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
>> when using slower speed like 40MHz and any transfer larger than 128bytes
>> when running at 133MHz.
>
> This smells more like some corruption of the data on the bus or something
> even more obscure.

If the data was corrupted you would get corrupted data and not
transfer failure. AFAIK there is no checksum or anything. I actually
do get corrupted data when I use wrong feedback delay setting.

>
>> The best thing is that in both cases the controller can just lock up and
>> never finish potentially leaving the hardware in unusable state.
>>
>> So it is required that the m25p80 driver actively prevents doing
>> transfers that are too large for the current driver state on a
>> particular piece of hardware.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> --
>>
>> Update commit message and documentation text.
>> ---
>>  .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++++++
>>  drivers/mtd/devices/m25p80.c                       | 24
>> ++++++++++++++++++++-- 2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
>> 2bee681..4e63ae8 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> @@ -19,6 +19,12 @@ Optional properties:
>>                     all chips and support for it can not be detected at
>> runtime. Refer to your chips' datasheet to check if this is supported by
>> your chip.
>> +- linux,max_tx_len : With some SPI controller drivers possible transfer
>> size is +                     limited. This may be hardware or driver bug.
>> +                     Transfer data in chunks no larger than this value. +
>>                     Using this option may severely degrade performance and
>> +                     possibly flash memory life when max_tx_len is
>> smaller than +                     flash page size (typically 256 bytes)
>
> Will we need similar patch for all other SPI slave drivers, like SPI NAND ?

Probably. Some SPI slave drivers already do have similar option. In
general it cannot be expected that you can reliably transfer
arbitrarily large data over SPI it seems. However, if the nand driver
transfers data a page at a time it should be fine.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
