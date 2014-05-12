From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: Enable Dual and Quad SPI read
 transfers for s25sl032p
Date: Mon, 12 May 2014 13:22:45 -0700
Message-ID: <20140512202245.GR28907@ld-irv-0074>
References: <1398170732-19773-1-git-send-email-geert+renesas@glider.be>
 <1398170732-19773-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398170732-19773-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 22, 2014 at 02:45:32PM +0200, Geert Uytterhoeven wrote:
> Spansion s25sl032p supports Dual and Quad SPI transfers, hence set the
> SPI_NOR_DUAL_READ and SPI_NOR_QUAD_READ flags.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Updated for m25p80 -> spi-nor

Pushed to l2-mtd.git. Thanks!

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
