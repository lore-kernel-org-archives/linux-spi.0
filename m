From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Mon, 6 Jun 2016 21:40:45 +0200
Message-ID: <CAOMqctRH9a0QmubdAvbyk=AC10MSa=nsNRkSURU+JOwKrN9HCA@mail.gmail.com>
References: <56D22823.7090005@gmail.com> <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com> <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com> <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk> <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
 <20160606174003.GE7510@sirena.org.uk> <a57adb90-0d80-186f-17d3-6fdf106bfb4a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a57adb90-0d80-186f-17d3-6fdf106bfb4a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 6 June 2016 at 20:53, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Am 06.06.2016 um 19:40 schrieb Mark Brown:
>> On Sat, Jun 04, 2016 at 12:22:37AM +0200, Heiner Kallweit wrote:
>>
>> Please fix your mail client to word wrap within paragraphs at
>> something substantially less than 80 columns.  Doing this makes your
>> messages much easier to read and reply to.
>>
>>> Am 06.05.2016 um 14:14 schrieb Mark Brown:
>>
>>>> Yes, it's called the maximum transfer size because it is the
>>>> maximum size of a transfer, not because it's the maximum size of
>>>> a message.
>>
>>> I'd like to come back to this discussion. You said best would be
>>> to fix the chip driver. To do this and calculate an appropriate
>>> value for max_transfer_size the chip driver would have to know that
>>> the spi_device is a spi-nor device.
>>
>> That doesn't make any sense, the controller hardware doesn't
>> magically change based on what is connected to it.
>>
> The issue with fsl-espi is that the controller deactivates CS after
> each physical transfer. And a lot of HW designs use the hardware CS,
> therefore the advise to use a GPIO instead doesn't really help.
>
> If deactivating and reactivating CS between two transfers doesn't
> affect the functionality of a spi device then we can go with the
> full max transfer size.
>
> In case of SPI NOR CS needs to stay active between command and data
> read. Therefore the two transfers in the m25p80 read SPI message need
> to be combined to one physical transfer by the controller driver.
> Result is that the max read size is effectively reduced by the length
> of the m25p80 read command.

Which is what the dummy bytes are used for AFAIK.
They are received while you are sending the command and white the
flash is getting ready to send data and after the transfer are deducted
from the received data in m25p80.

If this does not work for fsl-espi for some reason it should be corrected.
I am working with a controller that can transfer 63 bytes at once and
I am quite positive it does not do any magic transfer coalescing.
Still it can read a 4Mbyte flash chip.

However, spi-sun4 implements transfer_one and fsl-espi implements
transfer_one_message so the different interface may work out differently.

Indeed, the spi.c transfer_one_message calls set_cs and then calls
transfer_one repeatedly which is exactly what fsl-espi cannot do due to
automagic CS handling. So the fsl-espi limit is probably on message size.

Maybe adding another quirk the m25p80 driver can query to know to deduct
the command size from the maximum data size would resolve both cases.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
