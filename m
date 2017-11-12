From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
Date: Sun, 12 Nov 2017 14:13:49 +0000
Message-ID: <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, 12 Nov 2017 13:32:44 +0100
<kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:

Martin,

> Hi!
> 
> During the development of a new spi driver on a raspberry pi CM1
> I have seen an issue with the following code triggering strange behavior:
> 
> 	ret = request_threaded_irq(spi->irq, NULL,
> 				   mcp2517fd_can_ist,
> 				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> 				   DEVICE_NAME, priv);
> 
> This works fine the first time the module is loaded (spi->irq is not 0),
> but as soon as the module gets removed and reinstalled spi->irq is 0 
> and I get the message in dmesg:
> [ 1282.311991] irq: type mismatch, failed to map hwirq-16 for /soc/gpio@7e200000!
> 
> This does not happen when using the IRQF_TRIGGER_FALLING flag.
> 
> in spi_drv_probe spi core does sets spi->dev to 0 in case 
> of_irq_get returns < 0;
> 
> The specific code that triggers this message and return 0 is 
> irq_create_fwspec_mapping.
> 
> After implementing: https://www.spinics.net/lists/arm-kernel/msg528469.html
> and also checking for spi->irq == 0, I get:
> 
> [   87.867456] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio@7e200000!

Well, you have the answer here: The interrupt has been configured with
a falling edge trigger, while you're requesting a level low. Obviously,
something is changing it.

It would be interesting to see both the driver code and the DT file
where the interrupt is described...

> [   87.867512] mcp2517fd spi0.0: no valid irq line defined: irq = 0
> 
> The test for irq == 0 is the first thing that happens in the 
> spi.driver.probe code of the module.
> 
> So to me it looks as if something deeper down the stack during
> initialization.
> 
> As if the irq-type is not cleaned up during release of the irq on module
> unload - which I can confirm calls free_irq(spi->irq, priv).

I don't really understand this remark. The trigger type is a property
of the generating device, so "cleaning up" doesn't make much sense
(even if you;re not using the interrupt anymore, the device is still
there).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
