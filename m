From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: add BCMA dependency
Date: Tue, 30 Sep 2014 14:13:35 +0200
Message-ID: <CACna6ryoq0A_6745aemJPQTEZxncmDRkCOPB3ZUHtNhXqXf2Fw@mail.gmail.com>
References: <3256402.M8e92DFkbg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3256402.M8e92DFkbg@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 30 September 2014 14:09, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> The BCMA bus framework can be disabled on bcm53xx, which leads to a link
> error when building the SPI driver:

You missed this one:
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?h=for-next&id=933fc7b06ca62741fd5067edab13068d13b3cb35
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
