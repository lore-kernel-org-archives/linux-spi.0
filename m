From: =?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Thu, 18 Jun 2015 12:19:04 +0200
Message-ID: <55829B18.4030609@tronnes.org>
References: <5582933E.1050500@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5582933E.1050500-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Den 18.06.2015 11:45, skrev Martin Sperl:
> Quick question: for the auxiliar spi1 and spi2 of the BCM2835 chipset
> should I create a separate driver - say spi-bcm2835aux.c - or incorporate
> it into the exising spi-bcm2835.c driver.
>
> Note that the register set for the auxiliar spi devices is totally 
> different
> so any code-overlap with the existing spi-bcm2835.c would be minimal.
>

There is also an aux mini uart that shares interrupt with spi1/2.
The AUXIRQ register determines the interrupt source. How should this
sharing be done? This uart is really only useful on the Compute Module
since it's pins overlap the pl011 uart pins on the other boards.
This is how the mini uart is used/setup downstream:
https://github.com/raspberrypi/linux/pull/1008

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
