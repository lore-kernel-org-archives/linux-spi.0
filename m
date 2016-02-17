From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: core: Use %zu for printing 'size_t' type
Date: Wed, 17 Feb 2016 18:35:48 +0100
Message-ID: <CAMuHMdWmpXTbpku1cBWpPRw1OefTHHP43dihhzpZZz=npNY=XA@mail.gmail.com>
References: <1455722424-15490-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455722424-15490-1-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 17, 2016 at 4:20 PM, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org> wrote:
> Use %zu for printing 'size_t' type in order to fix the following
> build warning on ARM64:
>
> drivers/spi/spi.c: In function '__spi_split_transfer_maxsize':
> drivers/spi/spi.c:2278:2: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat=]
>
> Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

However, I'm still wondering whether using size_t for this variable is
the right thing to
do. Maximum SPI transfer length is unsigned int.

> ---
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f6c76be..0725ffa 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2276,7 +2276,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
>
>         /* warn once about this fact that we are splitting a transfer */
>         dev_warn_once(&msg->spi->dev,
> -                     "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",
> +                     "spi_transfer of length %i exceed max length of %zu - needed to split transfers\n",
>                       xfer->len, maxsize);

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
