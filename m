From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Cleaned hexadecimal dump
Date: Mon, 9 Mar 2015 18:40:35 +0000
Message-ID: <20150309184035.GZ28806@sirena.org.uk>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
 <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+7aqSd/VAgMzTgew"
Cc: corbet@lwn.net, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 12:56:32PM -0500, Adrian Remonda wrote:

> +static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
> +{

Please call this hex_dump or something - that's more in line with the
kernel coding style.  Please also don't vUse aHungarian nNotation, it's
also not the kernel coding style.

--+7aqSd/VAgMzTgew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/ekjAAoJECTWi3JdVIfQ5SUH/1uzQay0vUfnzUtfYC7AnZ6e
T7U+Kxq9HY/3t++jeM0/wmlIMdG7gmYPy0TiAd1ePwjbVRzr6/WDXoYX3sQuHvup
OY65Jt6FP/aCAyrqmsO5PGW6bdEF09GsMJ5tXN2VlUVyGn6sC5aPnrzUQ1AcX5Wa
ptW6T/CZ4k2gklDPnSyfXdVnxDRGyg1YBFGtFE6elGvo7m3+5Ugo1/fhAFlQZUrb
2NdGiMNaEjoKHHIZ5r/8NW0qw2GZZCpI7eGQ0tsXSXOIHgHLGWDE3zxNPpaYQWwG
OXvol4o4FmkT8oYoYhJHVGg3a9dcf0i/WJ9KzC3jr8O+kck9e45SL4eJ08FvYrQ=
=3nNt
-----END PGP SIGNATURE-----

--+7aqSd/VAgMzTgew--
