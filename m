From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: dw: fix multiple slaves with different baudrates
Date: Sat, 3 Sep 2016 12:01:18 +0100
Message-ID: <20160903110118.GT3950@sirena.org.uk>
References: <84f71116-1c79-6769-d537-860ac6ea0de9@mseidel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GdlkuMH+DRYbUHkj"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84f71116-1c79-6769-d537-860ac6ea0de9-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GdlkuMH+DRYbUHkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 02, 2016 at 05:39:12PM +0200, Matthias Seidel wrote:
> Add current master clock to dws struct and compare it against the
> requestedtransfer speed. Update clock divider only if necessary.

This doesn't apply against current code, please check and resend.

--GdlkuMH+DRYbUHkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXyq19AAoJECTWi3JdVIfQhNAH+wXSljyWzsp6OS8059U9/+Ec
QdOYXlsP2PGjLWK3UOvRW1v0XcjE8LSJ10HaQwDsWMVrQCnWvR/nvILe4MvKydCn
pQ03mZLK8fhzfidcM9LfSoAs/FZoXrLQWnHuWQiDW9+LaqIZxBxtfyTv4LAsIC5R
XVVVK+kk1cy3K/H/qPqcXL70t0dhkf79zS50Aa1s5PvFItBsM/So3gs8SWyL4EL0
56yGPhhA9oywaEnaAKh11zqJE4a8/x312y9gqNOWZm1NChqOa1U3xDd2c0vaa1Yg
e1sZVgcbpO0umi+vroLbgXYBgqKIwUrUmHoYp7WSGtSQGQ4KFGZZdXepKEzdM90=
=GJXO
-----END PGP SIGNATURE-----

--GdlkuMH+DRYbUHkj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
