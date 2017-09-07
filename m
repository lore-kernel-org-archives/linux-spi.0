From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/8] spi: sh-msiof: Add MSIOF parent clock changing
 function for R-Car Gen3
Date: Thu, 7 Sep 2017 10:38:24 +0200
Message-ID: <CAMuHMdVzv_cSSfRtHpfq86YoU-rxB4tk+LxyagTRAOvEoFxhYg@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com> <20170906070507.26223-7-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-7-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dirk,

On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/spi/spi-sh-msiof.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index a960e8da123d..2c53fc3f73af 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -188,6 +188,14 @@ struct sh_msiof_spi_priv {
>  #define IER_RFOVFE     0x00000008 /* Receive FIFO Overflow Enable */
>
>
> +static int msiof_rcar_is_gen3(struct device *dev)
> +{
> +       struct device_node *node = dev->of_node;
> +
> +       return of_device_is_compatible(node, "renesas,msiof-r8a7795") ||
> +               of_device_is_compatible(node, "renesas,msiof-r8a7796");

Things like this should be done by adding a flag to struct sh_msiof_chipdata
instead.

> +}
> +
>  static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
>  {
>         switch (reg_offs) {
> @@ -1252,6 +1260,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>         const struct of_device_id *of_id;
>         struct sh_msiof_spi_info *info;
>         struct sh_msiof_spi_priv *p;
> +       struct clk *ref_clk;
> +       u32 clk_rate = 0;
>         int i;
>         int ret;
>
> @@ -1352,6 +1362,17 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>                 goto err2;
>         }
>
> +       if (msiof_rcar_is_gen3(&master->dev)) {
> +               ref_clk = devm_clk_get(&pdev->dev, "msiof_ref_clk");

Where is this clock coming from?
The MSIOF DT bindings specify a single clock only.

> +               if (!IS_ERR(ref_clk))
> +                       clk_rate = clk_get_rate(ref_clk);
> +               if (clk_rate) {
> +                       clk_prepare_enable(p->clk);
> +                       clk_set_rate(p->clk, clk_rate);
> +                       clk_disable_unprepare(p->clk);
> +               }
> +       }
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
