From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] Documentation/spi/spidev_test.c: accept input from a
 file
Date: Tue, 17 Nov 2015 18:46:27 +0000
Message-ID: <20151117184627.GC31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <d90d749776cf562bc9922aff5e97cb911a77b22b.1447773299.git.stillcompiling@gmail.com>
 <564B716E.5020605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
Cc: Joshua Clayton <stillcompiling@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564B716E.5020605@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Ro1PRY3Rtw8g7IwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 07:26:54PM +0100, Anton Bondarenko wrote:
> On 17.11.2015 16:24, Joshua Clayton wrote:

> >+	if (sb.st_size > 4096)
> >+		pabort("input file exceeds spidev's 4k limit");

> This is not a true. IIRC PAGE_SIZE is the default buffer size for spidev,
> but can be changed using bufsiz module parameter.
> Just 'insmod spidev bufsiz=X', where X is number of bytes.

Right, there's also various options for changing PAGE_SIZE on some
architectures.  I was going to go and check what we actually do here but
in general it does seem better to just let the kernel worry about
validating things like this - it needs to do that anyway and it means
that if someone improves the kernel code to accept larger buffers then
the tool will automatically be able to use them instead of requiring
people to remember to separately update the tool.

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS3YCAAoJECTWi3JdVIfQ5cwH/03NtgsAaODQWGkSBdvdwEeE
LwNu60Ugkbrm84t43aT2AW5sgKRFWhpkIzzxjGJem9Dm0Imv2s8jFNWfwemdSjzC
Cvm0eUYjcMRyfBVL6yQtEcquAXk9mUrIQdiB7vaIhGZ6+6S8H50E5/nurbBG8V5N
71r2ul6yqBNG9EzsltD1ErLa89LF650kQXwA6aklZNhby5SBxOKsKu0Qq7hqWLZE
4yrmU5AZr/2sQfzmbdF5vb801j1ZiU+/bHk1KMGbT98uIS8dp5LdBV4ZGJt0vQpZ
8/weAaE+Ln7orWNF0aniZQUncORMKA/Wyctq8Y8l458wtbBhVf3lliSjS/KyfwI=
=HsA1
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--
