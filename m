From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 01/10] mtd: spi-nor: fix the wrong dummy value
Date: Wed, 5 Nov 2014 00:27:29 -0800
Message-ID: <20141105082729.GE22361@norris-Latitude-E6410>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398657227-20721-2-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 28, 2014 at 11:53:38AM +0800, Huang Shijie wrote:
> For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then 8.
> The dummy cycles is actually 8 for SPI fast/dual/quad read.
> 
> This patch makes preparations for the DDR quad read, it fixes the wrong dummy
> value for both the spi-nor.c and m25p80.c.
> 
> Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> This ia actually v3.

Don't know why this got left behind. Applied to l2-mtd.git.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
