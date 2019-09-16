From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] spi: dw: Add basic runtime PM support
Date: Mon, 16 Sep 2019 16:36:03 +0200
Message-ID: <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com> <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Gareth,

On Fri, Sep 13, 2019 at 2:13 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> Enable runtime PM so that the clock used to access the registers in the
> peripheral is turned on using a clock domain.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/highmem.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>
> @@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         if (dws->set_cs)
>                 master->set_cs = dws->set_cs;
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);

The second line keeps the device powered all the time.
What about setting spi_controller.auto_runtime_pm = true, so the SPI
code can manage its Runtime PM status?

> +
>         /* Basic HW init */
>         spi_hw_init(dev, dws);
>

What about the error path?
Don't you need to disable Runtime PM again in dw_spi_remove_host()?

I assume this will be called from drivers/spi/spi-dw-mmio.c, which already
enables the clock explicitly all the timer?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
