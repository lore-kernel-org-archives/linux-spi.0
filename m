From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/s3c64xx: Log error interrupts
Date: Sat, 28 Jan 2012 22:30:36 +0530
Message-ID: <CAM=Q2ctA6o0wW4LMW=Jpe7HPGbm4S-UySURToXrC1r4kOe08Rg@mail.gmail.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
	<1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1327152265-10789-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,
Some minor doubts/ questions.

On 1/21/12, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> Although the hardware supports interrupts we're not currently using them
> at all since for small transfers the overhead is greater than that for
> busy waiting and for large transfers we have interrupts from the DMA.
> This means that if the hardware reports an error (especially one which
> might not stall transfer) we might miss it.
>
> Take a first pass at dealing with such errors by enabling the interrupt
> if we can and logging the errors if they happen. Ideally we'd report the
> error via the affected transfer but since we're in master mode it's very
> difficult to trigger errors at present and this code is much simpler.
>
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-s3c64xx.c |   57
> +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 019a716..d56066b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/workqueue.h>
> +#include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> @@ -153,6 +154,7 @@ struct s3c64xx_spi_dma_data {
>   * @tx_dmach: Controller's DMA channel for Tx.
>   * @sfr_start: BUS address of SPI controller regs.
>   * @regs: Pointer to ioremap'ed controller registers.
> + * @irq: interrupt
>   * @xfer_completion: To indicate completion of xfer task.
>   * @cur_mode: Stores the active configuration of the controller.
>   * @cur_bpw: Stores the active bits per word settings.
> @@ -930,6 +932,33 @@ setup_exit:
>  	return err;
>  }
>
> +static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
> +{
> +	struct s3c64xx_spi_driver_data *sdd = data;
> +	struct spi_master *spi = sdd->master;
> +	unsigned int val;
> +
> +	val = readl(sdd->regs + S3C64XX_SPI_PENDING_CLR);
> +
> +	val &= S3C64XX_SPI_PND_RX_OVERRUN_CLR |
> +		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
> +		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
> +		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
> +
> +	writel(val, sdd->regs + S3C64XX_SPI_PENDING_CLR);
> +
> +	if (val & S3C64XX_SPI_PND_RX_OVERRUN_CLR)
> +		dev_err(&spi->dev, "RX overrun\n");
> +	if (val & S3C64XX_SPI_PND_RX_UNDERRUN_CLR)
> +		dev_err(&spi->dev, "RX underrun\n");
> +	if (val & S3C64XX_SPI_PND_TX_OVERRUN_CLR)
> +		dev_err(&spi->dev, "TX overrun\n");
> +	if (val & S3C64XX_SPI_PND_TX_UNDERRUN_CLR)
> +		dev_err(&spi->dev, "TX underrun\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int
> channel)
>  {
>  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> @@ -970,7 +999,8 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  	struct s3c64xx_spi_driver_data *sdd;
>  	struct s3c64xx_spi_info *sci;
>  	struct spi_master *master;
> -	int ret;
> +	int ret, irq;
> +	char clk_name[16];
>
>  	if (pdev->id < 0) {
>  		dev_err(&pdev->dev,
> @@ -1010,6 +1040,12 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  		return -ENXIO;
>  	}
>
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
>  	master = spi_alloc_master(&pdev->dev,
>  				sizeof(struct s3c64xx_spi_driver_data));
>  	if (master == NULL) {
> @@ -1104,10 +1140,21 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  	INIT_WORK(&sdd->work, s3c64xx_spi_work);
>  	INIT_LIST_HEAD(&sdd->queue);
>
> +	ret = request_irq(irq, s3c64xx_spi_irq, 0, "spi-s3c64xx", sdd);

Could we have a threaded irq instead and there are prints and that may get
executed in interrupt context.

> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
> +			irq, ret);
> +		goto err8;
> +	}
> +
> +	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
> +	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
> +	       sdd->regs + S3C64XX_SPI_INT_EN);
> +
>  	if (spi_register_master(master)) {
>  		dev_err(&pdev->dev, "cannot register SPI master\n");
>  		ret = -EBUSY;
> -		goto err8;
> +		goto err9;
>  	}
>
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
> @@ -1119,6 +1166,8 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>
>  	return 0;
>
> +err9:
> +	free_irq(irq, sdd);
>  err8:
>  	destroy_workqueue(sdd->workqueue);
>  err7:
> @@ -1157,6 +1206,10 @@ static int s3c64xx_spi_remove(struct platform_device
> *pdev)
>
>  	spi_unregister_master(master);
>
> +	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
> +
> +	free_irq(platform_get_irq(pdev, 0), sdd);
> +
>  	destroy_workqueue(sdd->workqueue);
>
>  	clk_disable(sdd->src_clk);
> --
> 1.7.7.3
>
>
> ------------------------------------------------------------------------------
> Try before you buy = See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
