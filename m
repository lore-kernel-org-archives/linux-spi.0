From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: core: Use cast inside 'min' macro
Date: Wed, 17 Feb 2016 18:34:23 +0100
Message-ID: <CAMuHMdX1eVTwG6vjVkhk962LFoKbtj-WQ0JeiT3Jiv8=onEpLA@mail.gmail.com>
References: <1455722424-15490-1-git-send-email-fabio.estevam@nxp.com>
	<1455722424-15490-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455722424-15490-2-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 17, 2016 at 4:20 PM, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org> wrote:
> Use cast inside 'min' macro in order to avoid the following
> build warning on ARM64:
>
> include/linux/kernel.h:754:17: warning: comparison of distinct pointer types lacks a cast
>   (void) (&_min1 == &_min2);  \
>                  ^
> drivers/spi/spi.c:2304:17: note: in expansion of macro 'min'
>   xfers[0].len = min(maxsize, xfer[0].len);
>
> Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0725ffa..4498f40 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2301,7 +2301,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
>         /* the first transfer just needs the length modified, so we
>          * run it outside the loop
>          */
> -       xfers[0].len = min(maxsize, xfer[0].len);
> +       xfers[0].len = min(maxsize, (size_t)xfer[0].len);

Please use "min_t(size_t, ..., ...)" instead of explicit casting.

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
