From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-mxs: Propagate the real error code on
 platform_get_irq() failure
Date: Fri, 14 Feb 2014 20:40:55 +0000
Message-ID: <20140214204055.GQ4451@sirena.org.uk>
References: <1392347962-9835-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZgGN478A9hzzvyZc"
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392347962-9835-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZgGN478A9hzzvyZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 01:19:21AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> No need to return a 'fake' return value on platform_get_irq() failure.
>=20
> Just return the error code itself instead.

Applied, thanks.

--ZgGN478A9hzzvyZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/n9UAAoJELSic+t+oim9d1EP/0wfxsORjQ3RucJDw4zDMC9g
SDF15r7PcGwFHyh7Sk/ODrLl/Ft3jIEz1lACS9j9vDuy1aA3gsSaM+7HEBYU3A22
q4UYn0m5/cQoHcnLxdssZGu7F9bHnlRwfrYsl2T9Au1GkHRaj9/yJ9TtPIQ/dF7y
Au5he8Rx03OfDkYV0GC0ip4JYcQpNrBcWlR/5Z6EfJTuV6kLb/JRfioK6DwPcByO
Fdid2tiyXPNPCqKBa7K0lIA0L3anAKh7disjdzanKzn8uuKFYsHxxSx2pUMTWuB9
4hQhCDzWG6pYw0muBdTESu6SpHw/96yrYjtZSWXSZmYMxrCrJDwVzenNlfx2A7oN
TJRjIX4x7dchjhV8U0fQ5Ki3LLSblHzL8wI1jOQVEyO5JaAqP5i2iNhSbWLigfFr
rhJj2Spqt23Qk0Yo2k0PIl3nsgcXQfF7wA5VBbFfWA1pCUcz+NqsWAzR4m4N08zo
uGzy5bVQ8KFrmRNkolDGPaAhncRQbxdQHwP8YtlUH3QCrrZnr2JPtGS/UEjABITt
q5yfsRkasjYYTXeHW9beNxuZ10vQ5BG0drxCaNR7lpBAnDWXVH+zcXgRowXiBiBQ
o3XUgbIuaYKYbjkF2nFdRvIU5IIfdl5k2434t8GUniYxRtlWM5zNRdolKF5NGGiF
QQPs+Pordpac0FbYZvpE
=N+dW
-----END PGP SIGNATURE-----

--ZgGN478A9hzzvyZc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
