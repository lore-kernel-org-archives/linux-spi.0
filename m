From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx-core: Move spi specific code into
 separate module.
Date: Thu, 19 Jan 2012 09:08:43 +0100
Message-ID: <20120119080843.GC4066@pengutronix.de>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-3-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326934894-29516-3-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Thu, Jan 19, 2012 at 12:01:33PM +1100, Marc Reilly wrote:
> All spi specific code is moved into a new module. The mc13xxx
> struct moves to the include file by necessity.
>=20
> A new config choice selects the bus type with SPI as the first item
> (default selection) to remain compatible with existing configs.
>=20
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> ---
>  drivers/mfd/Kconfig         |   23 +++++-
>  drivers/mfd/Makefile        |    1 +
>  drivers/mfd/mc13xxx-core.c  |  174 ---------------------------------=
----------
>  drivers/mfd/mc13xxx-spi.c   |  173 +++++++++++++++++++++++++++++++++=
+++++++++
>  include/linux/mfd/mc13xxx.h |   23 ++++++
>  5 files changed, 216 insertions(+), 178 deletions(-)
>  create mode 100644 drivers/mfd/mc13xxx-spi.c
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f1391c2..6cf84c8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -514,17 +514,32 @@ config MFD_MC13783
>  	tristate
> =20
>  config MFD_MC13XXX
> -	tristate "Support Freescale MC13783 and MC13892"
> +	tristate "Support Freescale MC13783 or MC13892"
>  	depends on SPI_MASTER
>  	select MFD_CORE
>  	select MFD_MC13783
>  	help
> -	  Support for the Freescale (Atlas) PMIC and audio CODECs
> -	  MC13783 and MC13892.
> -	  This driver provides common support for accessing  the device,
> +	  Enable support for the Freescale MC13783 and MC13892 PMICs.
> +	  This driver provides common support for accessing the device,
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> =20
> +choice
> +	tristate "MC13XXX Bus interface type"
s/tristate/prompt/ and I would prefer MC13xxx but not care much.

> +	depends on MFD_MC13XXX
> +	default MFD_MC13XXX_SPI
> +	help
> +	  The MC13XXX family can be connected over an SPI or I2C bus.
> +	  Select the appropriate option for your hardware configuration.
> +
> +config MFD_MC13XXX_SPI
> +	tristate "SPI interface"
> +	depends on SPI_MASTER
> +	help
> +	  Select this if your MC13xxx is connected via an SPI bus.
> +
> +endchoice
> +
Hmm, you cannot have both, spi and i2c support?

What do you think about:

menuconfig MFD_MC13XXX
	...

if MFD_MC13XXX

config MFD_MC13XXX_SPI
	bool "MC13xxx spi bus interface" if SPI_MASTER && I2C
	default SPI_MASTER
	...

config MFD_MC13XXX_I2C
	bool "MC13xxx i2c bus interface" if SPI_MASTER && I2C
	default I2C
	...

endif # MFD_MC13XXX

