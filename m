From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/5] drivercore: Generalize module_platform_driver
Date: Fri, 13 Jan 2012 10:07:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201131003270.29680@axis700.grange>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de>
	<1321434819-23678-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael Hennerich <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1321434819-23678-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I didn't find this patch either in "next" or in Greg's "driver-core" 
trees, so, couldn't generate a patch and had to comment here:

On Wed, 16 Nov 2011, Lars-Peter Clausen wrote:

> This patch generalizes the module_platform_driver macro and introduces a new
> module_driver macro. The module_driver macro takes a driver name, a register
> and a unregister function for this driver type. Using these it construct the
> module init and exit sections which register and unregister the driver. Since
> such init/exit sections are commonly found in drivers this macro can be used
> to eliminate a lot of boilerplate code.
> 
> The macro is not intended to be used by driver modules directly, instead it
> should be used to generate bus specific macros for registering drivers like
> the module_platform_driver macro.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> ---
>  include/linux/init.h            |   21 +++++++++++++++++++++
>  include/linux/platform_device.h |   12 ++----------
>  2 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 9146f39..3e2d238 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -346,4 +346,25 @@ void __init parse_early_options(char *cmdline);
>  #define __exit_p(x) NULL
>  #endif
>  
> +/**
> + * module_driver() - Helper macro for drivers that don't do anything
> + * special in module init/exit. This eliminates a lot of boilerplate.
> + * Each module may only use this macro once, and calling it replaces
> + * module_init() and module_exit().
> + * Use this macro to construct bus specific macros for registering
> + * drivers.
> + */
> +#define module_driver(__driver, __register, __unregister) \
> +static int __init __driver##_init(void) \
> +{ \
> +	return __register(&(__driver)); \
> +} \
> +module_init(__driver##_init); \
> +static void __exit __driver##_exit(void) \
> +{ \
> +	__unregister(&(__driver)); \
> +} \
> +module_exit(__driver##_exit);

Shall we maybe remove the trailing semicolon above?

Thanks
Guennadi

> +
>  #endif /* _LINUX_INIT_H */
> +
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 2a23f7d..165a8d1 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -196,16 +196,8 @@ static inline void platform_set_drvdata(struct platform_device *pdev, void *data
>   * calling it replaces module_init() and module_exit()
>   */
>  #define module_platform_driver(__platform_driver) \
> -static int __init __platform_driver##_init(void) \
> -{ \
> -	return platform_driver_register(&(__platform_driver)); \
> -} \
> -module_init(__platform_driver##_init); \
> -static void __exit __platform_driver##_exit(void) \
> -{ \
> -	platform_driver_unregister(&(__platform_driver)); \
> -} \
> -module_exit(__platform_driver##_exit);
> +	module_driver(__platform_driver, platform_driver_register, \
> +			platform_driver_unregister)
>  
>  extern struct platform_device *platform_create_bundle(struct platform_driver *driver,
>  					int (*probe)(struct platform_device *),
> -- 
> 1.7.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
