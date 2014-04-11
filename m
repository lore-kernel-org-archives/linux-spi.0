From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
Date: Fri, 11 Apr 2014 08:32:05 +0800
Message-ID: <20140411003203.GC3837@localhost.localdomain>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
 <20140409213749.GH32070@ld-irv-0074>
 <20140410072509.GA24100@localhost>
 <20140410192902.GM32070@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, angus.clark-qxv4g6HH51o@public.gmane.org,
	Russel King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140410192902.GM32070@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Apr 10, 2014 at 12:29:02PM -0700, Brian Norris wrote:
> > IMHO, we should create a patch or several patches to add the MTD_SPI_NOR
> > to the defconfigs.
> 
> Yeah, I think that's best.
I will create a patch when i back to office.
Or you can create it yourself.

> 
> > > Also, I think m25p80.c is no longer a "self-contained MTD device driver"
> > > and should be moved under drivers/mtd/spi-nor/.
> > If we move the m25p80.c to the drivers/mtd/spi-nor/, we also need to move
> > other drivers too.
> 
> Which ones? I think it only makes sense to move those that depend on the
> same core code (i.e., spi-nor.c), or have a close relation to it (so
> Lee's st_spi_fsm.c is a candidate).

yes, i mean the st_spi_fsm.c and other drivers which will use the
spi-nor core code in the future.

thanks
Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
