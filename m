From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: SPI_FSL_DSPI should depend on HAS_DMA
Date: Wed, 14 Dec 2016 14:37:13 +0000
Message-ID: <20161214143713.3kl34okpr5vnuyc6@sirena.org.uk>
References: <1481718485-6966-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kefw7c7zw4hqcm3s"
Cc: Sanchayan Maity <maitysanchayan@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481718485-6966-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kefw7c7zw4hqcm3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 01:28:05PM +0100, Geert Uytterhoeven wrote:
> If NO_DMA=y:

>     ERROR: "bad_dma_ops" [drivers/spi/spi-fsl-dspi.ko] undefined!

> Add a dependency on HAS_DMA to fix this.

Honestly I think we should just fix the architectures that don't support
DMA to provide compile out stubs for DMA, it seems like these
dependencies are more trouble than they're worth.

--kefw7c7zw4hqcm3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRWRkACgkQJNaLcl1U
h9Bs+gf+IKTlSLmQG3HHAhG+9hao7dP23O+yXw0YXJ1/9AUqcUXKdHgqNWwWMDmc
lnz+ftiEm8w4/wctw3A2caJVThn5xUJwGmaM/jsYnVYHIW6PBFKlaYd5AhtswL06
PRxqbN8i0g5AVA19EV1Sk5P43Bbif4DPVx/Rrn1GEw5aVeD6uhsRTXiYlTCttmVa
UpcMG2GieZFLfPGnF+N9Pk1M/TCJNPyod3sO264Ev8/XKI+5ppKDuUOAzMeqNAIg
9xLqVN9rb2BYYVQnCqDExignO76pWCyaU+z3UzuMEgcnXI/2rq8B0GDzXKH3D+pX
wrL1tVLiHQt1tMmbnT1bpJ3aLd/e/Q==
=R9K7
-----END PGP SIGNATURE-----

--kefw7c7zw4hqcm3s--
