From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Date: Mon, 11 Mar 2019 17:03:34 +0000
Message-ID: <20190311170334.GA14368@sirena.org.uk>
References: <20190307103008.19841-1-volker.haspel@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, john.ogness@linutronix.de
To: Volker Haspel <volker.haspel@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307103008.19841-1-volker.haspel@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 11:30:08AM +0100, Volker Haspel wrote:
> The driver does not clearly unregister the spi controller.
> Therefore calling an unbind and bind again will end up in a
> Kernel crash.
> Each driver who calls spi_register_controller() in the probe function
> has to call spi_unregister_controller() too.

Why not change it to use devm?

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyGlOYACgkQJNaLcl1U
h9AeuQf/TJE1svaqSfmjrzUapyQBDgHieQwhgpFkHDYkNAcdKPXxZcnlvhz5lrFa
/0bZ6BeH7jGfY/lNPWLpQ09na9+UaMwYUyhA/hO7HtSDNw1KTxq/77AuG6rDSVxG
ppShkWJfXcgPs/YqwOZbwerWzNKwC0io02cnd+raP2kjyItOiaqzzTrtpodjxDHj
bM9kYkZGLQqUOTLqH7wgA9l532UvoRkZvy0Iq/PEIb1I/smlbesfmdbAwOfQyV9d
uNHeOiRKUwE1W08YX//tgG82el+v7HkGRhXr01u/ZRD9H5/HODLb5e+ClhUEVsJE
rzgEIDthOFfKw4wMfsLtdF3/BR5lQQ==
=/i+o
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
