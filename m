From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 12 Dec 2013 12:14:27 +0800
Message-ID: <20131212041425.GA1460@gmail.com>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <52A881CF.4020001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, marex-ynQEQJNshbs@public.gmane.org,
	angus.clark-qxv4g6HH51o@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	pekon-l0cyMroinI0@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52A881CF.4020001-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 11, 2013 at 08:46:31PM +0530, Sourav Poddar wrote:
> As you see in my patches, once we take care of the above points and
> add support
> for memory mapped in m25p80 and qspi, then while doing a read in
> m25p80 we can
> do memcpy at the beginning of m25p80_read and can bypass the entire SPI
> framework for memory mapped read operation. Throughput almost gets
> doubles with this,
> as compared to normal SPI operations.
> 
> So, my intention of reviving this here is to add one more feature
> set, which I suppose
> spi nor framework should handle and to see what needs to be added
> more for this feature.

I already read your patch.

My quadspi driver also uses the memory map mode.
The memory map mode is the default mode for the quadspi driver's read.


You can setup the registers for memory map in the probe() or some other
places.  And use the spi_nor->read() hook to do the memcpy in your driver.


thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
