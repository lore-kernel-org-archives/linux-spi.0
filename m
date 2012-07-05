From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 15:08:19 +0200
Message-ID: <20120705130819.GV17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <201207051225.55390.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207051225.55390.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > +Required properties
> > +- compatible :  Should be "marvell,orion-intc".
> > +- #interrupt-cells: Specifies the number of cells needed to encode an
> > +  interrupt source. Supported value is <1>.
> > +- interrupt-controller : Declare this node to be an interrupt controller.
> > +- reg : Interrupt mask address.
> 
> I think you should clarify that the "reg" property can be multiple
> 4-byte ranges, because that is fairly unusual.

O.K. The example is already like this, but i can add some more words.

> > +#ifdef CONFIG_OF
> > +static int __init orion_add_irq_domain(struct device_node *np,
> > +				       struct device_node *interrupt_parent)
> > +{
> > +	int i = 0, irq_gpio;
> > +	void __iomem *base;
> > +
> > +	do {
> > +		base = of_iomap(np, i);
> > +		if (base) {
> > +			orion_irq_init(i * 32, base);
> > +			i++;
> > +		}
> > +	} while (base);
> > +
> > +	irq_domain_add_legacy(np, i * 32, 0, 0,
> > +			      &irq_domain_simple_ops, NULL);
> > +
> > +	irq_gpio = i * 32;
> > +	orion_gpio_of_init(irq_gpio);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id orion_irq_match[] = {
> > +	{ .compatible = "marvell,orion-intc",
> > +	  .data = orion_add_irq_domain, },
> > +	{},
> > +};
> > +
> > +void __init orion_dt_init_irq(void)
> > +{
> > +	of_irq_init(orion_irq_match);
> > +}
> > +#endif
> 
> I'm wondering about this one.  The other platforms usually put the secondary
> interrupt controllers into the same match table, while you call orion_gpio_of_init
> from orion_add_irq_domain. Can you explain why you do this? Does it have
> any disadvantages?

The issue is knowing what IRQ number to use for the secondary
interrupts.

Orion use generic chip interrupts, both for the main interrupts and
the GPIO interrupts. This does not yet support irq domain, so i have
to layer a legacy domain on top. The legacy domain needs to know the
first IRQ and the number of IRQs. For the primary IRQs that is
easy. However, GPIO IRQ is not so easy, it depends on how many primary
IRQs there are. This is not fixed. Orion5x has 32, Dove 64, kirkwood,
64, and mv78xx0 has 96. I need to know this number when adding the
GPIO secondary IRQ legacy domain. By calling orion_gpio_of_init() in
the orion_add_irq_domain() i have this number to hand. If i used to
entries in the match table, i would have to put this number into some
global variable, or somehow ask the IRQ subsystem what the next free
IRQ number is.

As for disadvantages, humm. Dove has yet more interrupts, from the
PMU. They are currently unsupported in DT. When we add support for the
PMU interrupt controller, we are going to have the same problem, what
IRQ base should it use. Either we extend the chaining, calling
dove_pmu_of_init from orion_gpio_of_init(), where we know the next
free IRQ. Or we find out how to ask the IRQ subsystem for the next
available. Better still, the work to make generic chip interrupts irq
domain aware would get completed, and we can swap all this code to irq
domain linear and this whole probable probably goes away.

    Andrew
