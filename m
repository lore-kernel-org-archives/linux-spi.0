From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Tue, 07 Jun 2016 00:28:11 +0200
Message-ID: <5755F8FB.2070409@denx.de>
References: <56D22823.7090005@gmail.com> <20160405193952.GA5243@localhost> <57041B43.2000109@gmail.com> <20160405210727.GB5243@localhost> <5706B084.2070909@gmail.com> <20160505235700.GA99474@google.com> <20160506121431.GQ6292@sirena.org.uk> <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com> <20160606174003.GE7510@sirena.org.uk> <a57adb90-0d80-186f-17d3-6fdf106bfb4a@gmail.com> <CAMuHMdW5zEmiN=Qw+Ed-gi=M1FffHXu1uSEvUOuRDG+j14ZZBA@mail.gmail.com> <971ad721-5644-e5f9-2918-65db0e6b1996@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <971ad721-5644-e5f9-2918-65db0e6b1996-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/06/2016 11:20 PM, Heiner Kallweit wrote:
> Am 06.06.2016 um 21:46 schrieb Geert Uytterhoeven:
>> Hi Heiner,
>>
>> On Mon, Jun 6, 2016 at 8:53 PM, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Am 06.06.2016 um 19:40 schrieb Mark Brown:
>>>> On Sat, Jun 04, 2016 at 12:22:37AM +0200, Heiner Kallweit wrote:
>>>>> Am 06.05.2016 um 14:14 schrieb Mark Brown:
>>>>>> Yes, it's called the maximum transfer size because it is the
>>>>>> maximum size of a transfer, not because it's the maximum size of
>>>>>> a message.
>>>>
>>>>> I'd like to come back to this discussion. You said best would be
>>>>> to fix the chip driver. To do this and calculate an appropriate
>>>>> value for max_transfer_size the chip driver would have to know that
>>>>> the spi_device is a spi-nor device.
>>>>
>>>> That doesn't make any sense, the controller hardware doesn't
>>>> magically change based on what is connected to it.
>>>>
>>> The issue with fsl-espi is that the controller deactivates CS after
>>> each physical transfer. And a lot of HW designs use the hardware CS,
>>> therefore the advise to use a GPIO instead doesn't really help.
>>
>> And you can't use pinmux to configure the pin used for hardware CS
>> to become a GPIO?
>>
> Sadly enough, no. Only the complete block of SPI signals can be switched
> to GPIO mode. But then we'd have to use bitbanging and would loose all
> features of the integrated SPI controller (FIFO's etc.)

Just for completeness, which SoC are we talking about here ?

-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
