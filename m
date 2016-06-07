From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Tue, 7 Jun 2016 22:42:57 +0200
Message-ID: <9a3a147d-423a-695b-9c79-ccca2c02973b@gmail.com>
References: <56D22823.7090005@gmail.com> <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com> <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com> <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk>
 <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
 <20160606174003.GE7510@sirena.org.uk>
 <a57adb90-0d80-186f-17d3-6fdf106bfb4a@gmail.com>
 <20160606230752.GM7510@sirena.org.uk>
 <fe0042f9-66c9-51fd-ca91-641c5cc25c40@gmail.com>
 <CAOMqctRmtCXurb8A05m2kw+9EjU+AWB8Uj0z1FPO792kGG=36Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctRmtCXurb8A05m2kw+9EjU+AWB8Uj0z1FPO792kGG=36Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 07.06.2016 um 10:10 schrieb Michal Suchanek:
> On 7 June 2016 at 08:03, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Am 07.06.2016 um 01:07 schrieb Mark Brown:
>>> On Mon, Jun 06, 2016 at 08:53:10PM +0200, Heiner Kallweit wrote:
>>>> Am 06.06.2016 um 19:40 schrieb Mark Brown:
> 
>>>> Well, we could reduce the max_transfer_size exposed by the driver by
>>>> the max length of a m25p80 read command in general.
>>>
>>> No!  Apart from anything else this would be a complete and total
>>> abstraction failure.  This is a driver for a SPI controller, not a
>>> driver for a flash controller, which means that it should not have flash
>>> specific hacks in it.
>>>
>>>> Then we might be too strict for other SPI devices, but this may
>>>> be acceptable as the current fsl-espi driver is usable with SPI NOR
>>>> devices only anyway.
>>>
>>> What makes you say this?  I'm guessing that the driver is just broken
>>> but it would be good to understand the specifics.
>>>
>> See fsl_espi_rw_trans():
>> In case of transfers > SPCOM_TRANLEN_MAX it loops and reads in
>> SPCOM_TRANLEN_MAX chunks whilst replacing bytes 2-4 of the
>> message buffer with the new start address to read from.
> 
> That's obviously bogus. Just reject anything too large and let the
> upper layer deal with it.
> 
So far the upper layer wasn't able to deal with it. Now, with the recent
change set initiated by you, we can clean up the driver a little.
This was also the motivation to involve myself in getting this upper
layer functionality into the mtd code.

> Given m25p80 and fbtft would handle this can you use DMA to gather
> buffers from multiple transfers (ie command and data) or does the
> buffer have to be copied together for the transfer?
> 
The fsl-espi controller doesn't support DMA.
The driver copies all transfers to a local buffer.

There's just one nice feature of this controller: It supports a
flash-read-optimized transfer mode, where you can configure:
- first write x bytes
- then read y bytes in either single or dual mode
In tests with a modified driver the dual mode worked quite well.
But that's something for a future extension.

> Thanks
> 
> Michal
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
