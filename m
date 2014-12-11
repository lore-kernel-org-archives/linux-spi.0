From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sun4i: dt: Add pin muxing options for SPI
Date: Thu, 11 Dec 2014 17:57:38 +0100
Message-ID: <20141211165738.GE8739@lukather>
References: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
 <1418033642-29731-3-git-send-email-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v6ieFHm5OYqyo94Y"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418033642-29731-3-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--v6ieFHm5OYqyo94Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:14:01AM -0600, Alexandru Gagniuc wrote:
> These are based on the available SPI configurations of Cubieboard,
> Olimex LIME, and PcDuino. There is no pin group for SPI3, as all the
> boards seem to use those pins for EMAC.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--v6ieFHm5OYqyo94Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUic0CAAoJEBx+YmzsjxAgEWgP+QHAbD/JejGbMjvYsA+Xjde4
HkHFCKuNx1a7xV2reHm4/cd/Kk5yyMnLVMYqpnuOUylrwVTIm4s9rmKvRfnwDG/K
FiL3nyhYKhn5uNVYglzdGO7HX1d9AjHARJBi46wTDT6VpektwGaEzzeWY7/j0agO
DanQQxweV4xLGYzXo7opl4qrLUNLwycXvy35L/8cHqISB6C1f4nWMhLzX+JDorKJ
E8MSxihgDFo+JjHUk+nCOJ+zkqIXkR4yPETLZeTOpm8nkaRXYNOkdvgEB916hnjF
Hy0IbrnRITKDndahLpZCkEqImLg+MqTKkYS/lL2q8kBBWtbJo3CWsLbcvvu44o3e
3doE4T+HGSXJQw70Wa5dVdlE9miiiBhfIn6JWHYFTW5CjmBSaAlg9dTNIsvhlmG2
0Q7Pw4gIMZW1xvJ1BWHm13B6uAREjMXyxw3KYe6m+tmckjkv5nFGyUf5CecyL6zU
QfqVwfXSbWh+mECK/SJAmraB8R21tajqY3AolSFyurHoQevaNxixHN4lkJ1NJyuH
hat2+4Tg5Uy1JpJaU/ly/+Xr1CY6OOzOmDXRlbNlsIc67t7d0q+Gd+BrHpduKrLX
uS65JDOwlRH482ao60pMY99/eWWXCbPMHLZb89UjnQy5PEGj73bHFmNkJMyRzBlY
Nk/DKvP5EfqjEACmsuXB
=m+2y
-----END PGP SIGNATURE-----

--v6ieFHm5OYqyo94Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
