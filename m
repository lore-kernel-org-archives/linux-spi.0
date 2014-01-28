From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] m25p80 Quad/Dual updates
Date: Mon, 27 Jan 2014 21:26:12 -0800
Message-ID: <20140128052612.GE3162@norris-Latitude-E6410>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390309159-19643-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 21, 2014 at 01:59:15PM +0100, Geert Uytterhoeven wrote:
> This patch series allows to really use Quad and Dual SPI Read Tranfers
> with the m25p80 driver:
>     [1/4] mtd: m25p80: Enable Quad SPI read transfers for s25fl512s
>     [2/4] mtd: m25p80: Set rx_nbits for Quad SPI transfers

Pushed 1 and 2 to l2-mtd.git/master and will submit for 3.14-rc1, as
they are trivial extensions/bugfixes for stuff we have queued now.

>     [3/4] mtd: m25p80: Add dual read support
>     [4/4] mtd: m25p80: Enable Dual SPI read transfers for s25fl256s1 and
> 	  s25fl512s

Patches 3 and 4 are queued in l2-mtd.git/next and should go in next
merge window.

> Patch [2/4] is a bug fix.
> Patches [3/4] and [4/4] may be considered of limited use (why use Dual
> transfers if you have Quad transfers?), but
>   1. not all Quad-capable devices may be connected using 6 wires,
>   2. it allows to test Dual SPI transfers in SPI master drivers.

Reason 1 is especially good. Thanks for the patches.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
