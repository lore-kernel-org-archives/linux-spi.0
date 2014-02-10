From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove unused pointer in
 omap1_spi100k_txrx_pio()
Date: Mon, 10 Feb 2014 12:17:29 +0000
Message-ID: <20140210121729.GT1757@sirena.org.uk>
References: <20140208190223.45d1dcf8@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pd495SECmvzXpBRb"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140208190223.45d1dcf8@spike>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pd495SECmvzXpBRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2014 at 07:02:23PM +0100, Christian Engelmayer wrote:
> Remove unused devdata pointer 'spi100k' in function omap1_spi100k_txrx_pi=
o().
>=20
> Detected by Coverity: CID 1077869.

Applied, thanks.

--pd495SECmvzXpBRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+MNVAAoJELSic+t+oim9aZcP/isElpSecsmOL4ElcIk+ihD2
gpl0GIHKhDK5rvODVcdZXZD0/dTK2iJcIfxM7/6by0cfELJkNCjuf5fa6EShy/V+
BqiO26QmG268N7FBoDLCR8XnhjWOIx1cH532chbgGeZKIvz1mXS9RdxhV8eHFUa7
QI7zrrA5791ag3Z6tZ5M7Qg9dNoW0iX+ko4MehVgvrJLyYvWxbmmET0K8qnAjfy1
djZhGT2Nj8c+UciffaRfrgdj4zcycUiH+kikYPpIJpBn5WVk6lYTRKfIe42SNkWV
h5Q7RtIfQ1Lbcts44kuHKyv8EDsxImYsmGO9emYc2hirmVLUeLtojbaw1fwSdZnv
ngfqQ4aIoRdYxE7nC2EOJV5EXsC1R+dl2tTvHO9w4bWV6D3XeNSQyl8NxkWlU0es
pHAmX3sch7339aEaTaJ6fr4GR7Wo8WSDlN+ZGEI0pw3JgMDmedswVDvGDW1cNfV/
Vw46k0k+LoagPL7E2304moixYpTC/HiaSxO+xHZlI15yYeP7iEmxr0kS4Rkdg4dW
2EG1GKam4W+TIcLeC8ru4vNhTkELTG6mrHC5ohyAyBzoTm5YjJYgb7vuOU7AEN4B
ykvHT2fbV4RHjg+M0J8q1YBPQTaUHhZAj6ZudsGaSbrEbg8vAodV3vg1SXFCFut7
Vi7wK6NZDPoBJhLhzdPx
=mAJU
-----END PGP SIGNATURE-----

--pd495SECmvzXpBRb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
