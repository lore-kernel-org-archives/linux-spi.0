From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for
 Designware SPI driver
Date: Fri, 5 Feb 2016 16:11:13 +0000
Message-ID: <20160205161113.GY4455@sirena.org.uk>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <CAHp75VeSkUvHSd_JC-qPzwDjBWM8oxJP8jt3UD91uq1=fvEEqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z1EIi0fvCUyWUKja"
Cc: qiujiang <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, haifeng.wei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
	charles.chenxin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeSkUvHSd_JC-qPzwDjBWM8oxJP8jt3UD91uq1=fvEEqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Z1EIi0fvCUyWUKja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 05:55:42PM +0200, Andy Shevchenko wrote:

> Like Mark noticed there is also same issue. Do you indeed check the
> configuration with different chip select signals?

It's not clear to me that *any* chip select signals work, we get a GPIO
descriptor back but I didn't see any code that ever used the value.

--Z1EIi0fvCUyWUKja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtMmgAAoJECTWi3JdVIfQfLEH/j1ZbidUWinUSaeWo5mGcn1Q
e2QCjzuuFZQ7hijP2cFQnac+59ycPC/lgZ91VZo668y3Gt4DK89YtBSzscyRQ4ry
BPjuysM0FP9QZZdQTrjjCcoi/zlsWGTKlDN9qcr4E5AyQ2uPVtcF7C9th7Yi8Ao2
ubxI9osyMckKIoKN5ofaZ7qoGkrlGjD2xiAqAARm4YudTyWr3gqzcuqdEaR+aSFr
kEZ+9K+DGQGqC2cEsuMQ+7G3C8oRvO/9slg7PDhwznqGxDHq84iehd88PPTPWNc2
NZbKyqetkXyn9upNKE/UB44IlR7WMjMc+xzDcj+NmOcCkJd+QPA/1NiSJXDKGWw=
=LX+c
-----END PGP SIGNATURE-----

--Z1EIi0fvCUyWUKja--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
