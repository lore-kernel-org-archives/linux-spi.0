From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/omap2-mcpsi: Always call
 spi_finalize_current_message()
Date: Wed, 22 Apr 2015 15:11:39 +0100
Message-ID: <20150422141139.GX22845@sirena.org.uk>
References: <87vbgo2ser.fsf@tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XiX5sJQOWZsNRXst"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87vbgo2ser.fsf-/Zw1syy4LHg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XiX5sJQOWZsNRXst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 03:39:56PM +0200, Fionn Cleary wrote:
> Hi,
>=20
> While testing the omap2-mcspi driver I discovered that triggering the
> error conditions in omap2_mcspi_transfer_one_message() will result in
> the queue for the bus locking up while waiting for
> spi_finalize_current_message().  This patch ensure that
> spi_finalize_current_message() is always called for all error conditions
> in omap2_mcspi_transfer_one_message().

Please follow the patch submission process covered in SubmittingPatches
- please send to the maintainer and send in the format covered there.

--XiX5sJQOWZsNRXst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN6waAAoJECTWi3JdVIfQ8JgH/RTlXbLUl6cXEePBHJsCY+4n
9qeb7xEuB8DJi3gvYvFetpaABYcbetBfmhNaGX5iu4Ut/Swqcj1Vv0d6zmDOMX2e
h6C0w4O1Azhn7PvBC9siD/jvs4swO1wWzwZ4id6WP+QIys0sjZT8CJdkb0NZJKHh
yhaEy7UhO/g02aKn9Hqi6iRE+fArg1cgtyLW8eqtwEnWeK4uia0/+GIEmkwY9WDL
o2kR8G1a46tEJPZ/fCMIfCobtTeeRX6nsXs+89ApG/3WQvXPRDDzTFX5BLgRSp9A
6c/BcXShIRhncS9ZNuubI6ki0KHJvSLquCMS8jLdXQGRK/tCj/k8T6PcRZ9Zx5o=
=B0mG
-----END PGP SIGNATURE-----

--XiX5sJQOWZsNRXst--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
