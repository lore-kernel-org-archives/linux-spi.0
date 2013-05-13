From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drivers: spi: convert to devm_ioremap_resource()
Date: Mon, 13 May 2013 18:16:49 +0400
Message-ID: <20130513141649.GA16673@sirena.org.uk>
References: <1368453886-6852-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: spi-devel-general@lists.sourceforge.net,
	Stephen Warren <swarren@wwwdotorg.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368453886-6852-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2013 at 05:04:46PM +0300, Silviu-Mihai Popescu wrote:
> Convert  use of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.

A version of this patch has already been applied.  Please make sure to
generate patches against the relevant development tree (or -next) to
catch such things.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkPXNAAoJELSic+t+oim98OQP/3eV9cT2GCnZBPD2vGKcLUkk
zBuK81IT0kHRNyRmsyXmtbDV6Jm7D17vMD4hxZRUoy27vJGk+avuXnetF9uHnbtf
hknd6+NGTonTNt9Rw/FjCC+M0QrQkW3DXVap/XELEsYPBN5aHgzAVwtVbvHG9VXS
mYK/NExUYgJcFIr6gSJHE/HWYStpkJv4G+zpsoSR180m2JncXooVqoT4NArsTgAr
rErcv4utZM7vj0UK7s6C8wST9Zbr02auRt2XkiphKrLIjQqIoyKL1re/I2BmqjgQ
UoJDm5E/b9GAkrT02z58dWqK9T3fCUHJqUJDgRyn7rzGLHQImrmaxGKpp0OS74iU
3EoVhktoUTR1g40qraQBGqn4oEBjfnSJZAqk99+rp8N4SBd/uBJT2DFhqdcqWuQD
m5LtftQWAUQ3WFkrkc4YR92yuvo2ABHIBAxhfkAWClAe7fBS504WN94TUpXZ/fhq
r5/+ycZwmeFWd5vTng5dlsurL5keUAlZph9em0xgptWLIwElidlwLNjMrRKs99Gy
s+eXFt37wPbQiojKi1WCeeFe8P1XMWgA8qOs/XA6oZJkzbh0CilTyoSRb9HlyUz9
N71Xla+VNRNqaQBkAd3+d8WyVolrNrjdAGkdcwI1lyFb8PhqjOusxYgNOgVYBlDc
DSfJQzQLd/N3igPGMKqH
=7ll1
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
