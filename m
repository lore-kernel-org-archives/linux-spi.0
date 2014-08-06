From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/12] spi: rspi and sh-msiof driver updates
Date: Wed, 6 Aug 2014 21:29:51 +0100
Message-ID: <20140806202951.GU17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFJq4JBCEm+n5/He"
Cc: Simon Horman <horms@verge.net.au>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FFJq4JBCEm+n5/He
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 02:58:57PM +0200, Geert Uytterhoeven wrote:
> 	Hi Mark, Simon,
>=20
> Here's a series of Renesas RSPI/QSPI and SH-MSIOF SPI driver updates.
> I grouped them in three parts:
>   - [1-5] are for the rspi driver (Mark),
>   - [6-8] are for the sh-msiof driver (Mark),
>   - [9-12] are for the R-Car Gen2 DTSes (Simon).

Please don't send big jumbo patch serieses for different things in one
fell swoop - for example the two bug fixes here should probably have
been split out, and the rspi and sh-msiof changes have little
interdependency with the rest of the series.

--FFJq4JBCEm+n5/He
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4pA8AAoJELSic+t+oim9GX8P/iroLOv780dwIimD7Ud+fZc2
GlYyZCFEOEuSz5PFyL/8y3zWrNk0r3M1ldt+IayO1Kz5MvlbCCc74udfljla8LJ7
x/LipNn2nTFpwKcKRqPLJcJVCzDdiNO1+3ohu+S5Yl6AI+TUXjPyjKqjFOrcppGd
vow+Bkjlq+zLjv6cLEzKlNBMYJCv6sPlAdaCGZR0FnkxiL38CafXWW2DKjj25Qzj
ZB68scnEf/DorfcREDAYNh99EznLqsyNoWuD8wSBCPVhXvXBLKpJArEUya/Jx7Gx
x58EXIIupSwSMb7iMRWAmZ8X2uRABa5GlnS/Q1SIRl41USlCwtdJOtKttDD6n16K
dyIofk5GbUv/PJwaSvzjpj1mZzKC6TAfll8BiQBx3jdJpBJuWYi15GgoKEjPnJ8a
0wCRGbc3d1hMdNx9gKrYO+6VeaRXxulbxB5Tc/rH+9PocOYrWfc2TQ6pcMNbFR1F
ozq2KNNJa3/kZMVe7t8rG/pcAngfwckDjOwkTB4gcV12YhzQofcFXaRtvchX9E+s
1+Ia/9KsK84T8iFFW59Vsdz6nMdTSVKde8KLvy0yi49wae/HnG7Ln4KoKHtL+/bA
hnvqbNXIUxeNPILGridWVeuAZknWJQG/6U3SeTXTylNv29st+9uhMoPYPrRRwnKM
TFNTugBkxSqDemRsTVkg
=HojX
-----END PGP SIGNATURE-----

--FFJq4JBCEm+n5/He--
