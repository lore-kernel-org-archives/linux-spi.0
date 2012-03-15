From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3 4/6] mfd: mc13xxx-core: use regmap for register access
Date: Thu, 15 Mar 2012 17:43:44 +0000
Message-ID: <20120315174343.GQ3138@opensource.wolfsonmicro.com>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
 <1331757790-10583-5-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331757790-10583-5-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 07:43:08AM +1100, Marc Reilly wrote:
> This change converts the mc13xxx core to use regmap rather than direct
> spi r/w.
> The spidev member of mc13xxx struct becomes redundant and is removed.
> Extra debugging aids are added to mc13xxx_reg_rmw.
> Mutex init is moved to before regmap init.

Reviwed-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

For rmw please push the trace down into regmap as a new tracepoint if
you find it useful; one of the wins from regmap is intended to be the
trace and diagnostic infrastructure you get for free with it.  At the
minute only the underlying reads and writes have trace.

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYipGAAoJEBus8iNuMP3da1sP/ROPgtgPNaPXFB3+ZKjwUn1B
ISivBi7QYeu69pENd0ZI29frZMiec5fNnJ0bx2jFAVdpwTOD8XBOc777p9okecQL
jBNfVhR1paVewoOdsrqabShVlzwHalqEuNvsOL+QFVR8/wW8t8+LOFVmV2nhiaJi
8ltF9aRIp4p+gWz4o3Yn2dmStjoM4OrQTmtCR64Wca0v4/GwPdxDrW+d6brjvo//
lNfqpbifw8BwbC8pUdlgNCzOqS2jEPNysuvFAa72TbjUX4HG4OHdXfL9dS5IJleR
lKDmIzXorjEwiY+CzL4+A+zCvIfMupFsk5eTwpI+IZnAJSfTca9irrwSupyPTinv
6vFHzAJ9EXSzeVzyIS7cq00yJEgNHKiR6/EN9l3gR7EZLiAQajr23zHxQewdHLPI
YTs/qOmx1wNdqtWpXHgooHAMpv/b1wpl8xggGOduODkp7oVcdoxDfBt+RBz/cTjS
zF5w9WKkBiBijxMV9EXKHmFw0Z/ny7Czflnj5heKV0rPOj/wHYQXMaxLlOuyhfR3
xktS1VOq8lJD3Gql2R9xQAD7wlQQkULQWJKlkHCr+nD4lmIDMrhg+iQ5lq3ps7OR
YMouPZXmc7oR5WuC24Pk4zDsnyE+XQwWcUCgQs/GCex/o+uib+YLxAiTrIF8pAdr
6LSaK1M6VUZShKOtVAKN
=ogQ9
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--
