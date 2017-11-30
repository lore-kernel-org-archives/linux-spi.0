From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev: Instantiating from DT as "spidev"
Date: Thu, 30 Nov 2017 09:03:12 +0100
Message-ID: <CAMuHMdXv2WsGCUBD4Td9K1zOfZ9DOfeW5rYtCyq27Ucp21xGRA@mail.gmail.com>
References: <20171129150435.5npybjuu2ndmtx2v@senary> <CAMuHMdUps9Ti=CRZM7UxrHLD8GA+FKD+_RFLW3H9wUpSRTYs8w@mail.gmail.com>
 <20171129192407.vrkphuhttmzl2ii4@senary> <CAMuHMdX62=vC6=P-v=SPe_hq0F12tOZCgePaS7=MZZg_4PkvUw@mail.gmail.com>
 <1512007657.9792.45.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "kyle.roeschley-acOepvfBmUk@public.gmane.org" <kyle.roeschley-acOepvfBmUk@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512007657.9792.45.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Trent,

On Thu, Nov 30, 2017 at 3:07 AM, Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org> wrote:
> On Wed, 2017-11-29 at 23:18 +0100, Geert Uytterhoeven wrote:
>> To me, the above sounds a bit contradictive: either you have
>>   1. a simple (trivial) description, which can be handled by spidev and
>>      userspace, and thus by just writing "<unit-addr> spidev" to a new_device
>>      sysfs node, or
>>   2. a complex description, for which you need a specialized in-kernel driver,
>>      so you're gonna need a real DT node (and overlays?) to describe it.
>>
>> I don't think writing a complex description to a new_device sysfs node makes
>> sense.
>
> Is there anything one can do with new_device that can't be done with a
> dt fragment?

Nope.

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
