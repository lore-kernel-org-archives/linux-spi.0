From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for DT boards
Date: Thu, 14 Jun 2012 08:12:34 +0000
Message-ID: <201206140812.34399.arnd@arndb.de>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339324322-29388-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sunday 10 June 2012, Andrew Lunn wrote:
> +static int __init kirkwood_add_irq_domain(struct device_node *np,
> +                                         struct device_node *interrupt_parent)
> +{
> +       kirkwood_init_irq();
> +       irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> +       return 0;
> +}
> +
> +static const struct of_device_id kirkwood_irq_match[] = {
> +       { .compatible = "marvell,orion-intc",
> +         .data = kirkwood_add_irq_domain, },
> +       {},
> +};
> +
> +static void __init kirkwood_dt_init_irq(void)
> +{
> +       of_irq_init(kirkwood_irq_match);
> +}
> +

I think if you compute the number of interrupts in the domain from the number of
registers that are described in the device tree, call orion_irq_init()
based on those registers, and use irq domains for the gpio stuff as Rob suggested,
this init_irq function can become completely generic to all orion platforms.

That is what I tried to do with an earlier patch, which was flawed for other reasons.

	Arnd
