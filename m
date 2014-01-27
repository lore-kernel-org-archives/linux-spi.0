From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/14] spi: rspi: Add support for more than one
 interrupt
Date: Mon, 27 Jan 2014 20:05:45 +0000
Message-ID: <20140127200545.GJ11841@sirena.org.uk>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
 <1390553044-11860-9-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1+ljxmNgwU2bK8G"
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390553044-11860-9-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--A1+ljxmNgwU2bK8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 09:43:58AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Add support for multiple interrupts, based on the SDK reference code.
> This is needed for RZ/A1H, which supports 3 interrupts.

Applied, thanks.

--A1+ljxmNgwU2bK8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rwWAAoJELSic+t+oim9vhAP/2qSvhUVg1t3v0UxelkRzfYb
F3uMf2ixd9suE8qA+PI1YUT92uymJwoIJkjcFuBQYZMROKkmerfNGKMfcdb8o+ju
vjbZptnbrRnZHFNYvtDi1ktwY+heW4dPYIcvAjdu4wEDjOdYfuAujHYxOM1I9XJR
bbsC8NAxSd2lE3sYx4bCxJOTRFCk+t7MWBOCncc9WfzIs7bJFs+jiWL9mbbaxLLV
oofER0HV2SmAOa9pe+gFr2gQ2K90GKaKjB1LD4JbzjptU8kfhxGm2N+yDYTh+n5G
h+FBHESR3qSTGAhoN1ie1Z2DzodOhy7Ma7EbNS9zCOLZU7gNQJCb2zDqQrmUV7op
rNiyB89CPUssnOpNPicJqXHSMXJ6O76kHmHIKufEhGz0PoZmTRr1r0J0prP8Zay5
ycKx7GDryQjC2/xEwouGOPJ//0Z84VUAb9pdpXIDU13Aij200XUptzIXPRH+fPib
K/Uw7iYkoE7HkmgboKo68PcM4vQ2dWl2WMv3fPI1GDL97P5bFu0FW2wDDXTjQnpF
3oY+JVibS4z87Ld53o5W+dM2Iq9fs1Esj4RkLkCXLcx3uCg60a/uYmGtb83XH6+G
4ypJyDqg/IQkGwYLYmnZF5qo1TJT/slNh48D0XUHjIjympjusuOlfrJPWBDvGX/o
W1ESbC6XRUo63v2Z57yP
=Rx4P
-----END PGP SIGNATURE-----

--A1+ljxmNgwU2bK8G--