This way the bus type is even selected automatically when only one of
spi and i2c support is enabled. (I havn't tested that though.)

=09
>  config ABX500_CORE
>  	bool "ST-Ericsson ABX500 Mixed Signal Circuit register functions"
>  	default y if ARCH_U300 || ARCH_U8500
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b2292eb..3856820 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_TWL6030_PWM)	+=3D twl6030-pwm.o
>  obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040-core.o twl6040-irq.o
> =20
>  obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
> +obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
> =20
>  obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
> =20
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 3c3079f..53732c0 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -15,33 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/interrupt.h>
> -#include <linux/spi/spi.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mc13xxx.h>
> =20
> -enum mc13xxx_id {
> -	MC13XXX_ID_MC13783,
> -	MC13XXX_ID_MC13892,
> -	MC13XXX_ID_INVALID,
> -};
> -
> -struct mc13xxx {
> -	struct spi_device *spidev;
> -
> -	struct device *dev;
> -	enum mc13xxx_id ictype;
> -
> -	struct mutex lock;
> -
> -	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
> -	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
> -
> -	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
> -	void *irqdata[MC13XXX_NUM_IRQ];
> -
> -	int adcflags;
> -};
> -
>  #define MC13XXX_IRQSTAT0	0
>  #define MC13XXX_IRQSTAT0_ADCDONEI	(1 << 0)
>  #define MC13XXX_IRQSTAT0_ADCBISDONEI	(1 << 1)
> @@ -170,67 +146,6 @@ void mc13xxx_unlock(struct mc13xxx *mc13xxx)
>  }
>  EXPORT_SYMBOL(mc13xxx_unlock);
> =20
> -#define MC13XXX_REGOFFSET_SHIFT 25
> -static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
> -				unsigned int offset, u32 *val)
> -{
> -	struct spi_transfer t;
> -	struct spi_message m;
> -	int ret;
> -
> -	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
> -
> -	memset(&t, 0, sizeof(t));
> -
> -	t.tx_buf =3D val;
> -	t.rx_buf =3D val;
> -	t.len =3D sizeof(u32);
> -
> -	spi_message_init(&m);
> -	spi_message_add_tail(&t, &m);
> -
> -	ret =3D spi_sync(mc13xxx->spidev, &m);
> -
> -	/* error in message.status implies error return from spi_sync */
> -	BUG_ON(!ret && m.status);
> -
> -	if (ret)
> -		return ret;
> -
> -	*val &=3D 0xffffff;
> -
> -	return 0;
> -}
> -
> -static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned i=
nt offset,
> -		u32 val)
> -{
> -	u32 buf;
> -	struct spi_transfer t;
> -	struct spi_message m;
> -	int ret;
> -
> -	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
> -
> -	memset(&t, 0, sizeof(t));
> -
> -	t.tx_buf =3D &buf;
> -	t.rx_buf =3D &buf;
> -	t.len =3D sizeof(u32);
> -
> -	spi_message_init(&m);
> -	spi_message_add_tail(&t, &m);
> -
> -	ret =3D spi_sync(mc13xxx->spidev, &m);
> -
> -	BUG_ON(!ret && m.status);
> -
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u=
32 *val)
>  {
>  	int ret;
> @@ -704,46 +619,6 @@ static int mc13xxx_add_subdevice(struct mc13xxx =
*mc13xxx, const char *format)
>  	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
>  }
> =20
> -static int mc13xxx_probe(struct spi_device *spi)
> -{
> -	struct mc13xxx *mc13xxx;
> -	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->dev)=
;
> -	int ret;
> -
> -	if (!pdata) {
> -		dev_err(&spi->dev, "invalid platform data\n");
> -		return -EINVAL;
> -	}
> -
> -	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> -	if (!mc13xxx)
> -		return -ENOMEM;
> -
> -	dev_set_drvdata(&spi->dev, mc13xxx);
> -	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
> -	spi->bits_per_word =3D 32;
> -	spi_setup(spi);
> -
> -	mc13xxx->dev =3D &spi->dev;
> -	mc13xxx->spidev =3D spi;
> -	mc13xxx->read_dev =3D mc13xxx_spi_reg_read;
> -	mc13xxx->write_dev =3D mc13xxx_spi_reg_write;
> -
> -	ret =3D mc13xxx_common_init(mc13xxx, pdata, spi->irq);
> -
> -	if (ret) {
> -		dev_set_drvdata(&spi->dev, NULL);
> -	} else {
> -		const struct spi_device_id *devid =3D
> -			spi_get_device_id(mc13xxx->spidev);
> -		if (!devid || devid->driver_data !=3D mc13xxx->ictype)
> -			dev_warn(mc13xxx->dev,
> -				"device id doesn't match auto detection!\n");
> -	}
> -
> -	return ret;
> -}
> -
>  int mc13xxx_common_init(struct mc13xxx *mc13xxx,
>  		struct mc13xxx_platform_data *pdata, int irq)
>  {
> @@ -805,55 +680,6 @@ err_revision:
>  }
>  EXPORT_SYMBOL_GPL(mc13xxx_common_init);
> =20
> -static int __devexit mc13xxx_remove(struct spi_device *spi)
> -{
> -	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&spi->dev);
> -
> -	free_irq(mc13xxx->spidev->irq, mc13xxx);
> -
> -	mfd_remove_devices(&spi->dev);
> -
> -	kfree(mc13xxx);
> -
> -	return 0;
> -}
> -
> -static const struct spi_device_id mc13xxx_device_id[] =3D {
> -	{
> -		.name =3D "mc13783",
> -		.driver_data =3D MC13XXX_ID_MC13783,
> -	}, {
> -		.name =3D "mc13892",
> -		.driver_data =3D MC13XXX_ID_MC13892,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
> -
> -static struct spi_driver mc13xxx_driver =3D {
> -	.id_table =3D mc13xxx_device_id,
> -	.driver =3D {
> -		.name =3D "mc13xxx",
> -		.bus =3D &spi_bus_type,
> -		.owner =3D THIS_MODULE,
> -	},
> -	.probe =3D mc13xxx_probe,
> -	.remove =3D __devexit_p(mc13xxx_remove),
> -};
> -
> -static int __init mc13xxx_init(void)
> -{
> -	return spi_register_driver(&mc13xxx_driver);
> -}
> -subsys_initcall(mc13xxx_init);
> -
> -static void __exit mc13xxx_exit(void)
> -{
> -	spi_unregister_driver(&mc13xxx_driver);
> -}
> -module_exit(mc13xxx_exit);
> -
>  MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
>  MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> new file mode 100644
> index 0000000..8958b44
> --- /dev/null
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -0,0 +1,173 @@
> +/*
> + * Copyright 2009-2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * loosely based on an earlier driver that has
> + * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it under
> + * the terms of the GNU General Public License version 2 as publishe=
d by the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mc13xxx.h>
> +
> +#define MC13XXX_REGOFFSET_SHIFT 25
> +static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
> +				unsigned int offset, u32 *val)
> +{
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	int ret;
> +
> +	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
> +
> +	memset(&t, 0, sizeof(t));
> +
> +	t.tx_buf =3D val;
> +	t.rx_buf =3D val;
> +	t.len =3D sizeof(u32);
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);
> +
> +	ret =3D spi_sync(mc13xxx->spidev, &m);
> +
> +	/* error in message.status implies error return from spi_sync */
> +	BUG_ON(!ret && m.status);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val &=3D 0xffffff;
> +
> +	return 0;
> +}
> +
> +static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned i=
nt offset,
> +		u32 val)
> +{
> +	u32 buf;
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	int ret;
> +
> +	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
> +
> +	memset(&t, 0, sizeof(t));
> +
> +	t.tx_buf =3D &buf;
> +	t.rx_buf =3D &buf;
> +	t.len =3D sizeof(u32);
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);
> +
> +	ret =3D spi_sync(mc13xxx->spidev, &m);
> +
> +	BUG_ON(!ret && m.status);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mc13xxx_spi_probe(struct spi_device *spi)
> +{
> +	struct mc13xxx *mc13xxx;
> +	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->dev)=
;
> +	int ret;
> +
> +	if (!pdata) {
> +		dev_err(&spi->dev, "invalid platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> +	if (!mc13xxx)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&spi->dev, mc13xxx);
> +	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
> +	spi->bits_per_word =3D 32;
> +	spi_setup(spi);
> +
> +	mc13xxx->dev =3D &spi->dev;
> +	mc13xxx->spidev =3D spi;
> +	mc13xxx->read_dev =3D mc13xxx_spi_reg_read;
> +	mc13xxx->write_dev =3D mc13xxx_spi_reg_write;
> +
> +	ret =3D mc13xxx_common_init(mc13xxx, pdata, spi->irq);
> +
> +	if (ret) {
> +		dev_set_drvdata(&spi->dev, NULL);
> +	} else {
> +		const struct spi_device_id *devid =3D
> +			spi_get_device_id(mc13xxx->spidev);
> +		if (!devid || devid->driver_data !=3D mc13xxx->ictype)
> +			dev_warn(mc13xxx->dev,
> +				"device id doesn't match auto detection!\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int __devexit mc13xxx_spi_remove(struct spi_device *spi)
> +{
> +	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&spi->dev);
> +
> +	free_irq(mc13xxx->spidev->irq, mc13xxx);
> +
> +	mfd_remove_devices(&spi->dev);
> +
> +	kfree(mc13xxx);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id mc13xxx_device_id[] =3D {
> +	{
> +		.name =3D "mc13783",
> +		.driver_data =3D MC13XXX_ID_MC13783,
> +	}, {
> +		.name =3D "mc13892",
> +		.driver_data =3D MC13XXX_ID_MC13892,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct spi_driver mc13xxx_spi_driver =3D {
> +	.id_table =3D mc13xxx_device_id,
> +	.driver =3D {
> +		.name =3D "mc13xxx",
> +		.bus =3D &spi_bus_type,
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D mc13xxx_spi_probe,
> +	.remove =3D __devexit_p(mc13xxx_spi_remove),
> +};
> +
> +static int __init mc13xxx_spi_init(void)
> +{
> +	return spi_register_driver(&mc13xxx_spi_driver);
> +}
> +subsys_initcall(mc13xxx_spi_init);
> +
> +static void __exit mc13xxx_spi_exit(void)
> +{
> +	spi_unregister_driver(&mc13xxx_spi_driver);
> +}
> +module_exit(mc13xxx_spi_exit);
> +
> +MODULE_DESCRIPTION("SPI driver for Freescale MC13XXX PMIC");
> +MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.=
h
> index 3e38f72..abf77d3 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -69,6 +69,29 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13=
xxx,
> =20
>  #define MC13XXX_NUM_IRQ		46
> =20
> +enum mc13xxx_id {
> +	MC13XXX_ID_MC13783,
> +	MC13XXX_ID_MC13892,
> +	MC13XXX_ID_INVALID,
> +};
> +
> +struct mc13xxx {
> +	struct spi_device *spidev;
> +
> +	struct device *dev;
> +	enum mc13xxx_id ictype;
> +
> +	struct mutex lock;
> +
> +	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
> +	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
> +
> +	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
> +	void *irqdata[MC13XXX_NUM_IRQ];
> +
> +	int adcflags;
> +};
> +
this should go to drivers/mfd/mc13xxx.h, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
