From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: add BCMA dependency
Date: Tue, 30 Sep 2014 14:15:33 +0200
Message-ID: <3210109.EFf2P6X6HM@wuerfel>
References: <3256402.M8e92DFkbg@wuerfel> <CACna6ryoq0A_6745aemJPQTEZxncmDRkCOPB3ZUHtNhXqXf2Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACna6ryoq0A_6745aemJPQTEZxncmDRkCOPB3ZUHtNhXqXf2Fw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 30 September 2014 14:13:35 Rafa=C5=82 Mi=C5=82ecki wrote:
> On 30 September 2014 14:09, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > The BCMA bus framework can be disabled on bcm53xx, which leads to a=
 link
> > error when building the SPI driver:
>=20
> You missed this one:
> https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?=
h=3Dfor-next&id=3D933fc7b06ca62741fd5067edab13068d13b3cb35
>=20

Right, I'm still catching up with last week's build regressions.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
