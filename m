From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6] spi: orion.c: Add direct access mode
Date: Mon, 2 May 2016 12:33:21 +0200
Message-ID: <57272CF1.9060706@denx.de>
References: <1461147068-4829-1-git-send-email-sr@denx.de>
 <5726F7F3.9070700@denx.de> <8919835.yGyvx4h0Tr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8919835.yGyvx4h0Tr@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Arnd,

On 02.05.2016 09:28, Arnd Bergmann wrote:
> On Monday 02 May 2016 08:47:15 Stefan Roese wrote:
>> On 20.04.2016 12:11, Stefan Roese wrote:
>>> This patch adds support for the direct write mode to the Orion SPI
>>> driver which is used on the Marvell Armada based SoCs. In this direct
>>> mode, all data written to (or read from) a specifically mapped MBus
>>> window (linked to one SPI chip-select on one of the SPI controllers)
>>> will be transferred directly to the SPI bus. Without the need to control
>>> the SPI registers in between. This can improve the SPI transfer rate in
>>> such cases.
>>>
>>> Currently only the direct write mode is supported. This mode especially
>>> benefits from the SPI direct mode, as the data bytes are written
>>> head-to-head to the SPI bus, without any additional addresses, that
>>> are also written in the direct read mode.
>>>
>>> One use-case for this direct write mode is, programming a FPGA bitstream
>>> image into the FPGA connected to the SPI bus at maximum speed.
>>>
>>> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
>>> Marvell Armada XP Functional Spec Datasheet.
>>>
>>> It should be possible to support SPI-NOR and SPI-NAND devices via
>>> this direct access mode as well. But this needs further work, e.g.:
>>> - The mapping of the MBus window needs to get extended to span
>>>     the complete flash device size
>>> - The address / control data needs to get inserted into the SPI
>>>     controller registers
>>>
>>> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
>>> Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> Its been a while since v6 of this direct write access mode has been
>> posted. This is a gentle ping on its status.
>>
>> Arnd / Mark, do you have any additional change requests or are you okay
>> with the current version?
> 
> No objections, please add
> 
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Thanks.
 
> Two questions though:
> 
> - you now always send a multiple of four byte in each transfer, are
>    there any downsides in doing this, e.g. some SPI devices that might
>    get confused by receiving additional uninitialized data?

Yes, this is something that might happen on such devices. AFAIK, my
device (Altera FPGA) has no such restriction though. IIRC, the
size of the bitfiles is always 4-byte aligned.

I'll try to send v7 of this patch with a fully byte-size correct 
handling later today.
 
> - How does the performance compare to the normal mode, is it basically
>    unchanged, or does this patch make things faster?

The performance is increased. The factor of course depends on the SPI
transfer speed. Here the numbers for a ~70KiB image transferred at
27MHz SPI speed:

Using the PIO SPI transfer:

real    0m0.128s
user    0m0.010s
sys     0m0.120s

Using the direct write mode:

real    0m0.040s
user    0m0.000s
sys     0m0.020s

Thanks,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
