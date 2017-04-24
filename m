From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH RFC 0/5] *** SPI Slave mode support ***
Date: Mon, 24 Apr 2017 12:55:21 +0200
Message-ID: <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk> <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58F06092.9080409-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jiada,

On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:
> On 04/13/2017 12:47 PM, Geert Uytterhoeven wrote:
>> On Thu, Apr 13, 2017 at 2:59 PM, Mark Brown<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>  wrote:
>>> On Thu, Apr 13, 2017 at 05:13:59AM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
>>>> From: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>>>
>>>> v1:
>>>>    add Slave mode support in SPI core
>>>>    spidev create slave device when SPI controller work in slave mode
>>>>    spi-imx support to work in slave mode
>>>
>>> Adding Geert who also had a series doing this in progress that was
>>> getting very near to being merged.
>>
>> Thank you!
>>
>> Actually my plan is to fix the last remaining issues and resubmit for
>> v4.13.
>
> I noticed your patch set for SPI slave support,
> (I am sure you can find out some of the change
> in this patch set is based on your work).
> we have similar requirement to add slave mode support to ecspi IP on imx6
> Soc.
>
> Our use case is to use spidev as an interface to communicate with external
> SPI master devices.
> meanwhile the SPI bus controller can also act as master device to send data
> to other
> SPI slave devices on the board.

That sounds a bit hackish to me. SPI was never meant to be a multi-master bus.
While it can be done, you will need external synchronization (signals) to
avoid conflicts between the SPI masters.

> I found in your implementation, SPI bus controller is limited to either work
> in master mode or
> slave mode, is there any reasoning to not configure SPI mode based on SPI
> devices use case?

If you really need both master and slave support, you can use 2 subnodes
in DT, the first representing the master, the second the slave.

Mark, what's your opinion about this?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
