From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 2/3] ACPI / gpio: Add irq_type when a gpio is used as
 an interrupt
Date: Fri, 18 Dec 2015 11:13:11 +0200
Message-ID: <20151218091311.GD1762@lahna.fi.intel.com>
References: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
 <1450163493-4938-3-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450163493-4938-3-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 15, 2015 at 08:11:32AM +0100, Christophe Ricard wrote:
> When a gpio is used as an interrupt in acpi, the irq_type was not
> available for device driver.
> 
> Make available polarity and triggering information in acpi_find_gpio by
> renaming acpi_gpio_info field active_low  to polarity and adding triggering
> field (edge/level).
> For sanity, in gpiolib.c replace info.active_low by
> "info.polarity == GPIO_ACTIVE_LOW".
> 
> Set the irq_type if necessary in acpi_dev_gpio_irq_get.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
> ---
>  drivers/gpio/gpiolib-acpi.c | 30 ++++++++++++++++++++++++------
>  drivers/gpio/gpiolib.c      |  4 ++--
>  drivers/gpio/gpiolib.h      |  3 ++-
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 16a7b68..9f83fc6 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -418,9 +418,11 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
>  		 * GpioIo is used then the only way to set the flag is
>  		 * to use _DSD "gpios" property.
>  		 */
> -		if (lookup->info.gpioint)
> -			lookup->info.active_low =
> -				agpio->polarity == ACPI_ACTIVE_LOW;
> +		if (lookup->info.gpioint) {
> +			lookup->info.polarity = agpio->polarity;

Since you are passing ACPI_ACTIVE_LOW/HIGH/BOTH here and then later on
compare that to GPIO_ACTIVE_LOW you should either put comment here
explaining that we expect the two to be equal, or alternatively convert
ACPI flags here to the corresponding Linux ones.

> +			lookup->info.triggering = agpio->triggering;
> +		}
> +
>  	}
>  
>  	return 1;
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
