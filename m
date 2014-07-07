From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/spi-sh: Use devm_ioremap
Date: Mon, 7 Jul 2014 12:51:43 +0200
Message-ID: <20140707105143.GH30458@sirena.org.uk>
References: <20140706161450.GA6304@himangi-Dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	julia.lawall@lip6.fr
To: Himangi Saraogi <himangi774@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140706161450.GA6304@himangi-Dell>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 06, 2014 at 09:44:50PM +0530, Himangi Saraogi wrote:
> This patch introduces the use of devm_ioremap and removes the iounmaps
> in the probe and remove functions. Also, the labels are renamed to
> preserve ordering.

Applied, thanks.

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTunu3AAoJELSic+t+oim9hHYP/1M3mPSSWkQmOx+zYqwGgI+w
Ux9B6Iz9N1E7Kw4lB4c+EDzPvnOi41j0Vj5JUsX5fsVm7mfbSL8dNJe1M9cUTkrk
0lpVL9VwIMFf/7l69W8Kh2t3zPVx2gYhNxZxLCttdLZKtfqMEDp/SDqFHnOkPvNL
joHdMwCbVqSVvWsEgI/QBrIBClZg3xDqbR9EqIcGCgCE4QWPCeoEOt0OakokI2I3
Xs62nm2wbjmlwZyt46n7OL2hW2cKKyqQGVSimobsGYmIliwZvrXo06jbmnWWZweb
760HqHSMAj0Ns0w9c+5c1qkswW8PVtR8+ZyzAlj66Jj/GF7pgefKyoFq7MWwCFqI
pWZN2cQodVVbaYKf5mkNPQE09geYg1Y64WYau53e7pS6POcu6Y9mpFgOgv+eXWns
ulyD4PnSien+/6GZg2oDayJ8XLi0hwrKpDFoxxQX/TpgoKG6LRnZCjzGR+oIc04C
qqP1sgOvEWOXRmomwMFwHUwwyyNDT7ucsPIdwJEFWtjXkJ3YswbHBPgRRdLiVYTB
XSLcfjGB0y7FuVWSduVjmGqARBisDx2rPTGfdqfatA6klbgSnGPJrgTnjIec+KzR
1phvUicgfboGvXGtJKTzlYp0w1DrolBVDkUtBmSu05UPraiNUc1KDoD3g1qDEvQU
dnvFg5u0aequdTxeqIQI
=+LUV
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
