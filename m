From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: lp-8841: return correct error code from probe
Date: Thu, 25 Feb 2016 20:09:43 +0300
Message-ID: <1456420183.23036.40.camel@gmail.com>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456400265-3068525-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2016-02-25 at 12:37 +0100, Arnd Bergmann wrote:
> The spi_lp8841_rtc_probe() function misses an initialization of the
> return code when it fails to get its memory resource, as gcc notices:
> 
> drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
> drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This changes the code to propagate the error from
> devm_ioremap_resource().
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: 7ecbfff6711f ("spi: master driver to enable RTC on ICPDAS LP-
> 8841")

Tested-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
