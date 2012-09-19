From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: adopt pinctrl support
Date: Wed, 19 Sep 2012 15:33:47 +0200
Message-ID: <5059C9BB.9010603@antcom.de>
References: <1348057426-24898-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vinit Kamalaksha Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Viresh Kumar <viresh.kumar-5wv7dgnIgG8@public.gmane.org>,
	Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348057426-24898-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/19/2012 02:23 PM, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> Amend the PL022 pin controller to optionally take a pin control
> handle and set the state of the pins to "default" on boot and
> runtime resume, and to "sleep" at runtime suspend. This way we
> will dynamically save power on the SPI busses, for example some
> electronic designs may be able to ground the pins when unused
> instead of pull-up. Some pin controllers may want to set the
> pins as wake-up sources when sleeping.
> 
> Effect on platforms using the PL022 driver:
> 
> - If the platform does not use pin control - no semantic effect,
>   the pinctrl stubs will kick in and resolve the situation.
> 
> - Platforms using this driver and have pin control but no
>   function defined for the PL022 need to either supply a
>   "default" function in their map or enable pinctrl dummies
>   so the driver is satisfied.
> 
> - Platforms using this driver with hogs for setting up the PL022
>   pin control - stop using hogs to take the pl022 pin control
>   handle, let the driver handle this.
> 
> I'be looked at some platforms that may be affected:
> 
> - SPEAr: appears to define the proper functions in their device
>   trees and not hogging them, so things should be smooth, the
>   driver will simply start to take its pins.
> 
> - Ux500: the proper function is defined and will be taken properly
>   by the driver. New sleep states introduced by a separate patch to
>   ux500 but no regression, since the default state is sufficient.
> 
> - U300: old hog deleted as part of this patch.
> 
> - LPC32xx: does not appear to be using pinctrl.

FWIW: Tested-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>

On LPC32xx which shouldn't be affected, though. But anyway... PL022
still works. :-)

> 
> - ARM Integrator IMPD1, RealView & Versatile: does not use pinctrl.
> 
> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Cc: Vinit Kamalaksha Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
> Cc: Viresh Kumar <viresh.kumar-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/mach-u300/core.c |  3 ---
>  drivers/spi/spi-pl022.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
> index 03acf18..281292e 100644
> --- a/arch/arm/mach-u300/core.c
> +++ b/arch/arm/mach-u300/core.c
> @@ -1605,9 +1605,6 @@ static struct u300_mux_hog u300_mux_hogs[] = {
>  		.dev = &uart0_device.dev,
>  	},
>  	{
> -		.dev = &pl022_device.dev,
> -	},
> -	{
>  		.dev = &mmcsd_device.dev,
>  	},
>  };
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index e43b610..423513c 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -42,6 +42,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /*
>   * This macro is used to define some register default values.
> @@ -367,6 +368,10 @@ struct pl022 {
>  	resource_size_t			phybase;
>  	void __iomem			*virtbase;
>  	struct clk			*clk;
> +	/* Two optional pin states - default & sleep */
> +	struct pinctrl			*pinctrl;
> +	struct pinctrl_state		*pins_default;
> +	struct pinctrl_state		*pins_sleep;
>  	struct spi_master		*master;
>  	struct pl022_ssp_controller	*master_info;
>  	/* Message per-transfer pump */
> @@ -2068,6 +2073,28 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	pl022->chipselects = devm_kzalloc(dev, num_cs * sizeof(int),
>  					  GFP_KERNEL);
>  
> +	pl022->pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(pl022->pinctrl)) {
> +		status = PTR_ERR(pl022->pinctrl);
> +		goto err_no_pinctrl;
> +	}
> +
> +	pl022->pins_default = pinctrl_lookup_state(pl022->pinctrl,
> +						 PINCTRL_STATE_DEFAULT);
> +	/* enable pins to be muxed in and configured */
> +	if (!IS_ERR(pl022->pins_default)) {
> +		status = pinctrl_select_state(pl022->pinctrl,
> +				pl022->pins_default);
> +		if (status)
> +			dev_err(dev, "could not set default pins\n");
> +	} else
> +		dev_err(dev, "could not get default pinstate\n");
> +
> +	pl022->pins_sleep = pinctrl_lookup_state(pl022->pinctrl,
> +					       PINCTRL_STATE_SLEEP);
> +	if (IS_ERR(pl022->pins_sleep))
> +		dev_dbg(dev, "could not get sleep pinstate\n");
> +
>  	/*
>  	 * Bus Number Which has been Assigned to this SSP controller
>  	 * on this board
> @@ -2217,6 +2244,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	amba_release_regions(adev);
>   err_no_ioregion:
>   err_no_gpio:
> + err_no_pinctrl:
>  	spi_master_put(master);
>   err_no_master:
>   err_no_pdata:
> @@ -2290,15 +2318,33 @@ static int pl022_resume(struct device *dev)
>  static int pl022_runtime_suspend(struct device *dev)
>  {
>  	struct pl022 *pl022 = dev_get_drvdata(dev);
> +	int status = 0;
>  
>  	clk_disable(pl022->clk);
>  
> +	/* Optionally let pins go into sleep states */
> +	if (!IS_ERR(pl022->pins_sleep)) {
> +		status = pinctrl_select_state(pl022->pinctrl,
> +				pl022->pins_sleep);
> +		if (status)
> +			dev_err(dev, "could not set pins to sleep state\n");
> +	}
> +
>  	return 0;
>  }
>  
>  static int pl022_runtime_resume(struct device *dev)
>  {
>  	struct pl022 *pl022 = dev_get_drvdata(dev);
> +	int status = 0;
> +
> +	/* Optionaly enable pins to be muxed in and configured */
> +	if (!IS_ERR(pl022->pins_default)) {
> +		status = pinctrl_select_state(pl022->pinctrl,
> +				pl022->pins_default);
> +		if (status)
> +			dev_err(dev, "could not set default pins\n");
> +	}
>  
>  	clk_enable(pl022->clk);
>  


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
