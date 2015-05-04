From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add spi_statistics framework
Date: Mon, 4 May 2015 14:24:36 +0100
Message-ID: <20150504132436.GX15510@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mu6rDKe19l+MneQx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430741564-2849-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mu6rDKe19l+MneQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 12:12:42PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> add spi_statistics to spi_master and spi_device
> also add a missing "to_spi_master" method
>=20
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Two problems here:
 - This doesn't do what the subject line says it does (it's purely a
   modification to the header).
 - This is two not obviously related changes in a single commit.

--mu6rDKe19l+MneQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3MUAAoJECTWi3JdVIfQlgkH/36Lh/XSebvAa9/rAA/OTDy+
lJq5lQAtlJmUGIh6FlHtBcLSubvY5VevCabN9PbLMdwj0BAcg9TbJshy9SmDXae0
J6Cg/VvNb3zAQvljfVn3gfQM/Mc6kKEmhg2uinzqRuxNEE+mAcCLCZeRrffhxzu+
n4UNvGCce4TpEasiykdPHo+BU+4csHmJQPTuRS2OSwarF+TTeBGOKBdjfkYBs0tA
tDzolx3FKADoNcAxNMOUhJRDD/JJkQiw/1J9mw1GRExkcZ8/lK/5wKU3xAffxeEO
QdswmCHdTjNj+siNQj+IHytbcT2IMEDAyw761LcFtbgmGJpq6D7uCynNSIhYn5Y=
=d/Qo
-----END PGP SIGNATURE-----

--mu6rDKe19l+MneQx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
