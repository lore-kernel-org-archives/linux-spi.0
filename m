From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev instantiated from DT
Date: Mon, 12 Dec 2016 10:14:18 +0100
Message-ID: <CAMuHMdWb_UzYqSQpr-30TDJgjH+-TsD1uXqPfhnY4Qj-MuiF7g@mail.gmail.com>
References: <002b01d253a6$9026e3b0$b074ab10$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Giuseppe Lippolis <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002b01d253a6$9026e3b0$b074ab10$@gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Giuseppe,

On Sun, Dec 11, 2016 at 1:03 PM, Giuseppe Lippolis
<giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> in the spidev.c driver there is a check preventing to export the SPI
> subsystem to the userspace.
> The commit message state:
>
>         spi: spidev: Warn loudly if instantiated from DT as "spidev"
>
>     Since spidev is a detail of how Linux controls a device rather than a
>     description of the hardware in the system we should never have a node
>     described as "spidev" in DT, any SPI device could be a spidev so this
>     is just not a useful description.
>
>     In order to help prevent users from writing such device trees generate a
>     warning if spidev is instantiated as a DT node without an ID in the
> match
>     table.
>
>     Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Currently in the spidec.c are registered two devices to use "legally" this
> driver:
>     { .compatible = "rohm,dh2228fv" },
>     { .compatible = "lineartechnology,ltc2488" },
>
> I cannot fully understand the rationale.
> I have a board mounting an spi device. Currently no dedicated driver for
> this devices exists.

But you can still describe the SPI device in DT, right?
Then you can add its compatible value to spidev.c now, until a dedicated
driver becomes available.

> So in my opinion, now, make sense to describe a device-tree with a "generic"
> driver, allowing the userspace to control the device. When at the end a
> dedicated driver will be available an update of the device tree will be
> possible.

Hmm... So you would change DT, which describes the hardware, while the actual
hardware hasn't changed?

Does that help to understand the rationale?

> In alternative, make sense to add a dedicated .compatible = "xxx,yyy"
> statements to attach the spidev driver to the specific device and allowing
> the DT description as soon as a dedicated driver will be not available?

Please add the dedicated compatible statement to spidev.c.

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
