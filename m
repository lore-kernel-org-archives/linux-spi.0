From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: Make spi_bitbang_stop() return void
Date: Mon, 31 Mar 2014 11:59:31 +0200
Message-ID: <CAMuHMdUw3X1=q8J_YE9yNzOWDc5i2O32z+4Dh=KQdz_Vk4es1Q@mail.gmail.com>
References: <1396090212.3823.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396090212.3823.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Axel,

On Sat, Mar 29, 2014 at 11:50 AM, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
> spi_bitbang_stop() never fails, so make it return void.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
> v2: also update the code for drivers/spi/spi-butterfly.c.
> Note, spi-sh-msiof.c does use bitbang now.

I guess you meant "does not"?

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
