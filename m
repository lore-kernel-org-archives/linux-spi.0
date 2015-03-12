From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5] spi: Convert DesignWare SPI driver to 32-bit accesses
Date: Thu, 12 Mar 2015 19:46:42 +0000
Message-ID: <20150312194642.GA28806@sirena.org.uk>
References: <1426187971-8794-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/DKyarNrjr/gdwox"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
	jkosina-AlSwsSmVLrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Julia.Lawall-L2FTfq7BK8M@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426187971-8794-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/DKyarNrjr/gdwox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 02:19:30PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wro=
te:
> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>=20
> Altera's Arria10 SoC requires that all write accesses of APB
> peripherals be 32-bit. The DesignWare documentation indicates
> this change is supported by the design.

Please don't send cover letters for single patches, they just add to
mail volume and often cause useful information to get lost from the
changelog - put anything that shouldn't go in the changelog after the
--- in the mail and anything else in the changelog itself.

--/DKyarNrjr/gdwox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAe0hAAoJECTWi3JdVIfQTzUH+QGt+lmeHydT+Jt4qBcoerHg
LeSezWxJukT7Vtf8+eBZMZMGcvwLnOEaBpvi11vSjEEk87j2rwjdK/SzyRWEsR18
dlLEkebA2NnkunBRY8W65gm3Um6P8OvC8G6zfFQfFp9PUA/CwldZNDsGjiN+s5+a
AgzLnt+UD7ITxICnX2D1DTqEPvvUP9VGPpgKeerRSanCdqAhthHv2n1gWi8crvvw
LVn5WSYryt1A3zBx0Tbs28HlKeP+VWCPr1RJbHWcgDRYksuIOb2L3I8uvb0LG/78
YbdiPXeMlyU5/KariVvYk3LvszOcoxBqSCOCZdRbYgLTmSObJC3R1qvJq6FU550=
=/I23
-----END PGP SIGNATURE-----

--/DKyarNrjr/gdwox--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
