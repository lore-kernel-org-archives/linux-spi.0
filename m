From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-ath79: use gpio_set_value_cansleep for GPIO
 chip select
Date: Sun, 11 Dec 2016 10:29:52 +0100
Message-ID: <CAMuHMdUfk2i4kstw9iV=Y4a98ooqQ-wM9YWTPRhxUD0gX4U-cQ@mail.gmail.com>
References: <20161209194853.71018-1-nbd@nbd.name> <20161209194853.71018-2-nbd@nbd.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209194853.71018-2-nbd-Vt+b4OUoWG0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Felix,

On Fri, Dec 9, 2016 at 8:48 PM, Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org> wrote:
> Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>

Please explain why this is needed, instead of just translating C to English.
A good patch description explains what, why, and how.

Thanks!

> ---
>  drivers/spi/spi-ath79.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index d51c99a..2517e1e 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -80,7 +80,7 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
>
>         if (gpio_is_valid(spi->cs_gpio)) {
>                 /* SPI is normally active-low */
> -               gpio_set_value(spi->cs_gpio, cs_high);
> +               gpio_set_value_cansleep(spi->cs_gpio, cs_high);

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
