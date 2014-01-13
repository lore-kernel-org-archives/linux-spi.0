From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error
 and cleanup paths
Date: Mon, 13 Jan 2014 11:59:47 +0000
Message-ID: <20140113115947.GL29039@sirena.org.uk>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WI+ghjzd0JGVd6h/"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389525222-3482-2-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WI+ghjzd0JGVd6h/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2014 at 12:13:34PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

This doesn't seem to apply to current code, please check and resend.
The fact that there's multiple patch serieses in flight from you for
this driver plus development work (again mostly from you) in git is
probably not helping here...

--WI+ghjzd0JGVd6h/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09UwAAoJELSic+t+oim95cIP/1K+jA6FYXdZCJgnziEalRdi
UcIgRvWSwHtDNQNRqZ29jlYtC+aVhh3S3U1DW0pAZD3K+0m4UrvuMLJPJfsAO+GO
4kX9KOVCsLym0jwBJWXjRtr2zBywIvRw4DiVuBM7Q4M1K6JPVoqg0vz5o/HyLKwj
kxGsDUX2HGUt0uSlA8GEBgiUmbTXbmM1jniyxfOUjL2R7Sv3y2dPQ4351FMbfI2p
k4C5/JQ4gCY2Jj4vRdXY0c0sSbC6BtEGEh51mV91w7/1kw06le8jXIWkW8Czgrmw
FPSDA4c4KrJ6kz1JvtKgg1QWNCUMuhFlyarBXeFWObSFrjS1832rDGqIle5Nh1Ai
pZvfx+UngBW4G/PHU01smGG2/kJbHzgYoiPdTNNBcD/0VwdjXvoFpcpGYNl6plBw
4OokFS9JWFEFLkUCXS82Qz9B2sFpS5EYd9Uwb0lylJT3Je4jQArlmga8sscEPvPn
vkmVOJFgHtcJxWZwjElsIpfRZHZsxSfQFgkZsZ6NUZWqRFjSeuVENM4qAFyntvpy
mde2vA8juhmz4Bgm5nkyduvKGXmbHFho5rgLobQfOnXUCu35AB0fd+JYiM7lcbH0
+NtWqvFUMz5o+PEp3Vucq5fHiEBit6o/Y0qfsI4ALJX0259tf+ZOzOcW07jbCHvv
B2R12pnXn5zivnTwmosm
=kvxK
-----END PGP SIGNATURE-----

--WI+ghjzd0JGVd6h/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
