From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: fsl-dspi: Fix clock rate scale values
Date: Tue, 31 Mar 2015 12:13:13 +0100
Message-ID: <20150331111313.GK2869@sirena.org.uk>
References: <1427737756-20487-1-git-send-email-aaron.brice@datasoft.com>
 <1427737756-20487-2-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LjeSjDtfVFFaGPgu"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefan@agner.ch
To: Aaron Brice <aaron.brice@datasoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427737756-20487-2-git-send-email-aaron.brice@datasoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LjeSjDtfVFFaGPgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 10:49:15AM -0700, Aaron Brice wrote:
> Previous algorithm had an outer loop with the values {2,3,5,7} and an
> inner loop with {2,4,6,8,16,32,...,32768}, and would pick the first
> value over the required scaling value (where the total scale was the two
> numbers multiplied).

Applied, thanks.

--LjeSjDtfVFFaGPgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGoFIAAoJECTWi3JdVIfQK/AH/0UXnovI3Tdw8NgeWHmrZ6Hv
G9XQ4drssc4+lA+vUnoFJ0wRXJyoa33RgTBx4eh6SgOExKGg+IdyCiGF+Q2xnmM0
oQPIJsPhHl/HzQ/hC6w68j8QGRRWSD77TvYGTq5K9/rUo6nNgMTaPOW4pzSapNxJ
Y8xVxaHQkDgyaUWOWPhwEA/bij4PS2kQJAukzAX78RL8/p5lQwdYu3nCL+dCKsTV
CN9Dks+NRic9k+pv5bMJuajrGRqkndULcIIXfuKLzhT6spK9kNImcXoH1Evw632i
vxU4zayjXncPz+vOmRY4O09QS2Fgb/N0WYt/7GWeC1fTjo1LKyBN6Ut4HUzIbXc=
=lMiC
-----END PGP SIGNATURE-----

--LjeSjDtfVFFaGPgu--
