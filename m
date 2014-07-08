From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] mtd: spi-nor: Correct device-id for n25q512a device
Date: Tue, 8 Jul 2014 09:38:19 +0200
Message-ID: <CAMuHMdV52qwThCezu=4NCpVBwbM2AjSK4cKXA+BdO=v_Yy2sBQ@mail.gmail.com>
References: <1404795285-2929-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404795285-2929-1-git-send-email-Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

CC linux-mtd

On Tue, Jul 8, 2014 at 6:54 AM, Priyanka Jain
<Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Signed-off-by: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c713c86..148bb51d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -487,7 +487,7 @@ const struct spi_device_id spi_nor_ids[] = {
>         { "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
>         { "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
>         { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
> -       { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
> +       { "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },
>
>         /* PMC */
>         { "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> --
> 1.7.4.1

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
