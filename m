From: Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
Date: Thu, 05 Jul 2012 17:51:21 +0200
Message-ID: <4FF5B7F9.9020507@googlemail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch> <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com> <201207051454.24475.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207051454.24475.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/05/2012 04:54 PM, Arnd Bergmann wrote:
> This way you have multiple nodes with the same register
> and different names, which is not how it normally works.

Ok.

>> This would have the advantage that DT describes gpio-to-irq dependencies.
>> Moreover, nodes that reference gpios can do gpios =<&gpio 71 0>; instead of
>> gpios =<&gpio3 7 0>;
>
> Is that desired?
>
> The device tree representation should match what is in the data sheet
> normally. If they are in a single continuous number range, then we should
> probably have a single device node with multiple register ranges
> rather than one device node for each 32-bit register. Looking at
> arch/arm/plat-orion/gpio.c I think that is not actually the case though
> and having separate banks is more logical.

Well, looking at the datasheet of Dove GPIOs are numbered [63:0] plus
GPOs [71:64]. This dt will be a lot shorter and maybe it is describing
the hardware as it is. (Not sure about the syntax for irqs, though)

gpio@d0400 {
	compatible = "marvell,orion-gpio";
	gpio-controller;
	reg = <0xd0400 0x20>, /* GPIO[31: 0] */
	      <0xd0420 0x20>, /* GPIO[63:32] */
	      <0xe8400 0x0c>; /* GPO [71:64] */
	ngpio = <72>;
	interrupts = <12 13 14 15>, <61>;
};

Sebastian
