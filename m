From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 5 Dec 2013 15:12:25 +0800
Message-ID: <20131205071224.GA8936@shlinux2.ap.freescale.net>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com>
 <1386082273.18201.61.camel@shinybook.infradead.org>
 <20131204184405.GE9468@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131204184405.GE9468-bU/DPfM3abD4WzifrMjOTkcViWtcw2C0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 04, 2013 at 10:44:05AM -0800, Brian Norris wrote:
> 
> I mostly bring this up, though, because it is an example of hardware
> that
> 
>    (a) can operate as a true SPI device (hardware (1) can handle generic
>        SPI transfers), but
>    (b) requires knowledge of the details of SPI flash in order to get
>        optimal usage out of the acceleration from (2).
> 
> In my book, point (a) and (b) hold some bearing over the question of
> "where should this SPI NOR framework live", because it is reasonable
> that a single driver for this hardware should be able to handle either
> true SPI devices or accelerated SPI-NOR flash.

We have add a @read_id hook for the spi-nor layer, you can use it to read out
more info (such as the Device Geometry Definition) for your spi-nor controller driver.

Is it okay?

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
