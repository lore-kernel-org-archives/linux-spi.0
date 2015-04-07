From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] spi: img-spfi: Setup TRANSACTION register before
 CONTROL register
Date: Tue, 7 Apr 2015 12:23:06 +0100
Message-ID: <20150407112306.GL6023@sirena.org.uk>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
 <1428355747-16822-4-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UcGmQXi5EZQSJ0pG"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428355747-16822-4-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UcGmQXi5EZQSJ0pG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 02:29:06PM -0700, Andrew Bresticker wrote:
> From: Sifan Naeem <sifan.naeem@imgtec.com>
>=20
> Setting the transfer length in the TRANSACTION register after the
> CONTROL register is programmed causes intermittent timeout issues in
> SPFI transfers when using the SPI framework to control the CS GPIO
> lines.  To avoid this issue, set transfer length before programming
> the CONTROL register.

This is fine but it appears to be a bug fix and therefore should have
been at the start of the series so it could be applied as such and sent
to Linus.  As it is it depends on the refactoring for prepare() which
prevents that, please regenerate against Linus' tree so it can be sent
as a fix.

--UcGmQXi5EZQSJ0pG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVI74ZAAoJECTWi3JdVIfQABsH/25EjK3z6UQaCfpX0OcRHMDc
PyOWdq+0+9uknLKaXhh1YnMEou1XEBWEi+xYizxi7xqktSFXulMqxvsxl/Yfndlo
OOBWsnDLI8KaDtz/zHWJ5hEr97hi/j7QqF7eZW2AKJM3t13Vi7nVLFONqqr8Y0A/
H1GS0iLw8PWVaoHWkv/C2gK1EMkR64+cFoW8SXFhWP8dEXx8nYo7hIYXV57HVtB2
hg7PhiuAH0y00fjilYK2JSBix3KUy3J1JcZU5hZqdtVYyCrIXj8rUTYHPZDiS7pF
04KbqqHmxxyHrVNd9FpDt4Cr7G0aE0JR/L1owOZbWMR/PnduwVEg6yS/YdYqD6g=
=5HrO
-----END PGP SIGNATURE-----

--UcGmQXi5EZQSJ0pG--
