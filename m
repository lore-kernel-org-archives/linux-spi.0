From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] spi: Support dev_pm_ops
Date: Wed, 22 Dec 2010 14:28:23 +0100
Message-ID: <201012221428.24040.rjw@sisk.pl>
References: <1293024339-26589-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1293024339-26589-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, December 22, 2010, Mark Brown wrote:
> Allow SPI drivers to use runtime PM and other dev_pm_ops features by
> implementing dev_pm_ops for the bus. The existing bus specific suspend
> and resume functions will be called if a driver does not provide dev_pm_ops
> allowing for transition to the new model.
> 
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

It looks good to me.

Thanks,
Rafael


> ---
> 
> This depends on the patch 'PM: Prototype the pm_generic_ operations' I
> posted recently to the PM and I2C lists, and has not exactly been
> thoroughly tested yet.
> 
>  drivers/spi/spi.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 709c836..85ad4b7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -28,6 +28,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_spi.h>
> +#include <linux/pm_runtime.h>
>  
>  static void spidev_release(struct device *dev)
>  {
> @@ -100,9 +101,8 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> -#ifdef	CONFIG_PM
> -
> -static int spi_suspend(struct device *dev, pm_message_t message)
> +#ifdef CONFIG_PM_SLEEP
> +static int spi_legacy_suspend(struct device *dev, pm_message_t message)
>  {
>  	int			value = 0;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> @@ -117,7 +117,7 @@ static int spi_suspend(struct device *dev, pm_message_t message)
>  	return value;
>  }
>  
> -static int spi_resume(struct device *dev)
> +static int spi_legacy_resume(struct device *dev)
>  {
>  	int			value = 0;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> @@ -132,18 +132,94 @@ static int spi_resume(struct device *dev)
>  	return value;
>  }
>  
> +static int spi_pm_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_suspend(dev);
> +	else
> +		return spi_legacy_suspend(dev, PMSG_SUSPEND);
> +}
> +
> +static int spi_pm_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_resume(dev);
> +	else
> +		return spi_legacy_resume(dev);
> +}
> +
> +static int spi_pm_freeze(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_freeze(dev);
> +	else
> +		return spi_legacy_suspend(dev, PMSG_FREEZE);
> +}
> +
> +static int spi_pm_thaw(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_thaw(dev);
> +	else
> +		return spi_legacy_resume(dev);
> +}
> +
> +static int spi_pm_poweroff(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_poweroff(dev);
> +	else
> +		return spi_legacy_suspend(dev, PMSG_HIBERNATE);
> +}
> +
> +static int spi_pm_restore(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_restore(dev);
> +	else
> +		return spi_legacy_resume(dev);
> +}
>  #else
> -#define spi_suspend	NULL
> -#define spi_resume	NULL
> +#define spi_pm_suspend	NULL
> +#define spi_pm_resume	NULL
> +#define spi_pm_freeze	NULL
> +#define spi_pm_thaw	NULL
> +#define spi_pm_poweroff	NULL
> +#define spi_pm_restore	NULL
>  #endif
>  
> +static const struct dev_pm_ops spi_pm = {
> +	.suspend = spi_pm_suspend,
> +	.resume = spi_pm_resume,
> +	.freeze = spi_pm_freeze,
> +	.thaw = spi_pm_thaw,
> +	.poweroff = spi_pm_poweroff,
> +	.restore = spi_pm_restore,
> +	SET_RUNTIME_PM_OPS(
> +		pm_generic_runtime_suspend,
> +		pm_generic_runtime_resume,
> +		pm_generic_runtime_idle
> +	)
> +};
> +
>  struct bus_type spi_bus_type = {
>  	.name		= "spi",
>  	.dev_attrs	= spi_dev_attrs,
>  	.match		= spi_match_device,
>  	.uevent		= spi_uevent,
> -	.suspend	= spi_suspend,
> -	.resume		= spi_resume,
> +	.pm		= &spi_pm,
>  };
>  EXPORT_SYMBOL_GPL(spi_bus_type);
>  
> 


------------------------------------------------------------------------------
Forrester recently released a report on the Return on Investment (ROI) of
Google Apps. They found a 300% ROI, 38%-56% cost savings, and break-even
within 7 months.  Over 3 million businesses have gone Google with Google Apps:
an online email calendar, and document program that's accessible from your 
browser. Read the Forrester report: http://p.sf.net/sfu/googleapps-sfnew
