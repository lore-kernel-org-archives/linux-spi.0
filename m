From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-imx: Propagate the real error code on
 platform_get_irq() failure
Date: Fri, 14 Feb 2014 20:41:49 +0000
Message-ID: <20140214204149.GR4451@sirena.org.uk>
References: <1392347962-9835-1-git-send-email-festevam@gmail.com>
 <1392347962-9835-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4NNqsQ/a67jpuySk"
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392347962-9835-2-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4NNqsQ/a67jpuySk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 01:19:22AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> No need to return a 'fake' return value on platform_get_irq() failure.
>=20
> Just return the error code itself instead.

Applied, thanks.

--4NNqsQ/a67jpuySk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/n+KAAoJELSic+t+oim9u54P/iYCmcw09MQPAKC8Dw+i07eY
/hQh5M9M5dXOtqeHbPWD8BD6iS5xSfie6RL6BGm1RVawOryRKixrM22MpoKbD+fl
XJlyf3Z1hN6o7hJ3Ol2PgiMhnyFAUPaTJjJ2JGdj4QwuDjvqX8NW68iRJmz2yqfE
dejj255ZqvK/ji8bFjiYDd1VlKdOaUY4LCcTL5Ymh47YDRmrJRG433WN+AhptpoW
jAPP67b7tCUukKv5V5B346FNvQ273znQ0y9lA5am+2Bxonxslzl3+gnghRezcAQz
xQVxlSM5uvhv9rLNvcz4Zsvyh3MM3sHHWrGuhMRRZB/CqEsYg/sJUlstkH8Mjn3/
sAugdQW9WczDf1d2VwRTL1arC6ITYJPA9+fpPupme4HZvR77ia7lpFMNda1nWM2X
cmXshvqNpnHzJhowj8MD6eFA01mUHsjuTOphZL8K9krYQ49/SYIBm4sXoq6yRsC3
uasWhJ4QVz1F0Q9Hu6aFBBPIjwtl5oHKgV1fnFEzbXw5vcdzsB67xpnxGLCq3Dfz
KXCZ8Lupur8fnoQDn+rUODktSAYXVXCjlayEUc83xBX560BizM6p2rh44Ab7IIkI
SIAUl/fPi/kcCX+UdV7oc+VpcZcYbV28jivFp5wXLrn+Puei0ikNTCw0bKy4ZRUy
GM9u/1iLHlhbvyJ/1V/Q
=Kmtc
-----END PGP SIGNATURE-----

--4NNqsQ/a67jpuySk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
