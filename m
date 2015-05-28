From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: ADS1256 SPI driver for Raspberry Pi
Date: Thu, 28 May 2015 16:54:08 +0200
Message-ID: <7D8C4A31-635D-4CD9-A259-95281EB97938@martin.sperl.org>
References: <842050876.1117879.1432710132839.JavaMail.zimbra@pi.esisar.grenoble-inp.fr> <2048982407.1157847.1432726137134.JavaMail.zimbra@pi.esisar.grenoble-inp.fr> <1063EE3D-0A13-4EFB-B793-A7E8CD4B2879@martin.sperl.org> <162943485.1254958.1432814369978.JavaMail.zimbra@pi.esisar.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Toutain <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <162943485.1254958.1432814369978.JavaMail.zimbra-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 28.05.2015, at 13:59, Vladimir Toutain <vladimir.toutain-fH1jEIC6FHQGxqi+iOZjkhREYkPMEsUiUBSOeVevoDU@public.gmane.org> wrote:
>    I found this driver https://github.com/raspberrypi/linux/blob/rpi-3.18.y/drivers/iio/adc/ti-adc128s052.c and then tried to find the corresponding DT overlay without success.
The foundation has NOT created an overlay for avery possible device - if you need
a overlay for a specific device you need to create it yourself and (optionally)
ask the foundation to merge it (but they will only do that when the driver of
yours is merged).

>    . Is it then loaded just like a module? How does the subsystem know which GPIO pins are used by this driver?
These would be configured inside the device tree - please read a bit 
about device-trees for that, but there are some standards
for interrupts and gpios.

>    . Is it correct to use
>           line 37     "ret = spi_write(adc->spi, &adc->buffer, 2);"
>      to send commands to the ADC by filling adc->buffer with these commands?
yes - more info can be found at: Documentation/spi/spi-summary 
Most it is related to master, but there is a tiny section talking about
spi_async, spi_sync, spi_read, spi_write and spi_write_then_read.

Also look at include/linux/spi/spi.h for a bit more documentation
on what each of those functions does.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
