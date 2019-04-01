From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: oc-tiny: fix negative loop bound error on for loop
Date: Mon, 1 Apr 2019 10:19:31 +0700
Message-ID: <20190401031931.GB2059@sirena.org.uk>
References: <20190330212300.11675-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Cc: linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190330212300.11675-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2019 at 09:23:00PM +0000, Colin King wrote:

> Fixes: ca632f556697 ("spi: reorganize drivers")

Please think about the fixes tags you're applying, this is obviously not
the source of the issue.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhg0IACgkQJNaLcl1U
h9Cs6Qf9Fpbz2BMlEdLo7nS++JCHNNgHm4Bze8OKx/kUYqaoIGevJQa3I+XiiwdV
gEiumPsY5r9I12LcUrzCS82kjns6BelBI8d+tDc/rQLwC2L/J8g6ykWbT7FW/2Op
18R6ghzM+Ht99Yh2QlUm4GBF8iRw6WhUvdUlPIGRXK6abwJSR+4Pt7WpbB6ulFv2
wwk4He5BTE3IQgRD2IrkWvFrx5YCTP2/x9ObdngJC3cMd/HehIF57JO3LKz9HmVL
fVcODQ16aLBAF+Ju6U9C9aULv6gfMw5ueVQv7uWiq3mTNlrXqbgX+U4QBJVIhZR9
6pQGzyzYs6+8TO7YnESyWZNgoaImJA==
=Q9Dc
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
