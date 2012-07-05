From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Thu, 5 Jul 2012 10:50:24 +0100
Message-ID: <20120705095024.GL4111@opensource.wolfsonmicro.com>
References: <1341418316-26190-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4FF55320.4020107@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9SzJfJEKNI6APITJ"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FF55320.4020107@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9SzJfJEKNI6APITJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 10:41:04AM +0200, Sylwester Nawrocki wrote:

> It doesn't seem right. Why is is the check for valid sdd->regs removed ?
> This should have rather been:

Mostly just because the structure of the code is a bit error prone when
making quick updates with the if statement afterwards that looks like
error handling.

--9SzJfJEKNI6APITJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9WNYAAoJEBus8iNuMP3d7SMP/3NQRba9dK1XubdZsKyy2+dr
CTpBohfSOhmmfgY8X/dz7QHO5RJcOQu/mooez3j+Y2K0FkVtBc2uQKquoFXaUFrA
9RElkjtg75JGX89lyPBd+ZquF8tk/m4GRAOHyLxrG6KIc2x62XOEjwiOv3AuXzoS
ofQKVl0RF1OUDZPUEmZzhHl/E6VDUGti7f3/WjcfF3UV8wf4y/2UlCMjJ/Z+JPiz
UV0sc0YuTNZQKNHCKW0yDbGVqsvJNrAk7ZTYhmqHVxf9wE99FXrvTQy7YR4GRqHR
PYHkKwBK2GqoxgCBYi2WxPvCX5z8X8OT+DqvGMZRD5CNxa0M4P32/kzRK+AHKAng
7BgiLT29OWJVGX6y40/gfrJGSsLNMmtg8cJCzRU138vLdEq1WXxCmcUSErqjjvCd
nxkP/JQzXPrSWOnFk6h8p8hQhYrfVZRFIqWD/UvqrFL0sjSS3AC7vp8Scy+KMpvp
lj0NdWAOIVWhj8KiOkwLZ6FHI0M/y6xPoVShebHDJIwy2QctLnrDGdMlSNQXIFyp
7TNeSKK59aNxOJwbpPrnSGWg+tkAvq8C7DWkNqiIUqHwKbqlkt3ZXxoDY53P1p4b
84pYl3eJ/VS4BKCEde6FEbH0D+6qkJHiaLb+7iXlnxHdb246e5gWem0Y+r0XGBqM
u3CiKQoaB3M6OqLjFdNv
=987w
-----END PGP SIGNATURE-----

--9SzJfJEKNI6APITJ--
