From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 3/3] spi/fsl-espi: Add the 4Byte address width device support
Date: Mon, 11 May 2015 09:45:28 +0200
Message-ID: <CAMuHMdW6HAMv=5jLM8VJQ+9WasqWi=YB4SkeO7spV4JROPfWFw@mail.gmail.com>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
	<1431269253-22890-3-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431269253-22890-3-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, May 10, 2015 at 4:47 PM, Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Get the address width information from the spi_message to correct the
> address to operate.
>
> when the one-time transfer length exceed the max limited length of eSPI
> controller 0xFFFF, for the subsequent transfer, the address to operate
> need to be corrected.
>
> Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-espi.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> index d0a73a0..59931d3 100644
> --- a/drivers/spi/spi-fsl-espi.c
> +++ b/drivers/spi/spi-fsl-espi.c
> @@ -250,19 +250,31 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
>         return mpc8xxx_spi->count;
>  }
>
> -static inline void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
> +static inline void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd, u8 addr_width)
>  {
>         if (cmd) {
> -               cmd[1] = (u8)(addr >> 16);
> -               cmd[2] = (u8)(addr >> 8);
> -               cmd[3] = (u8)(addr >> 0);
> +               if (addr_width == 3) {

As your SPI master driver is already nor-jedec-specific, can't you derive
this from cmd[0]?

> +                       cmd[1] = (u8)(addr >> 16);
> +                       cmd[2] = (u8)(addr >> 8);
> +                       cmd[3] = (u8)(addr >> 0);
> +               } else if (addr_width == 4) {
> +                       cmd[1] = (u8)(addr >> 24);
> +                       cmd[2] = (u8)(addr >> 16);
> +                       cmd[3] = (u8)(addr >> 8);
> +                       cmd[4] = (u8)(addr >> 0);
> +               }
>         }
>  }
>
> -static inline unsigned int fsl_espi_cmd2addr(u8 *cmd)
> +static inline unsigned int fsl_espi_cmd2addr(u8 *cmd, u8 addr_width)
>  {
> -       if (cmd)
> -               return cmd[1] << 16 | cmd[2] << 8 | cmd[3] << 0;
> +       if (cmd) {
> +               if (addr_width == 3)
> +                       return cmd[1] << 16 | cmd[2] << 8 | cmd[3] << 0;
> +               else if (addr_width == 4)
> +                       return cmd[1] << 24 | cmd[2] << 16
> +                               | cmd[3] << 8 | cmd[4] << 0;
> +       }
>
>         return 0;
>  }
> @@ -367,7 +379,9 @@ static void fsl_espi_rw_trans(struct spi_message *m,
>         unsigned int trans_len;
>         unsigned int addr;
>         int i, pos, loop;
> +       u8 addr_width;
>
> +       addr_width = m->addr_width;
>         local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
>         if (!local_buf) {
>                 espi_trans->status = -ENOMEM;
> @@ -388,9 +402,9 @@ static void fsl_espi_rw_trans(struct spi_message *m,
>                 }
>
>                 if (pos > 0) {

So your SPI master driver supports nor-jedec only, ugh.

> -                       addr = fsl_espi_cmd2addr(local_buf);
> +                       addr = fsl_espi_cmd2addr(local_buf, addr_width);
>                         addr += pos;

Why is the address changed?

> -                       fsl_espi_addr2cmd(addr, local_buf);
> +                       fsl_espi_addr2cmd(addr, local_buf, addr_width);
>                 }

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
