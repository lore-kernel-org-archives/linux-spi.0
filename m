From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 12:44:17 -0700
Message-ID: <20170925194417.bjkw5ar6s57bkbdt@sirena.org.uk>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
 <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
 <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
 <20170925192256.bmrm6gmb4idvomxb@sirena.org.uk>
 <156431d9-a518-53e7-17d9-bb1ee0f637bb@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiwcfzi5jzh7vexp"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <156431d9-a518-53e7-17d9-bb1ee0f637bb-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hiwcfzi5jzh7vexp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 12:31:03PM -0700, Randy Dunlap wrote:
> On 09/25/17 12:22, Mark Brown wrote:

> > In this case the problem is even more basic in that the driver does
> > actually depend on having hwspinlocks for any production use.

> so just add:
> 	depends on HWSPINLOCK

> Is that satisfactory to you?

That would then get in the way of build test coverage. =20

--hiwcfzi5jzh7vexp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJXJAACgkQJNaLcl1U
h9DnRQf+OPFa+qowM/hbHPWPtIEh2fLnx0Og6Fdr96sZXuv2CeuJRBB3o0WZKJlA
vf/sK+1DlT0pz7aVOUJ5wxiwRV1lk00uma4AZaYGtoE9KUSiRuL82ZpnMB6HQj7T
uipl3TWK/DKvBtyqouLZd6QilcIOeZYSOGfZtFez8YCpTRwAHsUMi1L4kCaG8qkK
UbHyNOOBmC1jxipAb1FxqQA8o6wCn1WgLBNAi5t6rlqIR71olaT/hdZx2/DyXBQ+
N2LnMrAu9JO4wFlqphbLrNgGp/U0IIs8cPIYnqedmL0ojv9udBz/WQl1SOsJvxG3
fpNX4GSfNS9TLU+FpFYkytAwvI84Zw==
=XlYl
-----END PGP SIGNATURE-----

--hiwcfzi5jzh7vexp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
