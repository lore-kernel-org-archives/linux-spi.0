From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/5] I2C: Add helper macro for i2c_driver boilerplate
Date: Wed, 16 Nov 2011 10:12:20 -0700
Message-ID: <CACxGe6toOFjOdP7-oZ4O2J=g2U+Y+aWOUzHDoCaX6goAs6zKsQ@mail.gmail.com>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-3-git-send-email-lars@metafoo.de>
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
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321434819-23678-3-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> w=
rote:
> This patch introduces the module_i2c_driver macro which is a convenie=
nce macro
> for I2C driver modules similar to module_platform_driver. It is inten=
ded to be
> used by drivers which init/exit section does nothing but register/unr=
egister
> the I2C driver. By using this macro it is possible to eliminate a few=
 lines of
> boilerplate code per I2C driver.
>
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0include/linux/i2c.h | =A0 13 +++++++++++++
> =A01 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index a81bf6d..7e92854 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -485,6 +485,19 @@ static inline int i2c_adapter_id(struct i2c_adap=
ter *adap)
> =A0{
> =A0 =A0 =A0 =A0return adap->nr;
> =A0}
> +
> +/**
> + * module_i2c_driver() - Helper macro for registering a I2C driver
> + * @__i2c_driver: i2c_driver struct
> + *
> + * Helper macro for I2C drivers which do not do anything special in =
module
> + * init/exit. This eliminates a lot of boilerplate. Each module may =
only
> + * use this macro once, and calling it replaces module_init() and mo=
dule_exit()
> + */
> +#define module_i2c_driver(__i2c_driver) \
> + =A0 =A0 =A0 module_driver(__i2c_driver, i2c_add_driver, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_driver)
> +
> =A0#endif /* I2C */
> =A0#endif /* __KERNEL__ */
>
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
