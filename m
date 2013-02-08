From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] spi: s3c64xx: add gpio quirk for controller
Date: Fri, 8 Feb 2013 13:17:05 +0000
Message-ID: <20130208131705.GZ8879@opensource.wolfsonmicro.com>
References: <1360105784-12282-1-git-send-email-ks.giri@samsung.com>
 <1360105784-12282-4-git-send-email-ks.giri@samsung.com>
 <20130207115546.GA3801@sirena.org.uk>
 <CAKrE-KfrWdOxm+DJyWqZn1Ye509E_LjzmDb5FMq55SF9-Sua0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UNifc18z8z6e1QHx"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Girish KS <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKrE-KfrWdOxm+DJyWqZn1Ye509E_LjzmDb5FMq55SF9-Sua0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UNifc18z8z6e1QHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2013 at 10:54:01AM -0800, Girish KS wrote:

> As suggested i would make two changes.
> 1. would parse the "gpios"  property and make decision whether to use
> gpios/dedicated pins for miso/miso/clk.
> 2.would parse "cs-gpio"  property from dts node to handle the chip select
> correct me if my understanding is wrong

I think that's probably OK.

--UNifc18z8z6e1QHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFPrDAAoJELSic+t+oim9bqsQAJwi6V2LaYG2UW+13+sLzA7r
PhBTS8xexbU9aMI1mEBD5TunZ7xG8XPpQOux6YfZik6ZBgdJbv0uVGXNYRqWb8j/
HTUMqBfy/Lo9xp+PWy9nCD+SDvcXURgUuvWGBwUoZC1Le6E58RTpr94AiiColxqH
o8JDnuEfL3EiBtkupbAZIsprHrG7h1KdbdexC9Gq1EW5FTN0wBJlN8Q0QDotNP0E
IW2/lMM/iDOqXis4IoveA0/cnyUtvTaXgK0CpQl4WSl8mQvSRT/NFbwiRKlPzgsG
+ii8RxHbxVyFN+2KTiFVHTiiL9nUuDY1RsI6QB3yOORBGe2JZXuDCoVIEtX212wD
dAysqIB3opid7M2khzCsBB7Wd9qMuxgHWcU6GTqeFSOuJSmLPsBtobiBP2XPG6nJ
abbsVlbsj7+qF5FqUUZai8KEfFfYNEyQ4PMDLzWi2CS7KOuL9z4GBW10eR7ObVzb
qo2uzLy5p2YBVwNltUZTTPq/K83Uj22z7sEvaeIimEnba4DM0je+qNVQ8mCpFki3
ySzm3h3iMajEAQIkchhgMf7D1GnmfCR3ypYyugXjKoOI84B7rCS9v5wiP1U7iA+o
ez1nmWmLonLpo61fp6qbRC84KjM7Nt/0VTiMRwNvmKlTRFs3W31wwGyPOtZ+tyb+
DOmBY25gvMJerIKjdF4u
=XCRh
-----END PGP SIGNATURE-----

--UNifc18z8z6e1QHx--
