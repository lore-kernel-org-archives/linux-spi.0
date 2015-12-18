From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 3/3] ACPI / spi: attach gpio irq from acpi description
 to spi device
Date: Fri, 18 Dec 2015 11:17:45 +0200
Message-ID: <20151218091745.GE1762@lahna.fi.intel.com>
References: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
 <1450163493-4938-4-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Christophe Ricard <christophe.ricard@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450163493-4938-4-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 15, 2015 at 08:11:33AM +0100, Christophe Ricard wrote:
> spi->irq was ignoring GpioInt property setting it to -1.
> acpi_dev_gpio_irq_get returns and configure the slave irq according to
> the acpi slave node description.
> It is now inline with devicetree behavior.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> ---
>  drivers/spi/spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 2b0a8ec..6e5d1f7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1583,6 +1583,8 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  
>  		if (acpi_dev_resource_interrupt(ares, 0, &r))
>  			spi->irq = r.start;
> +		else
> +			spi->irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&spi->dev), 0);

This still does not work as expected if the device has other resources
in _CRS.

Instead of this, you should do something like below which only uses GPIO
when we are sure no Interrupt() resource was found.

acpi_spi_add_device()
{
	...
	acpi_dev_get_resources()
	...

	if (spi->irq < 0)
		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
