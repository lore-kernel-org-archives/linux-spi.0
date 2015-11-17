From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
Date: Tue, 17 Nov 2015 17:43:33 +0000
Message-ID: <20151117174333.GY31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="apSYfA7d5AHMku3c"
Cc: Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--apSYfA7d5AHMku3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 07:24:22AM -0800, Joshua Clayton wrote:
> Put input from string into its own function.

Again, why are we doing this?  I'm having a hard time seeing what the
gain is, the amount of code being moved is tiny.

--apSYfA7d5AHMku3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS2dEAAoJECTWi3JdVIfQhi4H/3gmd4tqcUxjfwPTSE0Gn429
9FEJvFADV9BtV793Iobxpsh9i8aC83UhpzJesYS2mrxMk8inEu+CZhPM/zk2UfEa
AqC+4UnFNrnhnMUzEtwfpVRkVO3aW397fF+2NXWmW31Ks9/2/1IWFjclvLiq88YP
ui+fzQAXUXcjMpCs68zSVAiiukW2//j/gthkHMjxEjtFvGt/JJKNQBlpPE7hGGhI
QDnF3hjgnERyxjRjp7UxGQjBmgJIxyloLRYGA7hh3/08JhPCEMdlYNBbyuE/LdZB
8XqZuAYOGkkURrUz7QIXgLG/izJKwFln/AsO/eVTiFHvO7jAckKqMmpZRK+QsNM=
=ZcDf
-----END PGP SIGNATURE-----

--apSYfA7d5AHMku3c--
