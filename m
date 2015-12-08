From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/3] ACPI / gpio: Add irq_type when a gpio is used as
 an interrupt
Date: Tue, 8 Dec 2015 13:33:11 +0200
Message-ID: <20151208113311.GJ1766@lahna.fi.intel.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
 <1449527952-8399-3-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Christophe Ricard <christophe.ricard@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449527952-8399-3-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 07, 2015 at 11:39:11PM +0100, Christophe Ricard wrote:
> When a gpio is used as an interrupt in acpi, the irq_type was not
> available for device driver.
> 
> Make it available in acpi_find_gpio with a new acpi_gpio_info field
> (irq_type) and setthe irq_type if necessary in acpi_dev_gpio_irq_get.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 22 ++++++++++++++++++----
>  drivers/gpio/gpiolib.h      |  1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index bbcac3a..4b893c8 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -416,9 +416,12 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
>  		 * GpioIo is used then the only way to set the flag is
>  		 * to use _DSD "gpios" property.
>  		 */
> -		if (lookup->info.gpioint)
> +		if (lookup->info.gpioint) {
>  			lookup->info.active_low =
>  				agpio->polarity == ACPI_ACTIVE_LOW;

Since we have irq_type (I prefer irq_flags) we can get rid of active_low
above. That information is already in the irq_type field.

> +			lookup->info.irq_type = acpi_get_irq_type(agpio->triggering,
> +								  agpio->polarity);
> +		}
>  	}
>  
>  	return 1;
> @@ -529,7 +532,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>   */
>  int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  {
> -	int idx, i;
> +	int idx, i, irq;
>  
>  	for (i = 0, idx = 0; idx <= index; i++) {
>  		struct acpi_gpio_info info;
> @@ -538,8 +541,19 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
>  		if (IS_ERR(desc))
>  			break;
> -		if (info.gpioint && idx++ == index)
> -			return gpiod_to_irq(desc);
> +		if (info.gpioint && idx++ == index) {

Why not declare irq here?

			int irq = gpiod_to_irq(desc);

> +			irq = gpiod_to_irq(desc);
> +			if (irq < 0) {
> +				dev_err(&adev->dev,
> +					"Failed to translate GPIO to IRQ\n");

Is it really necessary to print this error?

> +				return irq;
> +			}
> +			/* Set type if specified and different than the current one */
> +			if (info.irq_type != IRQ_TYPE_NONE &&
> +			    info.irq_type != irq_get_trigger_type(irq))
> +				irq_set_irq_type(irq, info.irq_type);
> +			return irq;
> +		}
>  	}
>  	return -ENOENT;
>  }
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 78e634d..624fbc4 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -27,6 +27,7 @@ struct acpi_device;
>  struct acpi_gpio_info {
>  	bool gpioint;
>  	bool active_low;
> +	int irq_type;

Use unsigned long here.

>  };
>  
>  /* gpio suffixes used for ACPI and device tree lookup */
> -- 
> 2.1.4
