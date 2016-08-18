From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer
Date: Thu, 18 Aug 2016 16:11:17 +0900
Message-ID: <20160818071117.fwzdmqfi5hrgkezc@samsunx.samsung>
References: <20160818064431.8982-1-andi.shyti@samsung.com>
 <CAJKOXPe-=qLNSsm9AQHkcVYGSV=yMjsawMbBRbeo6h7sQuzHsw@mail.gmail.com>
 <CGME20160818070554epcas1p190da7fbfcab5aa3a844080430e9055fe@epcas1p1.samsung.com>
 <CAJKOXPevQ9c0ZPSWLftXe05VQad0HsPcnjot1H2QZe027S_W8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <CAJKOXPevQ9c0ZPSWLftXe05VQad0HsPcnjot1H2QZe027S_W8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> >> Create a new entry for the Samsung SPI driver supported by the
> >> drivers/spi/spi-s3c* and remove it from its original place under
> >> "ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".

> One thought. Probably you should extend the entry to cover all the SPI files:
> include/linux/platform_data/spi-s3c64xx.h
> Documentation/devicetree/bindings/spi/spi-samsung.txt

OK, will do!

Thanks,
Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
