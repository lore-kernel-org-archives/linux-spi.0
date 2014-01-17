From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Fri, 17 Jan 2014 14:54:03 +0800
Message-ID: <20140117065401.GA6140@shlinux2.ap.freescale.net>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
> >> My basic question is like I have a qspi spi controller in my SOC and I
> >> designed two boards B1 and B2
> >
> > okay.
> >
> >> B1 with quad spi controller connected with non-flash as a slave and B2
> >> with quad spi controller connected
> >> with quad flash as a slave.
> > You can use the framework for B2. But for B1, you should not use the framework,
> > since this framework is just for the SPI-NOR. If you do not connected with
> > a NOR, i think it's better to code another driver for your controller.
> 
> Means we have two separate controller drivers for same controller one
> with spi-nor and
> another with spi is it?
Take drivers/spi/spi-imx.c for example, if you connect a NOR to it, you only
need to add a NOR device node in the device tree. In the probe, it will call
the m25p80.c to probe the NOR device.

But if we connect other device to it. you should set another device node for it.

I am not sure if your controller driver can works as the spi-imx.c

thanks
Huang Shijie



 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
