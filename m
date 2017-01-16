From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 3/3] spi: pca2xx-pci: Allow MSI
Date: Mon, 16 Jan 2017 21:08:38 +0200
Message-ID: <1484593718.2133.156.camel@linux.intel.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
         <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Sascha Weisenberger <sascha.weisenberger-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
To: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2017-01-16 at 19:44 +0100, Jan Kiszka wrote:
> Now that the core is ready for edge-triggered interrupts, we can
> safely
> allow the PCI versions that provide this to enable the feature and,
> thus, have less shared interrupts.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>



> drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-
> pci.c
> index 58d2d48..58dcadb 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -203,10 +203,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev
> *dev,
>  	ssp = &spi_pdata.ssp;
>  	ssp->phys_base = pci_resource_start(dev, 0);
>  	ssp->mmio_base = pcim_iomap_table(dev)[0];
> -	ssp->irq = dev->irq;
>  	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
>  	ssp->type = c->type;
>  
> +	pci_set_master(dev);
> +
> +	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0)
> +		return ret;

+ perhaps an empty line?

> +	ssp->irq = pci_irq_vector(dev, 0);
> +
>  	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
>  	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
 					   c->max_clk_rate);

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
