From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: ADS1256 SPI driver for Raspberry Pi
Date: Wed, 27 May 2015 15:02:36 +0200
Message-ID: <1063EE3D-0A13-4EFB-B793-A7E8CD4B2879@martin.sperl.org>
References: <842050876.1117879.1432710132839.JavaMail.zimbra@pi.esisar.grenoble-inp.fr> <2048982407.1157847.1432726137134.JavaMail.zimbra@pi.esisar.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Toutain <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2048982407.1157847.1432726137134.JavaMail.zimbra-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> Any help would be much appreciated !

You would probably want to look at the drivers in drivers/iio/adc 
(and the staging drivers in drivers/staging/iio/adc)
and take one as an example for your development - maybe on is even
sufficiently compatible to your ADS1256, so that you only need to
extend the compatibility list.

To activate it instead of the default spi-dev create a device-overlay
similar to this one:
https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/boot/dts/ads7846-overlay.dts
compile it and reference it in /boot/config.txt
(here some more info on the overlays: https://www.raspberrypi.org/documentation/configuration/device-tree.md)

As for how to use those drivers from user-space here an introduction
to the iio framework (kernel and user-space):
https://archive.fosdem.org/2012/schedule/event/693/127_iio-a-new-subsystem.pdf


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
