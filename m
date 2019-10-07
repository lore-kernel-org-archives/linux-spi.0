From: Mark Brown <broonie@kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Date: Mon, 7 Oct 2019 18:02:53 +0100
Message-ID: <20191007170253.GA5614@sirena.co.uk>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
 <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
 <20190926144342.327a3c66@jawa>
 <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
 <20190926160645.0a2623fa@jawa>
 <20190926151752.GU2036@sirena.org.uk>
 <20190927003849.0c9e4335@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190927003849.0c9e4335@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 12:38:49AM +0200, Lukasz Majewski wrote:

> Maybe, it would be sufficient for now to move the spi_slave_abort() in
> spi_release() before we decrease (spidev->users--) the use count?

I think that should be OK, or possibly safer to do it at the start of
the if (!spidev->users) section to avoid problems with fork()/exec()
combinations.  It'll need an if (spidev->spi) check as well, if we
manage to hit that we've pretty much lost anyway though and I'm not sure
I see a route to sensible error handling.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2bb70ACgkQJNaLcl1U
h9DHBgf/W/m+2jSATkcpdM7/FcRS/sMhWH6GHQp/pY+NkbGheVslqR70gaBKZl00
uVGBSaHg4XeQBndvtXyeqxAOOAqD9EvLXbRmAxDXcaezzr2K0UrysXvnAWJl80R6
UdzKeYw2gGchXz00zbWxnfcxcgQIvS4kRHfqoqb2LleeuL7g8S5rSdERpfoAGZG6
hVdax2Rpeskq0nGOzibmvi7N0+zQLn/379s0kXtavs+IfxT47eSPkkAv7V7ZOEPU
3BT0hYwJVBRC2Wb5m8Ddz0Cnt/mm0gTzURVxF+fTDj9uCXXxDEebrMpRLv1tcCfn
4+AI295/ZNCOaYqQzhx8/WYenQnqMg==
=Yu7g
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
