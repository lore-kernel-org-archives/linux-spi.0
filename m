From: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Wed, 22 Mar 2017 10:50:44 +1000
Message-ID: <51a48190-9edb-093e-a6fc-a7cb8c1e0ce0@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
 <4a8449d9-cc38-d642-0853-246f46ee7059@linux-m68k.org>
 <20170321080551.ie4xm5hr3fki365s@pengutronix.de>
 <942cfc4b-445b-ca51-1823-2391cea62abf@linux-m68k.org>
 <20170321121133.jcmhhbszj2d42h3w@pengutronix.de>
 <20678cef-f667-9915-aa00-8877ad152a8c@linux-m68k.org>
 <20170321192342.4fxlb2zjcas53uow@pengutronix.de>
 <CAMuHMdW+KcPCAweneu4pTg1Pb-uAvYGz1+Z=oEDYoOt4gWrjhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW+KcPCAweneu4pTg1Pb-uAvYGz1+Z=oEDYoOt4gWrjhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert, Uwe,

On 22/03/17 06:15, Geert Uytterhoeven wrote:
> On Tue, Mar 21, 2017 at 8:23 PM, Uwe Kleine-König
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> On Tue, Mar 21, 2017 at 11:22:27PM +1000, Greg Ungerer wrote:
>>> On 21/03/17 22:11, Uwe Kleine-König wrote:
>>>> On Tue, Mar 21, 2017 at 09:53:52PM +1000, Greg Ungerer wrote:
>>>>> On 21/03/17 18:05, Uwe Kleine-König wrote:
>>>>>> On Tue, Mar 21, 2017 at 12:05:20PM +1000, Greg Ungerer wrote:
>>>>>>> On 20/03/17 23:22, Vladimir Zapolskiy wrote:
>>>>>>>> For that type of bindings locally I have a hackish spi-imx driver change,
>>>>>>>> which supports this option, but I'm unsure if it is universal enough.
>>>>>>>
>>>>>>> Do you mean supporting no cs-gpios tag?
>>>>>>> That would be nice, but it would seem not many users of this are
>>>>>>> using native chip selects.
>>>>>>
>>>>>> The reason for this is that the native chip selects are less flexible
>>>>>> than gpios because you cannot control when they deassert. IIRC they do
>>>>>> it too much for some chips. So the only reason to stick to them is that
>>>>>> on some SoCs not all pins have a GPIO function. Not sure if transfer
>>>>>> speed is another reason, but I would expect that the gain isn't that
>>>>>> big.
>>>>>
>>>>> For the particular SPI device I am using, a Silicon Labs 32260,
>>>>> it actually wants the assertion and de-assertion of the chip-select
>>>>> between each byte. So it is the only way it can work for me.
>>>>
>>>> That should be doable with gpio-cs, too. You just need the right flags
>>>> in your spi transfer IIRC.
>>>
>>> Do you know which flag(s)  do that?
>>
>> Looking at the source it's not about flags, but you have to split your
>> transfer into several messages.
> 
> ... and set spi_transfer.cs_change.

Yep, that looks like the one. Though it would appear not all
spi drivers support it. The spi-imx driver for one doesn't look
at it at all.


>> AFAICT that's how the spi stuff is
>> supposed to work. That is, at the start of a message CS is asserted and
>> (only) at it's end CS is deasserted. So the imx core with native chip
>> select actually misbehaves by toggling CS between each word.
> 
> Indeed.

If you look around the kernel source for cs_change there is
a number of devices that use it. A bunch od ADC/DACs in
particular (including in backlight support). 

So I don't know that I would characterize the iMX one as
misbehaving so much as only natively supporting the model
where chip select is asserted/deasserted per burst. It is
strait forward to implement the GPIO method instead of the
native chip select with the iMX pin multiplexing.

Regards
Greg


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
