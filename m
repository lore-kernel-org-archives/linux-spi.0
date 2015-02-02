From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
Date: Mon, 2 Feb 2015 12:17:43 +0000
Message-ID: <20150202121743.GQ21293@sirena.org.uk>
References: <1422871616-6686-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KWLARvBP14GYNO+U"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422871616-6686-1-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KWLARvBP14GYNO+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 11:06:56AM +0100, Ricardo Ribalda Delgado wrote:
> On 1 and 2 bytes per word, the transfer of the 3 last bytes will access
> memory outside tx_ptr.
>=20
> Although this has not trigger any error on real hardware, we should
> better fix this.
>=20
> Fixes: 24ba5e593f391507 Remove rx_fn and tx_fn pointer

Applied, thanks.  Fixes: usually has () around the commit title.

--KWLARvBP14GYNO+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJUz2rnAAoJECTWi3JdVIfQtRsH+IyGFCnthmsJpheGB6ofxsW8
Yeq92lQ6B5JmxlHVP4wHeOeI20MgBnm1iGUDixJz58G+H27yDQjueJVOl2OzNeQT
3HxfSFCFuEVt2GaAu70GOfinB78wWpNhjuw0ndGQaCLMBnZsHKSGXrwr0fINdRc/
nmJ7eZiuztiBV568URO0l1LoNGUB0kf8HuseRSGoiJHhKcTI6z+wcdlJxrwxBuT+
9gXH9k3DgI9hOMnCmqpFjGzl/p4etT8Xp4Q+NTjlFW/rOzGUcHerkAEYtNtf9K5+
21NKFcX9a8ee//McxnD+W4afZgIgIdpqMWkbr1xAyYL1qaV8me5SYLL2sO2vYA==
=HAm6
-----END PGP SIGNATURE-----

--KWLARvBP14GYNO+U--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
