From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date: Fri, 7 Jun 2019 16:59:07 +0100
Message-ID: <20190607155907.GH2456@sirena.org.uk>
References: <20190607155631.15072-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J5NgmdQsYR8vwsNL"
Cc: od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190607155631.15072-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--J5NgmdQsYR8vwsNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.

Hopefully not since we might probe later on if something registers a new
device...

--J5NgmdQsYR8vwsNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6icgACgkQJNaLcl1U
h9Ad9wf/Wgtxk0TyVloO/xxpWXuSBoddyvwLGPNpQgU0WoznSXy9Q8G9bklGm2OY
YRQr42szaLb26rgpWfS6m73qNGAbroMwNAzOLIasQx4a1vMPVC7cgPqQBQ7rCOY1
lWLX0LsbTJM7lnrYxQVH48TTJtqg8JDAo4JuhrCO0Cd6USMmiBDXP1csXbYcdyLi
7MVQD5N04g2XvMAQ3l0Y8HPU2JmzvIr0lcRRlwUo+Q4ybRF9zoDlPaxvumhmJAam
6tbrW7iZPPdPtBgoAiDEjifXojCwPbfrL1GgUtkIRWKkkDcKGAwzTJvLFR6kVa7l
qL8dkCcwCADNwG/O09b3O+YyD8ksLA==
=P0kD
-----END PGP SIGNATURE-----

--J5NgmdQsYR8vwsNL--
