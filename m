From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
Date: Wed, 24 Oct 2018 11:44:56 +0100
Message-ID: <20181024104456.GP2103@sirena.org.uk>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
 <20181024075617.19548-4-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3bc47Eih9dS+biPM"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024075617.19548-4-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3bc47Eih9dS+biPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 07:58:30AM +0000, Clark Wang wrote:

> Enable the runtime pm for lpspi module
>=20
> BuildInfo:
> 	- U-Boot 2018.03-imx_4.14.y
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

This looks like Han Xu wrote this patch, Frank Li reviewed it and then
you are sending it on but it doesn't say that you wrote it - is that
what's going on here?

--3bc47Eih9dS+biPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQTScACgkQJNaLcl1U
h9D93wf9EQUZ5MMqEsDkIYvm7eUCXUNGM8pdl50zZDEevyleUZ9+NvKjLwvG9HMo
MGPCi2a4nHQpbkc5nZ2GdVdnU0bGCRH/zcGUhvEobAvAN9ujtkqpTzj2hRa2GSlm
TzZoYe41UsI0g8IcgIMFovxKgBeYaQtRDeymm0U9lF/lgunEBc3VxD8P2qNxRpXh
9EqRzrR6mFPwrM64Byq7prNQ8GdqyWnTXFPZYxnX6mlXcxzRrY/uRoiySv5ZP4ct
1QqztSSTzj2ksAUtVaClkKa6ymh4kZ0Vhnv1AvQ06SVzDGS4Q+7lcW+fXNAfO2w2
lJ9kB9pNl3So7WMxneRu4NSdHZ5mDA==
=vlfN
-----END PGP SIGNATURE-----

--3bc47Eih9dS+biPM--
