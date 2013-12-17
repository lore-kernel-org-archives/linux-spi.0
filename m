From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 1/7] mtd: spi-nor: copy the SPI NOR commands to a new header file
Date: Tue, 17 Dec 2013 14:01:56 +0100
Message-ID: <201312171401.56683.marex@denx.de>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com> <1387184330-14448-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	angus.clark-qxv4g6HH51o@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org,
	sourav.poddar-l0cyMroinI0@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387184330-14448-2-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, December 16, 2013 at 09:58:44 AM, Huang Shijie wrote:
> This patch adds a new header :spi-nor.h,
> and copies all the SPI NOR commands and relative macros into this new
> header.
> 
> This hearder can be used by the m25p80.c and other spi-nor controller,
> such as Freescale's Quadspi.
> 
> Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

It would be much nicer if you also removed the commands in this same patch from 
the m25p80.c file.

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
