From: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv3 1/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Thu, 10 Aug 2017 13:47:54 +0200
Message-ID: <7f05c45d-559f-afb3-cb6e-4cee3cccc9a8@pengutronix.de>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-2-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5Dq8mAULR+L6HJUMc6f=-d9QPZmn92+jzwKLuGYDA_AaA@mail.gmail.com>
 <20170720063449.qvi3s7faapcncoqm@pengutronix.de>
 <2892f819-f1a2-b68d-be01-e8ac7f4b4222@linux-m68k.org>
 <20170724062147.o7tccwskxfuls3ej@pengutronix.de>
 <239ae959-ce96-711b-dbfb-4e892b7eab3b@linux-m68k.org>
 <8ccba0c6-cd35-db2e-6a3f-32b79609271d@pengutronix.de>
 <b3e80e47-d1e5-41f9-a744-dc01e51d779e@mentor.com>
 <b0b60f4a-7ee9-c0e5-9eb0-ac6a29555e5c@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b0b60f4a-7ee9-c0e5-9eb0-ac6a29555e5c-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 10.08.2017 13:35, Greg Ungerer wrote:
> On 10/08/17 19:35, Vladimir Zapolskiy wrote:
>> Hi Oleksij,
>>
...
>>
>> Errors in DTB (or platform data) may confuse a driver and lead to runtime
>> misbehaviour. You describe an error in a board DTB, which is definitely
>> better to handle in the SPI driver, but I don't think it is strictly
>> mandatory to do it, because DTB errors are supposed to be fixed in DTB.
>>
>> May be one day a formal check of DTBs against Documentation/devicetree
>> descriptions will be added and such DTB errors could be captured on DTB
>> compilation stage.
>
> I completely agree with Vladmir here. Since "cs-gpios" defines the
> number of chip selects, as per the code you point out, it is the range
> limit. So if a DTB defines it wrongly then you can expect some things
> not to work right. The spi code quite rightly relies on the DTB
> definitions to be correct for proper operation.
>
>
>>> And in this case:
>>> cs-gpios = <&gpio1 0 0>, <&gpio1 1 0>, <&gpio1 2 0>, <&gpio1 3 0>, <0>;
>>>
>>> we should produce a 3 bit value b100 which will be shifted left and
>>> "or"-ed with other ctrl bits.
>
> So the register settings will be wrong and the device will not work.
> You can't really expect any other behavior from an incorrect DTB.

Ok :)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
