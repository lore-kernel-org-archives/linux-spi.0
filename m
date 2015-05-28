From: Vladimir Toutain <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Subject: Re: ADS1256 SPI driver for Raspberry Pi
Date: Thu, 28 May 2015 13:59:29 +0200 (CEST)
Message-ID: <162943485.1254958.1432814369978.JavaMail.zimbra@pi.esisar.grenoble-inp.fr>
References: <842050876.1117879.1432710132839.JavaMail.zimbra@pi.esisar.grenoble-inp.fr> <2048982407.1157847.1432726137134.JavaMail.zimbra@pi.esisar.grenoble-inp.fr> <1063EE3D-0A13-4EFB-B793-A7E8CD4B2879@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1063EE3D-0A13-4EFB-B793-A7E8CD4B2879-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Thank you for your quick answer.

IIO drivers look like what I need to develop.=20

However I still have some questions:

    I found this driver https://github.com/raspberrypi/linux/blob/rpi-3=
=2E18.y/drivers/iio/adc/ti-adc128s052.c and then tried to find the corr=
esponding DT overlay without success.
    . Is it then loaded just like a module? How does the subsystem know=
 which GPIO pins are used by this driver?
    . Is it correct to use
           line 37     "ret =3D spi_write(adc->spi, &adc->buffer, 2);"
      to send commands to the ADC by filling adc->buffer with these com=
mands?

Thanks,


Vladimir TOUTAIN=20

Promotion 2016 d=C3=A9partement IR=20
Grenoble INP - Esisar

----- Mail original -----
De: "Martin Sperl" <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
=C3=80: "Vladimir Toutain" <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Envoy=C3=A9: Mercredi 27 Mai 2015 15:02:36
Objet: Re: ADS1256 SPI driver for Raspberry Pi

> Any help would be much appreciated !

You would probably want to look at the drivers in drivers/iio/adc=20
(and the staging drivers in drivers/staging/iio/adc)
and take one as an example for your development - maybe on is even
sufficiently compatible to your ADS1256, so that you only need to
extend the compatibility list.

To activate it instead of the default spi-dev create a device-overlay
similar to this one:
https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/boot/dts/=
ads7846-overlay.dts
compile it and reference it in /boot/config.txt
(here some more info on the overlays: https://www.raspberrypi.org/docum=
entation/configuration/device-tree.md)

As for how to use those drivers from user-space here an introduction
to the iio framework (kernel and user-space):
https://archive.fosdem.org/2012/schedule/event/693/127_iio-a-new-subsys=
tem.pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
