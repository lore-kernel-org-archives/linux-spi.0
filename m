From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Mon, 7 Nov 2016 15:45:06 +0100
Message-ID: <CAMuHMdUzZJ9YUEe_i7hbqsLomZybvkUbsF-B6sX9JgxYVzSNCA@mail.gmail.com>
References: <1478527635-18031-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478527635-18031-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Simon,

On Mon, Nov 7, 2016 at 3:07 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>
>     Fixes: b0d0ce8b6b91 ("spi: sh-msiof: Add DMA support")
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Geert, this is a patch from the Gen3 BSP 3.3.2 kernel.
> Please consider if it is appropriate for mainline.

AFAIK we haven't received any additional information to clear my reservations
in http://www.spinics.net/lists/linux-spi/msg03179.html

While the DMAC limitation has been removed from the R-Car Gen2 manual,
the SH-Mobile AG5 (sh73a0), R-Mobile APE6 (r8a73a4), and R-Mobile A1 (r8a7740)
manuals still state these SoCs have MSIOF blocks with two register banks,
and may thus be subject to this limitation.

Until this has been clarified, I'd like to keep the code as-is.

> ---
>  drivers/spi/spi-sh-msiof.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index cbf02ebb30a2..b882e0a500f8 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -1076,10 +1076,7 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
>                 return 0;
>         }
>
> -       /* The DMA engine uses the second register set, if present */
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       if (!res)
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>         master = p->master;
>         master->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
