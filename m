From: Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
Date: Thu, 05 Jul 2012 16:14:50 +0200
Message-ID: <4FF5A15A.8070309@googlemail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch> <1341325365-21393-2-git-send-email-andrew@lunn.ch> <201207051225.55390.arnd@arndb.de> <20120705130819.GV17534@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705130819.GV17534-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/05/2012 03:08 PM, Andrew Lunn wrote:
> The issue is knowing what IRQ number to use for the secondary
> interrupts.
>
> Orion use generic chip interrupts, both for the main interrupts and
> the GPIO interrupts. This does not yet support irq domain, so i have
> to layer a legacy domain on top. The legacy domain needs to know the
> first IRQ and the number of IRQs. For the primary IRQs that is
> easy. However, GPIO IRQ is not so easy, it depends on how many primary
> IRQs there are. This is not fixed. Orion5x has 32, Dove 64, kirkwood,
> 64, and mv78xx0 has 96. I need to know this number when adding the
> GPIO secondary IRQ legacy domain. By calling orion_gpio_of_init() in
> the orion_add_irq_domain() i have this number to hand. If i used to
> entries in the match table, i would have to put this number into some
> global variable, or somehow ask the IRQ subsystem what the next free
> IRQ number is.

Andrew,

is it possible to group all gpio banks into one DT description?
For mach-dove it could be something like:

gpio: gpio-controller {
	compatible = "marvell, orion-gpio";
	...

	bank0@d0400 {
		reg = <0xd0400 0x40>;
		ngpio = <8>;
		mask-offset = <0>;
		interrupts = <12>;
	};

	bank1@d0400 {
		reg = <0xd0400 0x40>;
		ngpio = <8>;
		mask-offset = <8>;
		interrupts = <13>;
	};

	...

	bank4@d0420 {
		reg = <0xd0420 0x40>;
		ngpio = <32>;
		interrupts = <61>;
	};		

	bank5@e8400 {
		reg = <0xe8400 0x20>;
		ngpio = <8>;
		marvell,orion-gpio-output-only;
	};		
};

This would have the advantage that DT describes gpio-to-irq dependencies.
Moreover, nodes that reference gpios can do gpios = <&gpio 71 0>; instead of
gpios = <&gpio3 7 0>;

Sebastian
