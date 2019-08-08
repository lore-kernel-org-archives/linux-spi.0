From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 41/57] spi: Remove dev_err() usage after platform_get_irq()
Date: Thu, 8 Aug 2019 10:09:10 +0200
Message-ID: <CAMuHMdWBFzNGhzAdEyFEbRE6nOWBKpCQ-5VXZfh3Bg+FMB7NXg@mail.gmail.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-42-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730181557.90391-42-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Stephen,

On Tue, Jul 30, 2019 at 8:19 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/spi/atmel-quadspi.c     |  1 -
>  drivers/spi/spi-armada-3700.c   |  1 -
>  drivers/spi/spi-bcm2835.c       |  1 -
>  drivers/spi/spi-bcm2835aux.c    |  1 -
>  drivers/spi/spi-bcm63xx-hsspi.c |  4 +---
>  drivers/spi/spi-bcm63xx.c       |  4 +---
>  drivers/spi/spi-cadence.c       |  1 -
>  drivers/spi/spi-dw-mmio.c       |  4 +---
>  drivers/spi/spi-efm32.c         |  4 +---
>  drivers/spi/spi-ep93xx.c        |  4 +---
>  drivers/spi/spi-fsl-dspi.c      |  1 -
>  drivers/spi/spi-fsl-qspi.c      |  4 +---
>  drivers/spi/spi-geni-qcom.c     |  4 +---
>  drivers/spi/spi-lantiq-ssc.c    | 12 +++---------
>  drivers/spi/spi-mt65xx.c        |  1 -
>  drivers/spi/spi-npcm-pspi.c     |  1 -
>  drivers/spi/spi-nuc900.c        |  1 -
>  drivers/spi/spi-nxp-fspi.c      |  4 +---
>  drivers/spi/spi-pic32-sqi.c     |  1 -
>  drivers/spi/spi-pic32.c         | 12 +++---------
>  drivers/spi/spi-qcom-qspi.c     |  4 +---
>  drivers/spi/spi-s3c24xx.c       |  1 -
>  drivers/spi/spi-sh-msiof.c      |  1 -
>  drivers/spi/spi-sh.c            |  4 +---
>  drivers/spi/spi-sifive.c        |  1 -
>  drivers/spi/spi-slave-mt27xx.c  |  1 -
>  drivers/spi/spi-sprd.c          |  4 +---
>  drivers/spi/spi-stm32-qspi.c    |  5 +----
>  drivers/spi/spi-sun4i.c         |  1 -
>  drivers/spi/spi-sun6i.c         |  1 -
>  drivers/spi/spi-synquacer.c     |  2 --
>  drivers/spi/spi-ti-qspi.c       |  1 -
>  drivers/spi/spi-uniphier.c      |  1 -
>  drivers/spi/spi-xlp.c           |  4 +---
>  drivers/spi/spi-zynq-qspi.c     |  1 -
>  drivers/spi/spi-zynqmp-gqspi.c  |  1 -
>  36 files changed, 19 insertions(+), 80 deletions(-)

Failed to catch
drivers/spi/spi-rspi.c: ret = platform_get_irq_byname(pdev, "rx");
drivers/spi/spi-rspi.c- if (ret < 0) {
drivers/spi/spi-rspi.c:         ret = platform_get_irq_byname(pdev, "mux");
drivers/spi/spi-rspi.c-         if (ret < 0)
drivers/spi/spi-rspi.c:                 ret = platform_get_irq(pdev, 0);
drivers/spi/spi-rspi.c-         if (ret >= 0)
drivers/spi/spi-rspi.c-                 rspi->rx_irq = rspi->tx_irq = ret;
drivers/spi/spi-rspi.c- } else {
drivers/spi/spi-rspi.c-         rspi->rx_irq = ret;
drivers/spi/spi-rspi.c:         ret = platform_get_irq_byname(pdev, "tx");
drivers/spi/spi-rspi.c-         if (ret >= 0)
drivers/spi/spi-rspi.c-                 rspi->tx_irq = ret;
drivers/spi/spi-rspi.c- }
drivers/spi/spi-rspi.c- if (ret < 0) {
drivers/spi/spi-rspi.c:         dev_err(&pdev->dev, "platform_get_irq error\n");
drivers/spi/spi-rspi.c-         goto error2;
drivers/spi/spi-rspi.c- }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
