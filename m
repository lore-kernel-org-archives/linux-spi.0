From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi/pxa2xx: Convert to devm_ioremap_resource()
Date: Mon, 8 Apr 2013 18:50:32 +0800
Message-ID: <CAMPhdO-J4oYc5ecdUwfgmXWHm0iXK+OWx+mhJQb_r2E-KcnTiA@mail.gmail.com>
References: <1365416373-22541-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1365416373-22541-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 8, 2013 at 6:19 PM, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-pxa2xx.c |    9 ++++-----

Looks good to me,

Acked-by: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 1c2208c..f5d84d6 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -22,6 +22,7 @@
>  #include <linux/device.h>
>  #include <linux/ioport.h>
>  #include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/spi/pxa2xx_spi.h>
> @@ -1088,11 +1089,9 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
>         ssp = &pdata->ssp;
>
>         ssp->phys_base = res->start;
> -       ssp->mmio_base = devm_request_and_ioremap(&pdev->dev, res);
> -       if (!ssp->mmio_base) {
> -               dev_err(&pdev->dev, "failed to ioremap mmio_base\n");
> -               return NULL;
> -       }
> +       ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(ssp->mmio_base))
> +               return PTR_ERR(ssp->mmio_base);
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
>         ssp->irq = platform_get_irq(pdev, 0);
> --
> 1.7.9.5
>

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
