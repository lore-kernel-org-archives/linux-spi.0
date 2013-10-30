From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add Intel Mid SSP driver
Date: Tue, 29 Oct 2013 18:42:19 -0700
Message-ID: <527063FB.7070400@infradead.org>
References: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ning.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fei Yang <fei.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383069950-27754-1-git-send-email-david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/29/13 11:05, David Cohen wrote:

a few more comments:

> +static unsigned int ssp_get_clk_div(int speed)
> +{
> +	return max(100000000 / speed, 4) - 1;

Divide uses library call?  I dunno...
Bad if so.  Would need to use some function from
#include <asm-generic/div64.h>

> +}

> +/**
> + * setup() - Driver setup procedure
> + * @spi:	Pointeur to the spi_device struct

		Pointer

> + */
> +static int setup(struct spi_device *spi)
> +{
> +}
> +/**
> + * ssp_spi_probe() - Driver probe procedure
> + * @pdev:	Pointer to the pci_dev struct
> + * @ent:	Pointer to the pci_device_id struct
> + */
> +static int ssp_spi_probe(struct pci_dev *pdev,
> +	const struct pci_device_id *ent)
> +{
> +	/* Set platform & configuration quirks */
> +	if (sspc->quirks & QUIRKS_PLATFORM_MRST) {
> +		/* Apply bit banging workarround on MRST */

		                     workaround

> +		sspc->quirks |= QUIRKS_BIT_BANGING;
> +		/* MRST slave mode workarrounds */

		                   workarounds

> +		if (ssp_cfg_is_spi_slave(ssp_cfg))
> +			sspc->quirks |= QUIRKS_USE_PM_QOS |
> +					QUIRKS_SRAM_ADDITIONAL_CPY;
> +	}
> +	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
> +		ssp_timing_wr = 1;
> +
> +	if (status < 0) {
> +		dev_err(&pdev->dev, "can not get IRQ\n");

		                     cannot

> +		goto err_free_4;
> +	}
> +
> +}

> +MODULE_AUTHOR("Ken Mills");
> +MODULE_DESCRIPTION("Bulverde SSP core SPI contoller");

                                             controller

> +MODULE_LICENSE("GPL");


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
