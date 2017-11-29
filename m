From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev: Instantiating from DT as "spidev"
Date: Wed, 29 Nov 2017 17:32:55 +0100
Message-ID: <CAMuHMdUps9Ti=CRZM7UxrHLD8GA+FKD+_RFLW3H9wUpSRTYs8w@mail.gmail.com>
References: <20171129150435.5npybjuu2ndmtx2v@senary>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129150435.5npybjuu2ndmtx2v@senary>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kyle,

On Wed, Nov 29, 2017 at 4:04 PM, Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org> wrote:
> Since commit 956b200a846e ("spi: spidev: Warn loudly if instantiated from DT as
> "spidev""), listing "spidev" directly in a device tree is not recommended.
> Instead, what I see in the (many) past discussions is that I should change my
> device tree to describe the actual hardware and add whatever new ID I create to
> spidev_dt_ids. That seems perfectly reasonable.
>
> However, our SPI master [1] is similar to the Raspberry Pi or Beaglebone in
> that we don't know at kernel build time what device may be attached to the SPI
> bus. Because the end users of our device are usually young students, we also
> can't expect them to rebuild their kernel or mess with device tree overlays
> just to interface with some arbitrary SPI device.
>
> Is there a "correct" solution to this problem? Both the Raspberry Pi [2] and
> Beaglebone [3] kernels have just added "spidev" back to the match table, but I
> would rather not carry a patch around just for some printk spam.

Implement something in sysfs like "new_device" for i2c, or "slave" for SPI.
Then people can add a new device (e.g. "spidev") by writing to that
virtual file.

Documentation/i2c/instantiating-devices
Documentation/spi/spi-summary

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
