From: Jiang Qiu <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for Designware
 SPI driver
Date: Sun, 14 Feb 2016 17:31:14 +0800
Message-ID: <56C04962.7080206@huawei.com>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <20160205110900.GA12311@sirena.org.uk>
Reply-To: <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	<haifeng.wei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, <charles.chenxin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160205110900.GA12311-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

Many thanks for your review, I'm so sorry for late reply because The=20
Chinese
new year holiday. See my replies below.

Best Regards
Jiang

=E5=9C=A8 2016/2/5 19:09, Mark Brown =E5=86=99=E9=81=93:
> On Fri, Feb 05, 2016 at 03:11:20PM +0800, qiujiang wrote:
>
>> This patch added ACPI support for DesignWare SPI mmio driver. It
>> was based the corresponding DT driver and compatible for this two
>> way. This patch has been tested on Hisilicon D02 board. It relies
>> on the GPIO patchset.
> Intel are heavy users of this driver on their systems which also use
> ACPI.  Have you discussed this binding with them?  I've copied Andy a=
nd
> Jarkko who've worked on the driver recently.
  I'm going to ask Andy to get some ideas that how to use this spi-dw-m=
mio
  driver by ACPI binding.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
Thanks for the reminder, I will fix it in the next version.
>
>> +	char propname[32];
> That's a magic number, where did it come from and why is it a magic
> nummber?
I'm sorry for here without any comments. This number define is come fro=
m
gpiolib.c. It means the max size of gpio property name. The reference c=
ode
located in line 1815 of gpiolib.c.
>> +	if (ACPI_COMPANION(&pdev->dev)) {
>> +		for (i =3D 0; i < dws->num_cs; i++) {
>> +			snprintf(propname, sizeof(propname), "cs%d", i);
>> +			gpiod =3D devm_gpiod_get(&pdev->dev,
>> +				propname, GPIOD_ASIS);
>> +			if (IS_ERR(gpiod)) {
>> +				dev_err(&pdev->dev, "Get gpio desc failed!\n");
>> +				return PTR_ERR(gpiod);
>> +			}
>> +		}
>> +	}
> I'm not seeing anywhere where we store the GPIO in this loop.  It is
> therefore unclear to me how the chip select is going to work?
In DT binding, of_get_named_gpio and devm_gpio_request were used to=20
parse gpio
pins defined in DTs and then request these pins. Similarly, for ACPI,=20
devm_gpiod_get
can do that two operation in a single function. It is a unified=20
interface to ACPI and DT
binding.

If the gpiod is valid, the corresponding gpio pins has been requested.=20
We do not need
to save this gpiod any more.

which gpio pin was used is defined in spi_device, named cs_gpio, the=20
configuration to the
gpio pins will be done in the setup callback routine of each device.=20
What the spi master
should do is just request these pins to the gpio subsystem.
>> +static const struct acpi_device_id dw_spi_mmio_acpi_match[] =3D {
>> +		{"HISI0171", 0},
>> +		{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
> I really do wish ACPI had some more sensible system for allocating
> device IDs so the tables were a little more legible. :(
This is really a question, I will do this feedback to ACPI maintainers.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
