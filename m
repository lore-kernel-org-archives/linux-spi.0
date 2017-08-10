From: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCHv3 1/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Thu, 10 Aug 2017 23:21:14 +1000
Message-ID: <ac92f8ad-3ba6-a577-dc9c-9e8b6689afd4@linux-m68k.org>
References: <CAOMZO5Dq8mAULR+L6HJUMc6f=-d9QPZmn92+jzwKLuGYDA_AaA@mail.gmail.com>
 <20170720063449.qvi3s7faapcncoqm@pengutronix.de>
 <2892f819-f1a2-b68d-be01-e8ac7f4b4222@linux-m68k.org>
 <20170724062147.o7tccwskxfuls3ej@pengutronix.de>
 <239ae959-ce96-711b-dbfb-4e892b7eab3b@linux-m68k.org>
 <8ccba0c6-cd35-db2e-6a3f-32b79609271d@pengutronix.de>
 <b3e80e47-d1e5-41f9-a744-dc01e51d779e@mentor.com>
 <b0b60f4a-7ee9-c0e5-9eb0-ac6a29555e5c@linux-m68k.org>
 <20170810114938.bsuztdxmngys2ekg@pengutronix.de>
 <6dea9014-6e45-199b-16de-418728757662@linux-m68k.org>
 <20170810124049.msmi2pfqmpoafsml@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170810124049.msmi2pfqmpoafsml-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Uwe,

On 10/08/17 22:40, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Thu, Aug 10, 2017 at 10:24:09PM +1000, Greg Ungerer wrote:
>> On 10/08/17 21:49, Uwe Kleine-König wrote:
>>> On Thu, Aug 10, 2017 at 09:35:15PM +1000, Greg Ungerer wrote:
>>>> On 10/08/17 19:35, Vladimir Zapolskiy wrote:
>>>>> Errors in DTB (or platform data) may confuse a driver and lead to runtime
>>>>> misbehaviour. You describe an error in a board DTB, which is definitely
>>>>> better to handle in the SPI driver, but I don't think it is strictly
>>>>> mandatory to do it, because DTB errors are supposed to be fixed in DTB.
>>>>>
>>>>> May be one day a formal check of DTBs against Documentation/devicetree
>>>>> descriptions will be added and such DTB errors could be captured on DTB
>>>>> compilation stage.
>>>>
>>>> I completely agree with Vladmir here. Since "cs-gpios" defines the
>>>> number of chip selects, as per the code you point out, it is the range
>>>> limit. So if a DTB defines it wrongly then you can expect some things
>>>> not to work right. The spi code quite rightly relies on the DTB
>>>> definitions to be correct for proper operation.
>>>>
>>>>
>>>>>> And in this case:
>>>>>> cs-gpios = <&gpio1 0 0>, <&gpio1 1 0>, <&gpio1 2 0>, <&gpio1 3 0>, <0>;
>>>>>>
>>>>>> we should produce a 3 bit value b100 which will be shifted left and
>>>>>> "or"-ed with other ctrl bits.
>>>>
>>>> So the register settings will be wrong and the device will not work.
>>>> You can't really expect any other behavior from an incorrect DTB.
>>>
>>> I think nobody expects that a wrong dtb is good enough to make
>>> everything work. Maybe you can argue what should happen in a driver if
>>> it gets a wrong dtb. It can make the kernel oops, just silently not work
>>> or issue an error message; probably there are more options.
>>>
>>> The current state is that a broken dtb makes the spi-imx driver write to
>>> a unrelated register bit when asked to set a chip select signal. Oleksij
>>> tries to improve that and make the driver error out instead. It makes it
>>> easier for users to report problems or find the culprit themselves. I
>>> like that.
>>
>> But the check if the chip select is valid is based on information
>> that comes from the DTB. In the example of the wrong cs-gpios list
>> the DTB is saying it has more chip selects that the actual hardware
>> device does. How can you possibly protect against that?
>>
>> The current code seems to do its best to range check the chip select,
>> based on what the DTB says this hardware has.
> 
> If I understood correctly the current state is the following:
> 
> The spi-imx driver supports GPIOs as CS and a "native" mode where the
> hardware drives the CS line. If you write:
> 
> 	cs-gpios = <&gpio2 0 0>, <0>, <&gpio1 17 0>
> 
> That means: Use gpio2.0 as CS 0, native CS as CS 1 and gpio1.17 as CS 2.

That is correct, yes. But the current driver is buggy and does not
handle the "native" mode correctly - the intention of the patch
at the start of this thread is to fix this.


> So what the driver can check here: Does the dtb request a native CS at a
> position that is not supported by the hardware. Of course even if there

How does the driver know how many chip-selects are natively supported
by the hardware?

I am not familar with all iMX parts and their spi controllers, but
Oleksij suggested in an earlier email that some have 3 native chip
selects, some have 4, other variants may have some other number.

Regards
Greg


> are only 4 hardware CS the driver can still be used with 7 spi devices
> given that CS 4 .. 6 are using a GPIO as CS.
> 
> Oleksij: please correct me if I'm wrong.
> 
> Best regards
> Uwe
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
