From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 18:16:00 +0200
Message-ID: <20120705161600.GA28860@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch>
 <4FF5A15A.8070309@googlemail.com>
 <201207051454.24475.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207051454.24475.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> Something completely different I just noticed in the original patch:
> 
> > @@ -90,6 +74,27 @@ static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
> >       }
> >  }
> >  
> > +static int __initdata gpio0_irqs[4] = {
> > +     IRQ_DOVE_GPIO_0_7,
> > +     IRQ_DOVE_GPIO_8_15,
> > +     IRQ_DOVE_GPIO_16_23,
> > +     IRQ_DOVE_GPIO_24_31,
> > +};
> > +
> > +static int __initdata gpio1_irqs[4] = {
> > +     IRQ_DOVE_HIGH_GPIO,
> > +     0,
> > +     0,
> > +     0,
> > +};
> 
> I think the latter one needs to be
> 
> +static int __initdata gpio1_irqs[4] = {
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +};
> 
> so we register all four parts to the same primary IRQ. The
> same is true for the devicetree representation.

Nope, does not work like that.

It does not matter which IRQ of a GPIO chip fires. It looks at the IRQ
cause bits for all lines and fires off the secondary ISR as needed for
the whole chip. So in effect, there is a mapping IRQ->GPIO chip, not
IRQ->1/4 of GPIO chip. With what you suggest above, you would end up
with four chained interrupt handlers, all being handled by the same
interrupt handler for one chio, and the last three in the chain would
never do anything since the first one does all the work.

	  Andrew
