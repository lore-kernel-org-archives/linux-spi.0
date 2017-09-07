From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/8] spi: sh-msiof: Fix gpio function
Date: Thu, 7 Sep 2017 10:24:09 +0200
Message-ID: <CAMuHMdV2H5GdAB=FETqFnmQvrwDKuaTfTwV7pxqW+RATj-nH+w@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com> <20170906070507.26223-8-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-8-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dirk,

On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>
> This patch adds a function to control chip select by GPIO.
> In order to use this patch, it is necessary to define it to
> devicetree. <refer Documentation/devicetree/bindings/spi/spi-bus.txt>
>
> <devicetree example>
>
> &pfc {
>         ...
>         /* MSIOF_SYMC Pin delete. */
>         msiof1_pins: spi2 {
>                 /* The definition of sync, ss1 and ss2 are
>                    unnecessary because of using GPIO as chip
>                    select. */
>                 groups = "msiof1_clk_c",
>                                 "msiof1_rxd_c",  "msiof1_txd_c";
>                 function = "msiof1";
>         };
>         ...
> };
>
> &msiof1 {
>         pinctrl-0 = <&msiof1_pins>;
>         pinctrl-names = "default";
>         cs-gpios = <&gpio6 21 GPIO_ACTIVE_LOW>,
>                     <&gpio6 27 GPIO_ACTIVE_LOW>;
>         status = "okay";
>
>         spidev@0 {
>                 ...
>                 reg = <0>;
>                 ...
>         };
>         spidev@1 {
>                 ...
>                 reg = <1>;
>                 ...
>         };
> };
>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/spi/spi-sh-msiof.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 2c53fc3f73af..fdad8d852602 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -541,6 +541,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
>  {
>         struct device_node      *np = spi->master->dev.of_node;
>         struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
> +       int ret;
>
>         pm_runtime_get_sync(&p->pdev->dev);
>
> @@ -559,8 +560,12 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
>                                   !!(spi->mode & SPI_LSB_FIRST),
>                                   !!(spi->mode & SPI_CS_HIGH));
>
> -       if (spi->cs_gpio >= 0)
> -               gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> +       if (gpio_is_valid(spi->cs_gpio)) {
> +               ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> +               if (!ret)
> +                       gpio_direction_output(spi->cs_gpio,
> +                                       !(spi->mode & SPI_CS_HIGH));
> +       }

The GPIO is never freed, and .setup() is called multiple times.

In addition, sh_msiof_spi_setup() writes to hardware registers.
Hence if multiple SPI slaves are present (e.g. hardware CS plus GPIO CS,
or multiple GPIO CSses), SPI transfers to a slave may use some configuration
from the previous call to .setup() for another SPI slave.

>         pm_runtime_put(&p->pdev->dev);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
