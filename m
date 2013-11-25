From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Subject: [PATCH] Fix long standing chip select issue for
 non-default CS-polarity setups
Date: Mon, 25 Nov 2013 11:16:03 +0000
Message-ID: <20131125111603.GC14725@sirena.org.uk>
References: <A4EEA261-22E6-41A7-82C4-68E8606E0863@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jSXJDi5r/aeatSyx"
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A4EEA261-22E6-41A7-82C4-68E8606E0863-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jSXJDi5r/aeatSyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2013 at 07:08:32PM +0100, Martin Sperl wrote:

> This patch makes use of spi_master->setup to set up the flags for all pos=
sible
> variants of the chip-select polarity flags during device setup.
>=20
> It also moves repeated calculations from bcm2835_spi_start_transfer into =
setup.

You can't do this safely, setup() may be called while another transfer
is active so reprogramming the hardware during setup() may disrupt an
ongoing transfer.  Remember, setup() can be triggered by client drivers
calling spi_setup().

--jSXJDi5r/aeatSyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkzFwAAoJELSic+t+oim9FFgP/jI7n5hSgcLvkXw4J0j8TVAn
6uNfgqBoiSJgX5RT5igFHVE2fehzR+NlibDBdR04oOcwoekAPv+c3jM+G8sSHaMo
l0tzy7NdUSgdr9R5G2gTwjOCDqcvGQ/QvCjE8+BfIRubmIWXePkyHdi6Hg9wmSBu
gmxYLVIHneympLyzvMzAsa6WjHwZczYFFIMbPdUOU0O4tK9/P3YaAMJ5wt6eqW4F
YGvtcFpNzd7+6bPoP5zRq5d84YGAbbckuKsDdl/vjCUVgcP2fY6GTa0jO562bFcW
RPnLI5T+Wl428ScwepIKuKXR9R0N4g/xi6JyL55oRTpgPpRXCF9G6/+jx/86/Tgu
ZGBW8J/na8uQ7rfzFmPQnehgbJNgW6lCmvixxQiXndhjdNHlmrc8cp2j+3XkBRII
ae9CD24u/i9RVA8tY6xZhLnJhD7HkE9LxSoEoS/79OfXN2NAyxXDV7kca74lyimY
ck2Guj+lJv2ro//lNkS+BCTh0KPTSd5XiUrWMxNjk5qPoxJfBW+pUe9z1e+vHU7V
pNHijxKo3nrSEF0c34Av9KP9f7Lk0fPdJfyRgcNA+TXt5X6orEDXozJg4YzJq0zc
0EbC7H5xiMPHnZ8dO9O2M8cF3X1x5fMou/VpxMuWPOI7AJZrqP4HWHWoC54E+cbM
JnWOng+MoGe51z3H1SOu
=AMN+
-----END PGP SIGNATURE-----

--jSXJDi5r/aeatSyx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
