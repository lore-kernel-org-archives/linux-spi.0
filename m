From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/8] mtd: spi-nor: add a new framework for SPI NOR
Date: Wed, 12 Mar 2014 23:39:40 -0700
Message-ID: <20140313063940.GU31517@norris-Latitude-E6410>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <20140312081350.GC30808@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, angus.clark-qxv4g6HH51o@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140312081350.GC30808-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 04:13:51PM +0800, Huang Shijie wrote:
> On Mon, Feb 24, 2014 at 06:37:34PM +0800, Huang Shijie wrote:
>    Could you please review this patch set? I really hope it can be merged
>    as soon as possibel.  But now, the patch set has stalled for a long time.

I'm sorry for the delay. Others are in the same position of delay (e.g.,
Lee's SPI-NOR driver), because I simply have not had the time to really
devote this the attention it deserves, especially considering how it
rearchitects such an important, commonly-used driver.

Nonetheless, I will try to give your patches some more attention soon.

>    Since you have pushed the patches for m25p80.c, i have to rebase this
>    patch set again and again...

You mean locally? I promise you, I can handle rebasing on my reviewing
end for small one-line conflicts like new chip IDs, so don't rebase and
resend simply for that. Unless I find substantive things that you should
change, I'd only expect at most one more rebase to be necessary.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
