From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Date: Thu, 8 Aug 2019 14:27:40 +0100
Message-ID: <20190808132740.GG3795@sirena.co.uk>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
 <20190808131448.349161-3-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, vigneshr@ti.com,
        bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808131448.349161-3-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:14:48PM +0300, Tomer Maimon wrote:

> +	ctrl->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD
> +		| SPI_TX_DUAL | SPI_TX_QUAD;
> +	ctrl->setup =3D npcm_fiu_setup;

I'm not seeing where we implement dual or quad modes in the driver?
There's some=20

> +	dev_info(dev, "NPCM %s probe succeed\n", fiu->info->name);

Just remove this, it makes the log more verbose but doesn't really add
any information.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MI0sACgkQJNaLcl1U
h9Cu2wf9FI8ekzKOtKPknDdXJFSkW34/Y7Fa6IFFOzRNy/zJa/KK4039pd967txp
uqy4z1++x9xd9hct1F2qFzJRRAAfKHxCQVjwfxfXKf5kwHLS/tP9Q3LQtI4Curae
jmY4wrFeNsDTGDtA9BFQFdDbDUp1nNETnWzNPBijNo9cuzTlCsTEEhBpOM5HhhJS
E5i/L3B/If5JDs18ULa4B7vsL4oqMxgHw6ztC2EwkxcNl0/8ymCTzHI8D1kpl/+c
nJ/cX59A4kqGn42v5Zw/dt1zrqAL5lPTywW2RL/WbS7IiDjREsFoHrF4vtnKHJAJ
VEB121JZAJjasaLrxwfT/dO0JDeQFw==
=tVs8
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
