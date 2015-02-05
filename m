From: Mark Brown <broonie@kernel.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Thu, 5 Feb 2015 14:33:48 +0000
Message-ID: <20150205143348.GV21293@sirena.org.uk>
References: <1420472564.803.9.camel@gmail.com>
 <20150105154834.GV11764@sirena.org.uk>
 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
 <20150123124529.GU21293@sirena.org.uk>
 <20150125173853.GA6467@kroah.com>
 <20150125201254.GX21293@sirena.org.uk>
 <20150125220723.GD29924@kroah.com>
 <1423040613.3304.10.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y/aqi7sag87A1fiJ"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Esben Haabendal <esben.haabendal@gmail.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Stefan Roese <sr@denx.de>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423040613.3304.10.camel@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--y/aqi7sag87A1fiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 10:03:33AM +0100, Esben Haabendal wrote:

> I suspect that the regression I have observed is caused by the
> combination of the following two commits:

> commit 059b8ffeee5b427949872bb6ed5db5ae0788054e
>   spi: make sure all transfer has proper speed set

> commit e6811d1d7a6a38ee637fe219c3b67dbfe17e8b3f
>   spi: make sure all transfer has bits_per_word set

> And the broken behaviour of the spi-fsl-spi driver prior to the (now
> backported) commit 4302a59629f7a0bd70fd1605d2b558597517372a.

> A side effect of the two above mentioned commits is that the spi all
> transfers (in multi message transfers) have their transfer speed_hz and
> bits_per_word set, which is not handled properly by spi-fsl-spi.

OK, so this is the analysis I was looking for before we merged the patch
into stable - we shouldn't normally be merging new features in so we
really need to understand why the new feature is appropriate.  "This
seems to make it work" isn't doing that.

The other problem was that I didn't know this was in stable until after
the fact - we should try to avoid that happening in future.

--y/aqi7sag87A1fiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU039LAAoJECTWi3JdVIfQsvoH/jH9wG0RgLrSovObnpE9D2DW
6s3BR7rO6VBhvj6ens1/H7NdoOT0uZTD5GKzb7MOY98XQiTJ6gdNVitNhG1V4VQ6
xy8QNl7kfz+l1MF1KnPFmws1yKk3zrDfF2cQ7SNysDaB8botXWIM9FA91+l+xuQj
TBL/T4CkWV09578kLAUzidquCJcvtv1aTEqCsOl1lV0KahOBUyF+G+FNrVyRZwN4
hKovEdYCzF22kMtX7ocd8w6fji/maYhpzRAa+6s3Ix6htuFgV8RBOs2Nt77IcK5Y
fLSVmO5uJSrKyAjiMXsHpoeA1oANFzfnqWZlpDRzicBdZczqVCBm8wJzeJ39cPo=
=TZG3
-----END PGP SIGNATURE-----

--y/aqi7sag87A1fiJ--
