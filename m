From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm53xx: Fix module dependency
Date: Fri, 26 Sep 2014 08:54:20 +0200
Message-ID: <CACna6ry0JhQEEhsE-NQBqz-9-xa6GeBAUfVr+7DrUaYomzbrtA@mail.gmail.com>
References: <1411712311.23531.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411712311.23531.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 September 2014 08:18, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
> config SPI_BCM53XX needs to depend on BCMA_POSSIBLE and select BCMA.
> This fixes below build error:
> ERROR: "bcma_driver_unregister" [drivers/spi/spi-bcm53xx.ko] undefined!
> ERROR: "__bcma_driver_register" [drivers/spi/spi-bcm53xx.ko] undefined!

Thanks for your patches, look fine!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
