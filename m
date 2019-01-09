From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] spi: lpspi: Add cs-gpio support
Date: Wed, 9 Jan 2019 12:33:07 +0000
Message-ID: <20190109123307.GB10405@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-8-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-8-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:47AM +0000, Clark Wang wrote:
> Add cs-gpio feature for LPSPI.
> The cs line will be controlled in fsl_lpspi_transfe_one_msg() function.
>=20
> Still support using the mode without cs-gpio. It depends on if attribute
> cs-gpio has been configured in dts file.

This is open coding the GPIO - it'd be better to convert to use
transfer_one() so you can use the core GPIO handling but that's not
really directly relevant to this patch so I'm going to apply, just
something it'd be good to work on.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw16gIACgkQJNaLcl1U
h9DaJwf9Exgdkvi3rZsDT1R7F1yOvLKAdQE5R1ZokJnvkEmbN2zfWmYpRbImm+Nt
O6OhL6Sx1J2WXlYDxQB9wr55fbTu51LAWYT8utJHAf3gMrbNEI6f5+RJMJ8rfK8v
DtwxU7pESj2C/FK2Ope74YV8zASasIl+9Hwo4UH6tKmioCwGitNqmUwpnaZn3GB1
GvnzkV5ol5eOSkRZh4nX+MjOAxOBePf/mcZ2ViSP5ej7Yn5dqoLkQHp0XPKz+DLW
n++4Oa9Rq7rrc3vjMliyKb9xqJOJ3Y3f0OqoKvvNDxnxV5B7NDvAB3wn43JitiSx
eWsErR/D3P3Zuwcma2Of+C1q6hNJ2g==
=ZlzS
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
