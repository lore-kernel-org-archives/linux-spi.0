From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Fix DMA transfer size check
Date: Mon, 7 Nov 2016 15:52:13 +0100
Message-ID: <CAMuHMdW=uwsAM-ZpwgdYy5uj2tNmEmTf8OtoxB=8BLL0cgTqew@mail.gmail.com>
References: <1478527623-17960-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478527623-17960-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Simon,

On Mon, Nov 7, 2016 at 3:07 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>
> DMA supports 32-bit words only,
> even if BITLEN1 of SITMDR2 register is 16bit.
>
> Fixes: b0d0ce8b6b91 ("spi: sh-msiof: Add DMA support")
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Geert, this is a patch from the Gen3 BSP 3.3.2 kernel.
> Please consider if it is appropriate for mainline.

Thanks, looks correct to me. Probably I treated "l" as the number
of words to transfer, while it is the number of bytes to transfer.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/spi/spi-sh-msiof.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 1de3a772eb7d..cbf02ebb30a2 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -862,7 +862,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
>                                 break;
>                         copy32 = copy_bswap32;
>                 } else if (bits <= 16) {
> -                       if (l & 1)
> +                       if (l & 3)
>                                 break;
>                         copy32 = copy_wswap32;
>                 } else {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
