From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: mark device nodes only in case of successful
 instantiation
Date: Mon, 24 Oct 2016 18:30:51 +0100
Message-ID: <20161024173051.GK17252@sirena.org.uk>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
 <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2016 at 03:59:56PM +0200, Ralf Ramsauer wrote:
> Instantiated SPI device nodes are marked with OF_POPULATE. This was
> introduced in bd6c164. On unloading, loaded device nodes will of course

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

Please also use longer hashes - the kernel repository is big enough that
we do actually have a few collisons on shorter hash lengths IIRC.  The
standard thing is 12 characthers (you can set core.abbrev to 12 to help
with this).

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkVKAAoJECTWi3JdVIfQNA0H+gKYoRfi1hrYmOAC+LbCDmAq
bFKNP/Wm8QZm4Ox0AFUrJQvg1/ZUA8hOq29Q2iT+Q4aA0wh/kMoYiqptKYHDJR4i
1cOuJ9f8h7UhlSoQnhVn6Jtkxjyh/NgeE8kUZqw4dKerAPx1S4JIzMWWWqf3IQCm
WYT5ktLxIflHEuPQXzIeY1sQAr840L/T7MrI2rblEAsGfI0qiM9iXgfJX/aywa8T
+9M5snM0em9eLdlulGeHxhhQYCIx0pJrOwudcnSCJaTamyJ0rmuzhBQzH9UOWiZo
fjYfIsSsnNkSV98M3PPnzYWC6hKhgPkt6ByNCvntxEZNxcWgOlNXq7/bBLxnFaE=
=DPzU
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
