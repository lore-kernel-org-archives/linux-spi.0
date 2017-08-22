From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Suggestion Needed on Demuxer to Select Slave Devices
Date: Tue, 22 Aug 2017 13:56:18 +0200
Message-ID: <CAMuHMdWNTy=ofTvRkMioC+1f9m1JLDXj+JNEP2E9m06=cRybww@mail.gmail.com>
References: <CA+V-a8tXatbmx4F0uHOjE6dMyb2n0gBVLpn3hjW-reT6gFykOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+V-a8tXatbmx4F0uHOjE6dMyb2n0gBVLpn3hjW-reT6gFykOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Lad,

On Tue, Aug 22, 2017 at 1:06 PM, Lad, Prabhakar
<prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I am writing a Linux SPI slave driver, on the latest kernel, and
> wanted a suggestion on how the driver could fit in the latest kernel
> with DT.
>
> I have SPI controller which is connected to decoder [1], the SPI
> controller has 2 chip selects, but only one (cs0) is connected to the
> decoder.

... to e.g. G2A of the decoder?

> The decoder has 8 slave devices connected to it, which can be can be
> selected by gpios from the muxer.

So the A/B/C inputs of the decoder are connected to GPIOs?

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
