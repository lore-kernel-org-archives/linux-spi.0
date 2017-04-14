From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: atmel: factorize reusable code for SPI
 controller init
Date: Fri, 14 Apr 2017 18:03:56 +0100
Message-ID: <20170414170356.lbueenkw6lcv5vrp@sirena.org.uk>
References: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gaekp6lgm5nkyorg"
Cc: nicolas.ferre@microchip.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com,
        thomas.petazzoni@free-electrons.com
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gaekp6lgm5nkyorg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 14, 2017 at 10:22:42AM +0200, Quentin Schulz wrote:
> The SPI controller configuration during the init can be reused, for the
> resume function for example.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--gaekp6lgm5nkyorg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljxAPsACgkQJNaLcl1U
h9AEwwf/ZOcrv4ryZoZIh+yRwVAj0hse4W+Ljea/1eJ/rfOyWh3jvpEAaVeap2i5
NLrZYP+fjpd3Az6Cv/PH/d+kogB9jr/eWBHBgQZIiMgt78lNW39g7zVHysvGOeFm
XTn336bB5zCkecSCamVBn3xLqvYeq0Be4c3MT6g54746BPqQP8ycpAHOcSlf+rFf
qLhbf7c7uWUAaGH418effyA0+IxHtoNEynVDk+Wp6pN2Oq6RDgWb0wIPUGwhBHNF
JwR13NJ29WUJ4z7gBXg8uM8K8WaCezlWvcF8EJlDIEzqWPckuBHWmkl+slm60TXl
zPmq/51h6c2rRGvcq9VW6WgVLV5mnw==
=vfHo
-----END PGP SIGNATURE-----

--gaekp6lgm5nkyorg--
