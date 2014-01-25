From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] m25p80 Quad/Dual updates
Date: Sat, 25 Jan 2014 01:06:10 -0800
Message-ID: <20140125090610.GD3162@norris-Latitude-E6410>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
 <20140123020153.GA6229@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123020153.GA6229-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 23, 2014 at 10:01:56AM +0800, Huang Shijie wrote:
> On Tue, Jan 21, 2014 at 01:59:15PM +0100, Geert Uytterhoeven wrote:
> Hi Brian:
>   should I rebase the SPI-NOR framework on this patch set?

Probably, but I would wait a bit.

I will probably try to take the first two patches of Geert's patch set
for 3.14, as they are a trivial improvement and a bugfix to other queued
material, while the rest will likely wait. And I still don't think we've
taken a close enough look at your existing series for it to be worth an
additional patch submission just yet. But it's up to you.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
