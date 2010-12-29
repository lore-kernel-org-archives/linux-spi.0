From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/9] spi/pxa2xx: register driver properly
Date: Wed, 29 Dec 2010 01:11:20 -0700
Message-ID: <20101229081120.GN8172@angua.secretlab.ca>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
	<1291312057-7933-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291312057-7933-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 02, 2010 at 06:47:29PM +0100, Sebastian Andrzej Siewior wrote:
> use platform_driver_register instead of platform_driver_probe. The
> latter only checks available devices at the time of calling. So if a
> device gets inserter at a later point in time then the driver will never
> play with it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

picked up for -next via merge

g.

> ---
>  drivers/spi/pxa2xx_spi.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index e76b1af..4e169b5 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1366,7 +1366,7 @@ static void cleanup(struct spi_device *spi)
>  	kfree(chip);
>  }
>  
> -static int __init init_queue(struct driver_data *drv_data)
> +static int __devinit init_queue(struct driver_data *drv_data)
>  {
>  	INIT_LIST_HEAD(&drv_data->queue);
>  	spin_lock_init(&drv_data->lock);
> @@ -1454,7 +1454,7 @@ static int destroy_queue(struct driver_data *drv_data)
>  	return 0;
>  }
>  
> -static int __init pxa2xx_spi_probe(struct platform_device *pdev)
> +static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct pxa2xx_spi_master *platform_info;
> @@ -1723,13 +1723,14 @@ static struct platform_driver driver = {
>  		.pm	= &pxa2xx_spi_pm_ops,
>  #endif
>  	},
> +	.probe = pxa2xx_spi_probe,
>  	.remove = pxa2xx_spi_remove,
>  	.shutdown = pxa2xx_spi_shutdown,
>  };
>  
>  static int __init pxa2xx_spi_init(void)
>  {
> -	return platform_driver_probe(&driver, pxa2xx_spi_probe);
> +	return platform_driver_register(&driver);
>  }
>  subsys_initcall(pxa2xx_spi_init);
>  
> -- 
> 1.7.3.2
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
