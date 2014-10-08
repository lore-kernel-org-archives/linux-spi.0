From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] spi: dw: Initialize of_node to discover DT node
 children
Date: Wed, 8 Oct 2014 21:12:57 +0100
Message-ID: <20141008201257.GL4609@sirena.org.uk>
References: <1412794294-31248-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wmb//eAa7gSNqSeK"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412794294-31248-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Wmb//eAa7gSNqSeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 01:51:34PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wro=
te:
> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>=20
> The of_node element must be initialized to enable discovery of node
> children which takes place in the of_register_spi_devices() function.

Applied, thanks.

--Wmb//eAa7gSNqSeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNZrIAAoJECTWi3JdVIfQcMkH/3xDmhUAcnrYGb+n5NfppUwt
sur3DdUalGSINpkxMCKXcSWPgCPh5ieQb2Hou8CHUYN2gaY821YQ91ntZeE6R/dl
UU6C39f/wsRlQgOJQ2OY4wNqbptrwLAcyFN7hu38sZQqS0wA3kxFBM8XcQ687XXh
Jf1309zP1aHcnmDbrCZudx2RcDScNqUuNJ/zNybzNGQyewquzw1IOwaoRqFioMYP
deucH/zDr7xcjvASF77X6i2sVeTmX7evBRJWWE1c9a3JMBRRrretJmjAZ32TLKK+
cyRoI8nf4aGaVkVFkKlRB4Mqfk/BJ+UZ8CoBSQRqRMZI8SchceyrJiIHs39a7iw=
=561C
-----END PGP SIGNATURE-----

--Wmb//eAa7gSNqSeK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
