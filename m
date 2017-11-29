From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev: Instantiating from DT as "spidev"
Date: Wed, 29 Nov 2017 23:18:26 +0100
Message-ID: <CAMuHMdX62=vC6=P-v=SPe_hq0F12tOZCgePaS7=MZZg_4PkvUw@mail.gmail.com>
References: <20171129150435.5npybjuu2ndmtx2v@senary> <CAMuHMdUps9Ti=CRZM7UxrHLD8GA+FKD+_RFLW3H9wUpSRTYs8w@mail.gmail.com>
 <20171129192407.vrkphuhttmzl2ii4@senary>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129192407.vrkphuhttmzl2ii4@senary>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kyle,

On Wed, Nov 29, 2017 at 8:24 PM, Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org> wrote:
> On Wed, Nov 29, 2017 at 05:32:55PM +0100, Geert Uytterhoeven wrote:
>> Implement something in sysfs like "new_device" for i2c, or "slave" for SPI.
>> Then people can add a new device (e.g. "spidev") by writing to that
>> virtual file.
>
> That makes sense to me. However, the i2c "new_device" and SPI "slave" nodes are
> simpler in that they only require the device name (and address for i2c). A SPI
> device can have many properties specified in the device tree that we would
> somehow need to get and parse. Two options I see would be:
>
> 1. Set device status to disabled in the DT and add the device when the name is
>    written to the new_device sysfs node. But then, this is basically the same
>    as just specifying "spidev" in the DT (minus the printks). I suppose we
>    could also drop the compatible entry and require the user to specify a
>    driver when writing to new_device.
> 2. Pass all parameters into the "new_device" node, e.g. by passing in and
>    applying a DT overlay or snippet.
>
> In my specific case [1], the device tree entires are simple, but I wouldn't
> expect that for everyone. I've hacked up the first option and it works, but it
> doesn't seem terribly useful. I noticed that you've been working with DT
> overlays recently; what do you think of the second option?
>
> [1] https://github.com/ni/linux/blob/nilrt/17.0/4.6/arch/arm/boot/dts/ni-76F2.dts#L108

To me, the above sounds a bit contradictive: either you have
  1. a simple (trivial) description, which can be handled by spidev and
     userspace, and thus by just writing "<unit-addr> spidev" to a new_device
     sysfs node, or
  2. a complex description, for which you need a specialized in-kernel driver,
     so you're gonna need a real DT node (and overlays?) to describe it.

I don't think writing a complex description to a new_device sysfs node makes
sense.

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
