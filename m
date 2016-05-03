From: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal implementation
Date: Tue, 3 May 2016 16:32:57 -0500
Message-ID: <CADRPPNQ8auFyiEmnWE=FgQ1WBi-GFjCGr5xHzq5d_KnnFQ6CUQ@mail.gmail.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
	<1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yao.yuan-3arQi8VN3Tc@public.gmane.org,
	Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461744756-31481-2-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 27, 2016 at 3:12 AM, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> From: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
>
> The qSPI controller's endian is independent of the CPU core's endian.

DSPI?

>
> For eg, Core on NXP LS1043A SoC is little endian but DSPI is big endian
> whereas Core on LS2080A SoC is little endian and DSPI also is little
> endian on the same core.

It's not correct to say the SoC is little endian for LS1043 or LS2080.
Not all devices on the SoC are sharing the same endianness and the
core endianness is configurable.

>
> At first we use regmap to cover this issue.
> But the regmap is designed too large and complex.
> The issue for regmap often effect the DSPI's stability.

This is not stability issue but functional issue.

>
> DSPI driver just only need a effective way to R/W the controller register
> with BE or LE mode.
>
> So it's better to packaging a sample function.
> This will make the DSPI driver more stability and high effective.
>
> Signed-off-by: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 99 +++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 9e9dadb..9a61572 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -27,7 +27,6 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/regmap.h>
>  #include <linux/sched.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_bitbang.h>
> @@ -143,7 +142,7 @@ struct fsl_dspi {
>         struct spi_master       *master;
>         struct platform_device  *pdev;
>
> -       struct regmap           *regmap;
> +       void __iomem            *iobase;
>         int                     irq;
>         struct clk              *clk;
>
> @@ -165,13 +164,46 @@ struct fsl_dspi {
>         u32                     waitflags;
>
>         u32                     spi_tcnt;
> +       bool                    big_endian;
>  };
>
> +/*
> + * R/W functions for big- or little-endian registers:
> + * The qSPI controller's endian is independent of the CPU core's endian.

DSPI?

> + */
> +static void dspi_writel(struct fsl_dspi *d, u32 val, u32 offset)
> +{
> +       if (d->big_endian)
> +               iowrite32be(val, d->iobase + offset);
> +       else
> +               iowrite32(val, d->iobase + offset);
> +}
> +
> +static u32 dspi_readl(struct fsl_dspi *d, u32 offset)
> +{
> +       if (d->big_endian)
> +               return ioread32be(d->iobase + offset);
> +       else
> +               return ioread32(d->iobase + offset);
> +}
> +
> +static void dspi_updatel(struct fsl_dspi *d, u32 mask, u32 val, u32 offset)
> +{
> +       u32 tmp, orig;
> +
> +       orig = dspi_readl(d, offset);
> +
> +       tmp = orig & ~mask;
> +       tmp |= val & mask;
> +
> +       dspi_writel(d, tmp, offset);
> +}
> +
>  static inline int is_double_byte_mode(struct fsl_dspi *dspi)
>  {
>         unsigned int val;
>
> -       regmap_read(dspi->regmap, SPI_CTAR(0), &val);
> +       val = dspi_readl(dspi, SPI_CTAR(0));
>
>         return ((val & SPI_FRAME_BITS_MASK) == SPI_FRAME_BITS(8)) ? 0 : 1;
>  }
> @@ -270,7 +302,7 @@ static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
>         u16 d;
>         unsigned int val;
>
> -       regmap_read(dspi->regmap, SPI_POPR, &val);
> +       val = dspi_readl(dspi, SPI_POPR);
>         d = SPI_POPR_RXDATA(val);
>
>         if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
> @@ -294,8 +326,8 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
>                  */
>                 if (tx_word && (dspi->len == 1)) {
>                         dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
> -                       regmap_update_bits(dspi->regmap, SPI_CTAR(0),
> -                                       SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
> +                       dspi_updatel(dspi, SPI_FRAME_BITS_MASK,
> +                                       SPI_FRAME_BITS(8), SPI_CTAR(0));
>                         tx_word = 0;
>                 }
>
> @@ -309,7 +341,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
>                 } else if (tx_word && (dspi->len == 1))
>                         dspi_pushr |= SPI_PUSHR_EOQ;
>
> -               regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
> +               dspi_writel(dspi, dspi_pushr, SPI_PUSHR);
>
>                 tx_count++;
>         }
> @@ -343,8 +375,8 @@ static int dspi_tcfq_write(struct fsl_dspi *dspi)
>
>         if (tx_word && (dspi->len == 1)) {
>                 dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
> -               regmap_update_bits(dspi->regmap, SPI_CTAR(0),
> -                               SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
> +               dspi_updatel(dspi, SPI_FRAME_BITS_MASK,
> +                               SPI_FRAME_BITS(8), SPI_CTAR(0));
>                 tx_word = 0;
>         }
>
> @@ -353,7 +385,7 @@ static int dspi_tcfq_write(struct fsl_dspi *dspi)
>         if ((dspi->cs_change) && (!dspi->len))
>                 dspi_pushr &= ~SPI_PUSHR_CONT;
>
> -       regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
> +       dspi_writel(dspi, dspi_pushr, SPI_PUSHR);
>
>         return tx_word + 1;
>  }
> @@ -378,7 +410,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
>         enum dspi_trans_mode trans_mode;
>         u32 spi_tcr;
>
> -       regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
> +       spi_tcr = dspi_readl(dspi, SPI_TCR);
>         dspi->spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
>
>         message->actual_length = 0;
> @@ -407,21 +439,19 @@ static int dspi_transfer_one_message(struct spi_master *master,
>                 if (!dspi->tx)
>                         dspi->dataflags |= TRAN_STATE_TX_VOID;
>
> -               regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
> -               regmap_update_bits(dspi->regmap, SPI_MCR,
> -                               SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
> -                               SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
> -               regmap_write(dspi->regmap, SPI_CTAR(0),
> -                               dspi->cur_chip->ctar_val);
> +               dspi_writel(dspi, dspi->cur_chip->mcr_val, SPI_MCR);
> +               dspi_updatel(dspi, SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
> +                                  SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF, SPI_MCR);
> +               dspi_writel(dspi, dspi->cur_chip->ctar_val, SPI_CTAR(0));
>
>                 trans_mode = dspi->devtype_data->trans_mode;
>                 switch (trans_mode) {
>                 case DSPI_EOQ_MODE:
> -                       regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
> +                       dspi_writel(dspi, SPI_RSER_EOQFE, SPI_RSER);
>                         dspi_eoq_write(dspi);
>                         break;
>                 case DSPI_TCFQ_MODE:
> -                       regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
> +                       dspi_writel(dspi, SPI_RSER_TCFQE, SPI_RSER);
>                         dspi_tcfq_write(dspi);
>                         break;
>                 default:
> @@ -525,14 +555,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>         u32 spi_tcnt, tcnt_diff;
>         int tx_word;
>
> -       regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> -       regmap_write(dspi->regmap, SPI_SR, spi_sr);
> +       spi_sr = dspi_readl(dspi, SPI_SR);
> +       dspi_writel(dspi, spi_sr, SPI_SR);
>
>
>         if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
>                 tx_word = is_double_byte_mode(dspi);
>
> -               regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
> +               spi_tcr = dspi_readl(dspi, SPI_TCR);
>                 spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
>                 /*
>                  * The width of SPI Transfer Counter in SPI_TCR is 16bits,
> @@ -569,10 +599,10 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>
>                 if (!dspi->len) {
>                         if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
> -                               regmap_update_bits(dspi->regmap,
> -                                                  SPI_CTAR(0),
> -                                                  SPI_FRAME_BITS_MASK,
> -                                                  SPI_FRAME_BITS(16));
> +                               dspi_updatel(dspi,
> +                                            SPI_FRAME_BITS_MASK,
> +                                            SPI_FRAME_BITS(16),
> +                                            SPI_CTAR(0));
>                                 dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
>                         }
>
> @@ -636,13 +666,6 @@ static int dspi_resume(struct device *dev)
>
>  static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
>
> -static const struct regmap_config dspi_regmap_config = {
> -       .reg_bits = 32,
> -       .val_bits = 32,
> -       .reg_stride = 4,
> -       .max_register = 0x88,
> -};
> -
>  static int dspi_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
> @@ -700,13 +723,7 @@ static int dspi_probe(struct platform_device *pdev)
>                 goto out_master_put;
>         }
>
> -       dspi->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> -                                               &dspi_regmap_config);
> -       if (IS_ERR(dspi->regmap)) {
> -               dev_err(&pdev->dev, "failed to init regmap: %ld\n",
> -                               PTR_ERR(dspi->regmap));
> -               return PTR_ERR(dspi->regmap);
> -       }
> +       dspi->iobase = base;
>
>         dspi->irq = platform_get_irq(pdev, 0);
>         if (dspi->irq < 0) {
> @@ -730,6 +747,8 @@ static int dspi_probe(struct platform_device *pdev)
>         }
>         clk_prepare_enable(dspi->clk);
>
> +       dspi->big_endian = of_property_read_bool(np, "big-endian");
> +
>         master->max_speed_hz =
>                 clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
>
> --
> 2.1.0.27.g96db324
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
