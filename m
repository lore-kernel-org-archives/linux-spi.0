From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drivercore: Generalize module_platform_driver
Date: Wed, 16 Nov 2011 10:11:27 -0700
Message-ID: <CACxGe6twCU9Nb+b00ei83jxaz0YnVa6nT0ra6Kp0c4PO7hjT6Q@mail.gmail.com>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Hennerich <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321434819-23678-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> w=
rote:
> This patch generalizes the module_platform_driver macro and introduce=
s a new
> module_driver macro. The module_driver macro takes a driver name, a r=
egister
> and a unregister function for this driver type. Using these it constr=
uct the
> module init and exit sections which register and unregister the drive=
r. Since
> such init/exit sections are commonly found in drivers this macro can =
be used
> to eliminate a lot of boilerplate code.
>
> The macro is not intended to be used by driver modules directly, inst=
ead it
> should be used to generate bus specific macros for registering driver=
s like
> the module_platform_driver macro.
>
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0include/linux/init.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +++++++++++++=
++++++++
> =A0include/linux/platform_device.h | =A0 12 ++----------
> =A02 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 9146f39..3e2d238 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -346,4 +346,25 @@ void __init parse_early_options(char *cmdline);
> =A0#define __exit_p(x) NULL
> =A0#endif
>
> +/**
> + * module_driver() - Helper macro for drivers that don't do anything
> + * special in module init/exit. This eliminates a lot of boilerplate=
=2E
> + * Each module may only use this macro once, and calling it replaces
> + * module_init() and module_exit().
> + * Use this macro to construct bus specific macros for registering
> + * drivers.
> + */
> +#define module_driver(__driver, __register, __unregister) \
> +static int __init __driver##_init(void) \
> +{ \
> + =A0 =A0 =A0 return __register(&(__driver)); \
> +} \
> +module_init(__driver##_init); \
> +static void __exit __driver##_exit(void) \
> +{ \
> + =A0 =A0 =A0 __unregister(&(__driver)); \
> +} \
> +module_exit(__driver##_exit);
> +
> =A0#endif /* _LINUX_INIT_H */
> +
> diff --git a/include/linux/platform_device.h b/include/linux/platform=
_device.h
> index 2a23f7d..165a8d1 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -196,16 +196,8 @@ static inline void platform_set_drvdata(struct p=
latform_device *pdev, void *data
> =A0* calling it replaces module_init() and module_exit()
> =A0*/
> =A0#define module_platform_driver(__platform_driver) \
> -static int __init __platform_driver##_init(void) \
> -{ \
> - =A0 =A0 =A0 return platform_driver_register(&(__platform_driver)); =
\
> -} \
> -module_init(__platform_driver##_init); \
> -static void __exit __platform_driver##_exit(void) \
> -{ \
> - =A0 =A0 =A0 platform_driver_unregister(&(__platform_driver)); \
> -} \
> -module_exit(__platform_driver##_exit);
> + =A0 =A0 =A0 module_driver(__platform_driver, platform_driver_regist=
er, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_driver_unregis=
ter)
>
> =A0extern struct platform_device *platform_create_bundle(struct platf=
orm_driver *driver,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int (*probe)(struct platform_device *),
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
