From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Date: Tue, 16 Oct 2018 10:03:10 +0100
Message-ID: <20181016090310.GA7449@sirena.org.uk>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
 <1539628457.30311.5.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539628457.30311.5.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 06:34:18PM +0000, Trent Piepho wrote:

> What about the calls to spi->controller->set_cs() after this? Should a
> driver provided set_cs method be responsible for checking SPI_NO_CS?=20
> Or should it not be called in the first place?

This seems like something that should be done entirely in the framework,
no point in every single driver having to open code the same thing.

> I imagine it depends on what set_cs needs to do, which might not be
> solely related to changing the CS line.

It should be.  If something is hanging other work on set_cs() then it's
going to break.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvFqUsACgkQJNaLcl1U
h9B40Qf/TWJfMXhUwEge5VIGkgNJ235s7i0tQoLwS4JTQM243PCrC82le63VYmD2
Eki8KRNtCo94pMOPeIXMwu1SIfnt8FYqDZElPRNBHb+rruJtXwOLEbKOVoiFbO4j
J2Gv7hmiT3XmP2t0Bvkg31eTaqp5r5iyxSrbWP2Hw4ehMqgm5t9eh2+03skLOcGI
AfyGjbIxEK6weMp1otBBWnM5KftDtSTaTgajbRtX0wvtv15sGqxX8P/9+mbUlfZx
3JcZxdhMtBfIYqSJm8XfKMg7qonEKA9QxyV3RLFy1xjkt2+DgoZkdHt2GaYzZy8O
aBz685qXms+1TN2LD3HY0gFY5cXsaQ==
=oQmb
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
