From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi_finalize_current_transfer()?
Date: Mon, 13 Jan 2014 14:41:08 +0100
Message-ID: <CAMuHMdVvrYnA-NafNy4ARx-cRVDmYw7276fHG3Rzy0rE2s-gpg@mail.gmail.com>
References: <CAMuHMdVu503YveDyMqJS7Z5fMMzQq5tAgu-72fJGLmvD4acj1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVu503YveDyMqJS7Z5fMMzQq5tAgu-72fJGLmvD4acj1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 13, 2014 at 1:25 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> include/linux/spi/spi.h says:
>
>  * @transfer_one: transfer a single spi_transfer. When the
>  *                driver is finished with this transfer it must call
>  *                spi_finalize_current_transfer() so the subsystem can issue
>  *                the next transfer
>
> However, none of the current drivers implementing transfer_on() calls
> spi_finalize_current_transfer() (which just does
> "complete(&master->xfer_completion)").
> They also don't kick master->xfer_completion theirselves, they all have
> their own private xfer_completion.
>
> What am I missing?

Found it: spi_transfer_one_message() only waits for master->xfer_completion
if master->transfer_one() returned a strict-positive value. Which none of the
current drivers do.

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
