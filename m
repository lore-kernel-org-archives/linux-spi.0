From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
Date: Thu, 21 Nov 2019 09:30:34 +0100
Message-ID: <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
References: <20191121080954.14915-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191121080954.14915-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Peter,

On Thu, Nov 21, 2019 at 9:11 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> There is no reason to use the dma_request_slave_channel_compat() as no
> filter function and parameter is provided.
>
> Switch the driver to use dma_request_chan() instead.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
>  static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>  {
>         struct spi_master *master = pic32s->master;
> -       dma_cap_mask_t mask;
>
> -       dma_cap_zero(mask);
> -       dma_cap_set(DMA_SLAVE, mask);
> -
> -       master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
> -                                                         dev, "spi-rx");
> -       if (!master->dma_rx) {
> +       master->dma_rx = dma_request_chan(dev, "spi-rx");

Why not dma_request_slave_channel()?
That way you...

> +       if (IS_ERR(master->dma_rx)) {

... don't have to change the NULL check here, and...

>                 dev_warn(dev, "RX channel not found.\n");
> +               master->dma_rx = NULL;

...  don't have to override by NULL here.

(same for TX below).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
