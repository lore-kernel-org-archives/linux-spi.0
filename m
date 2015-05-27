From: Vladimir Toutain <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Subject: ADS1256 SPI driver for Raspberry Pi
Date: Wed, 27 May 2015 13:28:57 +0200 (CEST)
Message-ID: <2048982407.1157847.1432726137134.JavaMail.zimbra@pi.esisar.grenoble-inp.fr>
References: <842050876.1117879.1432710132839.JavaMail.zimbra@pi.esisar.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <842050876.1117879.1432710132839.JavaMail.zimbra-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hello,



I am currently working on a project for which I need to develop an SPI =
driver for the first time.
This work involves an ADS1256 ADC. This ADC will send its data via SPI =
to a Raspberry PI 2 running on ArchLinux. In order to drive the ADS1256=
 I will have two interrupt sources on two seperate GPIOs of the RPi.=20
The gathered data from the ADC will then be displayed on a /dev to be p=
rocessed later.


Since I need the best precision/speed I want to develop a kernel space =
SPI driver.


SPI drivers for RPi are located in this github: https://github.com/rasp=
berrypi/linux/tree/rpi-3.18.y/drivers/spi.
When one wants to use SPI he usually inserts spidev and spi-bcm2708 mod=
ules so he can interact with them in user space.
=46rom what I understand, spi-bcm2708 is a controller driver and spidev=
 a generic protocol driver that offers ioctl's.


Since I need to control and dialog with the ADC I guess I need to devel=
op a protocol driver for the ADS1256 that will interact with a controll=
er driver.


However I cannot determine how my driver interacts with this later: the=
 spi-bcm2708 does not offer things like EXPORT_SYMBOL().=20
I know linux/{spi.c spi.h} offers an API but then I'd loose the benefit=
s of using spi-bcm2708 (GPIO and registers setup etc).

So here is my problem: I am not sure wether my SPI driver must be a pro=
tocol or a controller driver, nor how it interacts with other Linux SPI=
 components.

I have read things like https://www.kernel.org/doc/Documentation/spi/sp=
i-summary, http://stackoverflow.com/questions/22632713/how-to-write-a-s=
imple-device-driver-in-linux and tried to learn a bit from http://lxr.f=
ree-electrons.com/source/drivers/spi/spi-omap2-mcspi.c and of course a =
lot other sources.


Any help would be much appreciated !




Sincerely,

Vladimir TOUTAIN=20

Mail: vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org=20

Promotion 2016 d=C3=A9partement IR=20
Grenoble INP - Esisar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
