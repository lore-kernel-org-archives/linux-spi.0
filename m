From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
Date: Thu, 10 Apr 2014 15:25:11 +0800
Message-ID: <20140410072509.GA24100@localhost>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
 <20140409213749.GH32070@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russel King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140409213749.GH32070@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 02:37:49PM -0700, Brian Norris wrote:
> >  config MTD_M25P80
> >  	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
> > -	depends on SPI_MASTER
> > +	depends on SPI_MASTER && MTD_SPI_NOR_BASE
> >  	help
> >  	  This enables access to most modern SPI flash chips, used for
> >  	  program and data storage.   Series supported include Atmel AT26DF,
> 
> Now that M25P80 depends on MTD_SPI_NOR_BASE (which I proposed to rename
> to MTD_SPI_NOR a few hours ago), shouldn't we be updating everybody's
> defconfigs? As it stands, the defconfigs that use M25P80 will just drop
> it silently when built.
> 
> And if so, I'm not sure how this should be handled. Should defconfig
> patches be sent to their respective arch maintainers?

IMHO, we should create a patch or several patches to add the MTD_SPI_NOR
to the defconfigs.

Another method is to select the MTD_SPI_NOR which we enable the MTD.

> 
> Also, I think m25p80.c is no longer a "self-contained MTD device driver"
> and should be moved under drivers/mtd/spi-nor/.
If we move the m25p80.c to the drivers/mtd/spi-nor/, we also need to move
other drivers too.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
