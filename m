From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Thu, 24 Mar 2016 17:48:23 +0100
Message-ID: <30176583.aSTyzO0qS3@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de> <3250653.vvT0RgK8yg@wuerfel> <56F412B5.2080200@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F412B5.2080200-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
> >
> >       soc@ {
> >               spi0 {
> >                         compatible = "marvell,armada-370-spi",
> >                                      "marvell,orion-spi";
> >                       reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
> >                             <MBUS_ID(0x01, 0x5e) 0 0x100000>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         pinctrl-0 = <&spi0_pins1>;
> >                         pinctrl-names = "default";
> >                         cell-index = <0>;
> >                         interrupts = <30>;
> >                         clocks = <&coreclk 0>;
> >                         status = "disabled";
> >               };
> >       };
> 
> Do I understand this correctly, that you suggest to list all MBus
> windows here, that the SoC supports (e.g. 8 for the Armada XP).
> And let the SPI driver then extract and dynamically enable (map)
> the one that is currently used?

Actually the syntax above doesn't imply any mapping at all, it
just describes how the hardware is wired up, so that really
needs to list all windows, and then the ranges property in the
soc node can statically map the ones that are used on the
particular machine.

> We also need a per-SPI-device DT property to enable this direct
> access mode for this specific SPI device. As not all SPI devices
> support this mode - at least not yet. How about this one:
> 
>                 flash0: flash@0 {
>                         compatible = "m25p128";
>                         reg = <0>;
>                         direct-access-enable;
>                         ...
>                 };
> 
> ?

Maybe the spi driver can just check whether the window is mapped
or not, and then have no ranges entry for the devices that don't
support it?

Alternatively, we might encode this in the 'reg' property in
some way?

How do we know whether a device supports the mode or not?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
