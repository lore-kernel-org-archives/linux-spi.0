From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
Date: Thu, 5 Jul 2012 12:25:55 +0000
Message-ID: <201207051225.55390.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch> <1341325365-21393-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341325365-21393-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 03 July 2012, Andrew Lunn wrote:
> Both IRQ and GPIO controllers can now be represented in DT.  The IRQ
> controllers are setup first, and then the GPIO controllers. Interrupts
> for GPIO lines are placed directly after the main interrupts in the
> interrupt space.

Overall looks very good.

> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> index 80b9a94..8927e10 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -38,3 +38,22 @@ Example:
>  		reg-names = "mux status", "mux mask";
>  		mrvl,intc-nr-irqs = <2>;
>  	};
> +
> +* Marvell Orion Interrupt controller
> +
> +Required properties
> +- compatible :  Should be "marvell,orion-intc".
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. Supported value is <1>.
> +- interrupt-controller : Declare this node to be an interrupt controller.
> +- reg : Interrupt mask address.

I think you should clarify that the "reg" property can be multiple
4-byte ranges, because that is fairly unusual.

> +#ifdef CONFIG_OF
> +static int __init orion_add_irq_domain(struct device_node *np,
> +				       struct device_node *interrupt_parent)
> +{
> +	int i = 0, irq_gpio;
> +	void __iomem *base;
> +
> +	do {
> +		base = of_iomap(np, i);
> +		if (base) {
> +			orion_irq_init(i * 32, base);
> +			i++;
> +		}
> +	} while (base);
> +
> +	irq_domain_add_legacy(np, i * 32, 0, 0,
> +			      &irq_domain_simple_ops, NULL);
> +
> +	irq_gpio = i * 32;
> +	orion_gpio_of_init(irq_gpio);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id orion_irq_match[] = {
> +	{ .compatible = "marvell,orion-intc",
> +	  .data = orion_add_irq_domain, },
> +	{},
> +};
> +
> +void __init orion_dt_init_irq(void)
> +{
> +	of_irq_init(orion_irq_match);
> +}
> +#endif

I'm wondering about this one.  The other platforms usually put the secondary
interrupt controllers into the same match table, while you call orion_gpio_of_init
from orion_add_irq_domain. Can you explain why you do this? Does it have
any disadvantages?

	Arnd
