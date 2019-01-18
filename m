From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Fri, 18 Jan 2019 09:25:26 +0100
Message-ID: <CAMuHMdW21JEz+pZbU5bb2Jcn8xpopsZ5LbbYhh2iGZFqtWCeQg@mail.gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw> <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for the update!


> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,800 @@

> +static int rpc_spi_xfer_message(struct rpc_spi *rpc,
> +                               struct spi_transfer *t)

As "t" is not an arbitrary transfer, but the last transfer containing the
actual data, I'd call it "last", or "data_xfer".

> +{
> +       int ret;
> +
> +       ret = rpc_spi_set_freq(rpc, t->speed_hz);
> +       if (ret)
> +               return ret;
> +
> +       ret = rpc_spi_io_xfer(rpc,
> +                             rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +                             t->tx_buf : NULL,
> +                             rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +                             t->rx_buf : NULL);
> +
> +       return ret;
> +}
> +
> +static int rpc_spi_transfer_one_message(struct spi_controller *ctlr,
> +                                       struct spi_message *msg)
> +{
> +       struct rpc_spi *rpc = spi_controller_get_devdata(ctlr);
> +       struct spi_transfer *t;

Likewise.

> +       int ret;
> +
> +       rpc_spi_transfer_setup(rpc, msg);
> +
> +       t = list_last_entry(&msg->transfers, struct spi_transfer,
> +                           transfer_list);
> +
> +       ret = rpc_spi_xfer_message(rpc, t);

As this function is small, perhaps just inline it here?
IMHO that makes the flow clearer.

> +       if (ret)
> +               goto out;
> +
> +       msg->status = 0;
> +       msg->actual_length = rpc->totalxferlen;
> +out:
> +       spi_finalize_current_message(ctlr);
> +       return 0;
> +}

The rest looks good to me, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
