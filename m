From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] spi: omap2-mcspi: disable other channels
 CHCONF_FORCE in prepare_message
Date: Fri, 9 Oct 2015 12:38:10 +0100
Message-ID: <20151009113810.GD1542@sirena.org.uk>
References: <5616816C.9020904@baylibre.com>
 <20151008152105.GA13157@deathstar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fionn Cleary <clearyf@tcd.ie>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
To: Michael Welling <mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151008152105.GA13157@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 10:21:05AM -0500, Michael Welling wrote:
> On Thu, Oct 08, 2015 at 04:45:00PM +0200, Neil Armstrong wrote:

> What is the point of doing this void cast below?
> Avoiding compiler warning perhaps?
> Perhaps you can __maybe_unused for the variable instead?

> > +	/* Ignore message */
> > +	(void)msg;

You shouldn't need it at all, but yes if there is a good reason to mark
something as unused the above annotation is better.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWF6ceAAoJECTWi3JdVIfQhu0H/1FDpvUzRN/1RKPDcCx6I7j4
cfhgRobdgd8tMVOuY/ibbXZlxwvFfRBTpyINHiYaqQ4WwZY0FRW9m/l+8YDdPPVg
BUUQKWleYl8wFnzKsn7S8dI5+8An42YNBCLHDSI6uMfcEmpQOIkPlyEqvzk9TxJI
o0R2Hx8vozKlW5XPAnIJie+mf6mqcp3Ywc+zRfgU8puq+RTVwnZ2XWGZ+yhe0AvG
uMtdTVpg/V5+2cFQBNLR8Fd2HCNu63McTkjrie4iBblDsXTnq3DR4umc0lyU8HM1
fO27Hx3ipmo92QLDhClNh5itH2H+5kF05cXNqVv46C1c+9XnSks3zpGpVSKGjw0=
=Gj0y
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
