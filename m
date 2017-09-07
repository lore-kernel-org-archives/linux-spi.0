From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 5/8] spi: sh-msiof: Wait for Tx FIFO empty after DMA
Date: Thu, 7 Sep 2017 10:34:49 +0200
Message-ID: <CAMuHMdX0tu1aZqQoqUwvaN-dnsKicU_UwmRFzW6KL0LKJiULVQ@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com> <20170906070507.26223-6-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906070507.26223-6-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Dirk,

On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> When Tx DMA is only used, Tx FIFO is still not empty after DMA callback.
> This patch waits for sweeping data out of the Tx FIFO.
>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> [adjust context]
> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/spi/spi-sh-msiof.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 660b03ed6770..a960e8da123d 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -638,6 +638,17 @@ static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
>                                 dev_err(&p->pdev->dev, "Tx DMA timeout\n");
>                                 return -ETIMEDOUT;
>                         }
> +                       if (!rx) {

May the issue also happen is TX and RX are used?
See also "[PATCH 4/8] spi: sh-msiof: Fix DMA completion".

> +                               sh_msiof_write(p, IER, IER_TEOFE);
> +
> +                               /* wait for tx fifo to be emptied */
> +                               if (!wait_for_completion_timeout(&p->done,
> +                                                                HZ)) {
> +                                       dev_err(&p->pdev->dev,
> +                                       "Tx fifo to be emptied timeout\n");
> +                                       return -ETIMEDOUT;
> +                               }
> +                       }
>                 }
>                 if (rx) {
>                         if (!wait_for_completion_timeout(&p->done_dma_rx,

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
