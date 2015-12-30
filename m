From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 0/3] ACPI: Add irq_type to gpio interrupt
Date: Wed, 30 Dec 2015 18:40:21 +0100
Message-ID: <56841705.5030508@gmail.com>
References: <1450909535-32138-1-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450909535-32138-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

Do you expect any other update from me ?
Is there Anything else needed to this patchset to hit 4.5 release ?

Best Regards
Christophe

On 23/12/2015 23:25, Christophe Ricard wrote:
> Hi,
>
> ACPI probing method does not retrieve irq_type from a gpio interrupt declared
> with GpioInt as it is done with devicetree probing. In other terms, irq_get_trigger_type
> will always send back 0.
>
> Those 3 patches propose a way to retrieve the correct interrupt polarity/type from a GpioInt
> acpi declaration when using irq_get_trigger_type.
>
> Since v4 after Mika and Andy's feedbacks:
> - acpi_gpio_info active_low field got renamed polarity. Note that polarity/active_low is having sense
> also when a gpio is not mapped as an interrupt but as an output (For example: check gpiod_set_value
> in drivers/gpio/gpiolib.c).
> - acpi_gsi_get_irq_type is now renamed acpi_dev_get_irq_type and moved to drivers/acpi/resource.c
> - The irq described in the acpi spi slave node is now set once we fall back to retrieve normal interrupt.
>
> Since v5 after Andy's feedbacks:
> - Make sure we are not using u* type but pure C type for non hardware value.
>
> Since v6:
> - Patches now applies on top of Raphael tree tag linux-next
>
> Since v7:
> - Added "Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>" to patch 1.
> - Added "Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>" to patch 3.
> - Patch 3 got reworked following Mika's feedback.
> - Patch 2 added few comment in acpi_find_gpio following Mika's feedback.
>
> Best Regards
> Christophe
>
> Christophe Ricard (3):
>    acpi: Rename acpi_gsi_get_irq_type to acpi_dev_get_irq_type and export
>      symbol
>    ACPI / gpio: Add irq_type when a gpio is used as an interrupt
>    ACPI / spi: attach gpio irq from acpi description to spi device
>
>   drivers/acpi/gsi.c          | 21 +--------------------
>   drivers/acpi/resource.c     | 26 ++++++++++++++++++++++++++
>   drivers/gpio/gpiolib-acpi.c | 33 +++++++++++++++++++++++++++------
>   drivers/gpio/gpiolib.c      |  4 ++--
>   drivers/gpio/gpiolib.h      |  3 ++-
>   drivers/spi/spi.c           |  3 +++
>   include/linux/acpi.h        |  1 +
>   7 files changed, 62 insertions(+), 29 deletions(-)
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
