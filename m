From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: img-spfi: Verify max spfi transfer length
Date: Tue, 3 Mar 2015 14:26:47 +0000
Message-ID: <20150303142646.GW21293@sirena.org.uk>
References: <1425312406-14076-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d8bwjOb9LdeKYTt3"
Cc: abrestic@chromium.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425312406-14076-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--d8bwjOb9LdeKYTt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 04:06:46PM +0000, Sifan Naeem wrote:
> Maximum transfer length supported by SPFI is 65535, this is limited
> by the number of bits available in SPFI TSize register to represent
> the transfer size.
> For transfer requests larger than the maximum supported the driver
> will return an invalid argument error.

Applied, thanks.

--d8bwjOb9LdeKYTt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9cSlAAoJECTWi3JdVIfQ4KEH/RzDzlBh2NJeDysAGUhwm6Nt
3rPt/ZrTHCbMjCDCSaYHz9AQwveHcrdWHmMDksgZNbHkne+Z0JJUozZLE4prYTIV
ZOPbeaNCTvB/rQj1BCJN97MfGsldXHZwD3LFBeOI9jExSMaTc4H1HLKvtJuUg2K5
U1bnQvpdHTehF1RfVnbMG5Lc7zW4Pfdp0mWhFNEysijjELr4bqnnFVoZaZ7E2BB7
VyDfgpbcDVSAu5i7kmvblpeEBRqi7FfAwiC3F2XMJcV4k1Rb5PxZm8F4ycPzwhjz
GInylI8g2qwNjduKfXuQgo9lgath2J65h78A+jh2yZ1fm6/sHERlwAdNs/IX0FM=
=4oYC
-----END PGP SIGNATURE-----

--d8bwjOb9LdeKYTt3--
