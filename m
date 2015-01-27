From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: dw-mid: get a proper clock frequency for SPI2
Date: Tue, 27 Jan 2015 12:05:00 +0000
Message-ID: <20150127120500.GR21293@sirena.org.uk>
References: <1421942374-18083-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KcF6tPGvW9XXJH0t"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421942374-18083-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KcF6tPGvW9XXJH0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 05:59:34PM +0200, Andy Shevchenko wrote:
> The clock information is being kept in the custom register on Intel MID
> platforms. Each controller has its own dedicated custom register for that.
> Thus, to get a proper frequency we have to read value from the specific o=
ffset
> to the register block. This patch makes this happen.
>=20
> Fixes: d58cf5ff6500 (spi: dw-pci: describe Intel MID controllers better)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This doesn't apply to Linus' tree or my fixes branch so I've applied it
to my development branch.

--KcF6tPGvW9XXJH0t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx37rAAoJECTWi3JdVIfQTcEH/A+cSaOXippygJf2g4CEtQra
9c7EQs0uf1V8cUkde6PHEYgblSqAmjJ5Jl7MrqfGroMaapcEDc4r6EtRayo/eDy+
Z3mLhaMGWuABv/NgiQqPc1wxP8Wsxs5Pn4zC/XeWZbhBd7z9S92IkQ8tTk29mQJB
4N4O5ZvEOwrV1Ol4QMQhgF4kl5R4AFPz93Dgilq8XSs6Yb0vlMMvtnEEE8TlTvR/
hamJiNkWLGdxhUroYwqPQAxGPCCQAPY3HtG8Mdl+NqtOzy1aovyG11mTOp4ht3fX
xBMlT5qJsTQHYGrDA46TWZN/TLwOyvdFJDFnbbforaA0qD5y10CZcQMxT28ySh8=
=rZbd
-----END PGP SIGNATURE-----

--KcF6tPGvW9XXJH0t--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
