From: Hannu Heikkinen <hannuxx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] spi/ep93xx: clean probe/remove routines
Date: Wed, 9 May 2012 15:08:48 +0300
Message-ID: <CAHxAxTPTvfv-2eaLK-9dtDFjXP9ruUauJMD8wA=MDEUP4m86ug@mail.gmail.com>
References: <1334851537-16386-1-git-send-email-hannuxx@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mika.westerberg-X3B1VOXEql0@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334851537-16386-1-git-send-email-hannuxx-X3B1VOXEql0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

any progress on this (patch in below)? Haven't received any comments after
v2....

br,
Hannu

On Thu, Apr 19, 2012 at 7:05 PM, Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org> wrote:

> Use devm_* functions for managing devres resources.
>
> Also use local variable irq and remove irq variable from
> struct ep93xx_spi, as it is needed only in probe routine.
>
> Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
> Acked-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Signed-off-by: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
> ---
>  drivers/spi/spi-ep93xx.c |   37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index 6db2887..ea78625 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -76,7 +76,6 @@
>  * @clk: clock for the controller
>  * @regs_base: pointer to ioremap()'d registers
>  * @sspdr_phys: physical address of the SSPDR register
> - * @irq: IRQ number used by the driver
>  * @min_rate: minimum clock rate (in Hz) supported by the controller
>  * @max_rate: maximum clock rate (in Hz) supported by the controller
>  * @running: is the queue running
> @@ -114,7 +113,6 @@ struct ep93xx_spi {
>        struct clk                      *clk;
>        void __iomem                    *regs_base;
>        unsigned long                   sspdr_phys;
> -       int                             irq;
>        unsigned long                   min_rate;
>        unsigned long                   max_rate;
>        bool                            running;
> @@ -1035,6 +1033,7 @@ static int __devinit ep93xx_spi_probe(struct
> platform_device *pdev)
>        struct ep93xx_spi_info *info;
>        struct ep93xx_spi *espi;
>        struct resource *res;
> +       int irq;
>        int error;
>
>        info = pdev->dev.platform_data;
> @@ -1074,8 +1073,8 @@ static int __devinit ep93xx_spi_probe(struct
> platform_device *pdev)
>        espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);
>        espi->pdev = pdev;
>
> -       espi->irq = platform_get_irq(pdev, 0);
> -       if (espi->irq < 0) {
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
>                error = -EBUSY;
>                dev_err(&pdev->dev, "failed to get irq resources\n");
>                goto fail_put_clock;
> @@ -1088,26 +1087,20 @@ static int __devinit ep93xx_spi_probe(struct
> platform_device *pdev)
>                goto fail_put_clock;
>        }
>
> -       res = request_mem_region(res->start, resource_size(res),
> pdev->name);
> -       if (!res) {
> -               dev_err(&pdev->dev, "unable to request iomem resources\n");
> -               error = -EBUSY;
> -               goto fail_put_clock;
> -       }
> -
>        espi->sspdr_phys = res->start + SSPDR;
> -       espi->regs_base = ioremap(res->start, resource_size(res));
> +
> +       espi->regs_base = devm_request_and_ioremap(&pdev->dev, res);
>        if (!espi->regs_base) {
>                dev_err(&pdev->dev, "failed to map resources\n");
>                error = -ENODEV;
> -               goto fail_free_mem;
> +               goto fail_put_clock;
>        }
>
> -       error = request_irq(espi->irq, ep93xx_spi_interrupt, 0,
> -                           "ep93xx-spi", espi);
> +       error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
> +                               0, "ep93xx-spi", espi);
>        if (error) {
>                dev_err(&pdev->dev, "failed to request irq\n");
> -               goto fail_unmap_regs;
> +               goto fail_put_clock;
>        }
>
>        if (info->use_dma && ep93xx_spi_setup_dma(espi))
> @@ -1132,7 +1125,7 @@ static int __devinit ep93xx_spi_probe(struct
> platform_device *pdev)
>        }
>
>        dev_info(&pdev->dev, "EP93xx SPI Controller at 0x%08lx irq %d\n",
> -                (unsigned long)res->start, espi->irq);
> +                (unsigned long)res->start, irq);
>
>        return 0;
>
> @@ -1140,11 +1133,6 @@ fail_free_queue:
>        destroy_workqueue(espi->wq);
>  fail_free_dma:
>        ep93xx_spi_release_dma(espi);
> -       free_irq(espi->irq, espi);
> -fail_unmap_regs:
> -       iounmap(espi->regs_base);
> -fail_free_mem:
> -       release_mem_region(res->start, resource_size(res));
>  fail_put_clock:
>        clk_put(espi->clk);
>  fail_release_master:
> @@ -1158,7 +1146,6 @@ static int __devexit ep93xx_spi_remove(struct
> platform_device *pdev)
>  {
>        struct spi_master *master = platform_get_drvdata(pdev);
>        struct ep93xx_spi *espi = spi_master_get_devdata(master);
> -       struct resource *res;
>
>        spin_lock_irq(&espi->lock);
>        espi->running = false;
> @@ -1184,10 +1171,6 @@ static int __devexit ep93xx_spi_remove(struct
> platform_device *pdev)
>        spin_unlock_irq(&espi->lock);
>
>        ep93xx_spi_release_dma(espi);
> -       free_irq(espi->irq, espi);
> -       iounmap(espi->regs_base);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       release_mem_region(res->start, resource_size(res));
>        clk_put(espi->clk);
>        platform_set_drvdata(pdev, NULL);
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
