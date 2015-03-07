From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: qup: Fix cs-num DT property parsing
Date: Sat, 7 Mar 2015 11:01:04 +0000
Message-ID: <20150307110104.GE28806@sirena.org.uk>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425655578-22400-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 05:26:17PM +0200, Ivan T. Ivanov wrote:
> num-cs is 32 bit property, don't read just upper 16 bits.

Applied, thanks.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tpwAAoJECTWi3JdVIfQRyQH/3MN4ljUfYM5tP684CNTvsvG
E87FSj711yP0MMFyEVKH+KsF4Pbth1lyHyI0W1nK9198fv04x2VVmKraeRo2SPCN
jgvg1Gl74BM8BWEKcrb9CG+evNNuTKrePJRladov2eTia2P2AfNI7H0euxDvhk3G
yp/g66BRjISH0GuZeZgtdoFk9YNdM+UlR8WxMjOsi6uAGW7Kv5r3UIpvPi7Z4Ske
lf4fk2yGSNdXr7/X+pcqfq03qsNHEwT0MrUMRF331KdLl8/igL3TRjZiD+wY/TQX
sWOV8FBS/O/p7GegZX/9vf/AM6D04DegLWfhJxNIJQ+29pH+NAW5K2K/EjPFJl8=
=H2YC
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
