From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spidev instantiated from DT
Date: Tue, 13 Dec 2016 09:27:32 +0100
Message-ID: <CAMuHMdXgXBfBmp48i=ApzXrK5VmmL3_D2wr1GcHTCrJYPzp+Og@mail.gmail.com>
References: <006d01d254b0$3d010520$b7030f60$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Giuseppe Lippolis <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <006d01d254b0$3d010520$b7030f60$@gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Guiseppe,

On Mon, Dec 12, 2016 at 8:45 PM, Giuseppe Lippolis
<giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> So the rationale is to keep fixed the HW description (that make sense).
> If a "generic" driver is required, the specific device compatible statement
> shall be added in spidev like:
>         { .compatible = "lineartechnology,ltc2488" },
>
> And if later a more specific driver will be available, the previous line
> shall be removed.
>
> Can you please confirm my understanding?

That's correct.

Of course we prefer having a specific driver ;-)

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
