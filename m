From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 3/3] ACPI / spi: attach gpio irq from acpi description
 to spi device
Date: Tue, 8 Dec 2015 13:35:23 +0200
Message-ID: <20151208113523.GK1766@lahna.fi.intel.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
 <1449527952-8399-4-git-send-email-christophe-h.ricard@st.com>
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
In-Reply-To: <1449527952-8399-4-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 07, 2015 at 11:39:12PM +0100, Christophe Ricard wrote:
> spi->irq was ignoring GpioInt property setting it to -1.
> acpi_dev_gpio_irq_get returns and configure the slave irq  according to
> the acpi slave node description.
> It is now inline with devicetree behavior.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> ---
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index a5f53de..5c10815 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1534,7 +1534,7 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
>  	}
>  
>  	ACPI_COMPANION_SET(&spi->dev, adev);
> -	spi->irq = -1;
> +	spi->irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&spi->dev), 0);

You can use "adev" here instead of ACPI_COMPANION(&spi->dev).

>  
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_resources(adev, &resource_list,
> -- 
> 2.1.4
