From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of
 FIFO size
Date: Thu, 12 Mar 2015 13:35:10 +0100
Message-ID: <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Iwamatsu-san,

On Thu, Mar 12, 2015 at 3:31 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> This driver is the case of tx_buf was set or SPI_MASTER_MUST_TX is set to
> master_flags, will be transmit mode. However, the current code, when
> transmit mode and buffer is NULL, will be set to value of receive mode
> size.

If SPI_MASTER_MUST_TX is set, tx_buf will never be NULL.
If an SPI slave driver submits a receive-only request, the SPI core will
provide a dummy buffer (spi_master.dummy_tx).

> This is when the SPI_MASTER_MUST_TX is set to master_flags, sets to
> transmit and receive either small size of FIFO, so as not to set the
> actual size larger than value of FIFO.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  drivers/spi/spi-sh-msiof.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index e57eec0..260f433 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -606,12 +606,26 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
>  {
>         int fifo_shift;
>         int ret;
> +       int rx_words = min_t(int, words, p->rx_fifo_size);
> +       int tx_words = min_t(int, words, p->tx_fifo_size);
>
> -       /* limit maximum word transfer to rx/tx fifo size */
> -       if (tx_buf)
> -               words = min_t(int, words, p->tx_fifo_size);
> -       if (rx_buf)
> -               words = min_t(int, words, p->rx_fifo_size);
> +       /*
> +        * limit maximum word transfer to rx/tx fifo size.
> +        *
> +        * If SPI_MASTER_MUST_TX was enabled in master_flags, words was
> +        * set to small value of FIFO.
> +        */
> +       if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
> +               if (rx_words > tx_words)
> +                       words = tx_words;
> +               else
> +                       words = rx_words;
> +       } else {
> +               if (tx_buf)
> +                       words = tx_words;
> +               if (rx_buf)
> +                       words = rx_words;
> +       }
>
>         /* the fifo contents need shifting */
>         fifo_shift = 32 - bits;

Sorry, I fail to see what exactly this is fixing.

If SPI_MASTER_MUST_TX is set, all hardware SPI transfers are either
  a) transmit-only.
  b) bidirectional (transmit buffer may be a dummy, provided by the SPI core).

For case a, only the TX FIFO size matters.
  - The original code ignored the RX FIFO size (rx_buf == NULL),
  - After your change, it always uses the minimum of the TX and RX FIFO sizes
    (granted, the RX FIFO size is larger, so this doesn't make a difference on
    current hardware).

For case b, both FIFO sizes matter, and the original code handled that fine
(tx_buf != NULL, rx_buf != NULL).

What am I missing?
Are you using a backport with broken SPI_MASTER_MUST_TX handling in the SPI
core?

I've just verified that with today's tree (renesas-drivers-2015-03-12-v4.0-rc3),
SPI_MASTER_MUST_TX works fine, and a dummy tx_buf is passed when needed.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
