From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/27] spi: Allow compile test of GPIO consumers if
 !GPIOLIB
Date: Wed, 6 May 2015 16:21:20 +0100
Message-ID: <20150506152120.GV22845@sirena.org.uk>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-17-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="proJWJF/9RxP0DAH"
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430843563-18615-17-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--proJWJF/9RxP0DAH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 06:32:33PM +0200, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.

Applied, thanks.

--proJWJF/9RxP0DAH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSjFwAAoJECTWi3JdVIfQXaIH/2u0C+ddwO5SalPOpIoybOrT
sVJQJOm3fzXY66QxbkKzz8v2XVwwS5C0wVhF1vxgbezS7BH40MJwNcpJkGax/S+m
XmukYo9EwPjux+GOkbHA8ba2KLiYuqSLLD/pXRpcLFRISquZsH4XkMGh2ew+CbUW
/EbvfXHJWHZN5k51mZ0jc6zWvGjiIf+FO99yjg79I9hauFUVmxNIMeH+0S7TRjWU
/VLJwnpzUpJUrLCLmtFS7Co4dg6g6cCjSqsVuSDHD/Z8vLDvx4jfsf/G4Uhh8MWr
1typ8T9D2gHequLAq25+JBvi3TyGI8DFdKO2UOWaEYdtDlNvYgOtBHJorEqIryU=
=ujWS
-----END PGP SIGNATURE-----

--proJWJF/9RxP0DAH--
