From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] spi: lpspi: enable runtime pm for lpspi
Date: Mon, 7 Jan 2019 15:16:44 +0000
Message-ID: <20190107151644.GF9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-3-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-3-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:36AM +0000, Clark Wang wrote:
> 	From: Han Xu <han.xu@nxp.com>
>=20
> 	Enable the runtime power management for lpspi module.
>=20
> Do some adaptation work from kernel 4.9 to 4.14.
>=20

Looks like the changelog here is a bit corrupted (extra indents on the
first two lines).  Otherwise this looks fine.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbVwACgkQJNaLcl1U
h9BgiQf/TxYC4kzpAN+XNk0wXcUXulbeQs2Unm4UOD7dtAV+MNcPq/48MaJsatB8
mMnCNSauEqNlpsnElVDbhxclS/MSdck0kygy3QMjPFJF6tHaignlQyn9FqlaJ3js
LkgA9Tan/M3+crCTOzhLwfBkUq3hZEPbC4XE+4cfuT+YER/UFZAX/7CREXo878JX
5ZpSO0ThCQBhTh90hBtdh1SKNifWSHuBoIPDJ2C5RvdYAQcOtOzPPOM6Zna7jMOK
oE1ism5D/KMZg+rhIYv7HvBUJGzHQ6LEEe3PAeNUtL9qVnkJVMx+LkO5RFiTOIzn
ixSYla4IBrpluRNyioXlbhIFg38YTQ==
=7hYB
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
