From: Mark Brown <broonie@kernel.org>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio:
 add MSCC Jaguar2 support]
Date: Wed, 29 Aug 2018 16:15:02 +0100
Message-ID: <20180829151501.GE27808@sirena.org.uk>
References: <20180829150955.GB7459@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829150955.GB7459@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 06:09:55PM +0300, Andy Shevchenko wrote:
> ----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> -----
>=20
> Date: Wed, 29 Aug 2018 18:08:31 +0300
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
> User-Agent: Mutt/1.10.1 (2018-07-13)
>=20
> On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> > Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> > layout than the Ocelot one. Handle that while keeping most of the code
> > common.
>=20
> > -#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
>=20
> > +			   0x3 << if_si_owner_offset,
>=20
> Perhaps,
>=20
> #define MSCC_IF_SI_OWNER_MASK		GENMASK(1, 0)

Oops, sorry - that seems to have been eaten somewhere.  :(

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGuHUACgkQJNaLcl1U
h9A3Wgf9FGUxQNQ9H6VkM/ASsULfuvIMMQP/kUf0mCRd/HvsxZaaS8AeWq74/xZW
EF1NoUrPIca/Gq+Xrrp6cOsKxIuQPorfne96wdJYuY0t5M6BogiWIxF5OIQuGjV1
EQIgDANDMI9SpYP8KYFMZ9+yc6Cp48F/UM6DUjtzKLAMw1NHAsosCwutZX7rCuoY
fKqOY14cwgzsDNCjIVPJjzbuxaW0zcKWY4cDmtZeytRuZpgVnp3nPtTxyvKwHURt
3k063gA7Y+x+pUbhCF8tolkCIUVc5y1wv64xQuaKB/t+VDiHL+rAQWpzPOCxF9aM
P5G2CcA0+J29YvyM5Go9Ghp1pGaSHg==
=bH0e
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
