From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: Set bits_per_word_mask to only support 8
 bits word length
Date: Mon, 3 Mar 2014 14:55:49 +0100
Message-ID: <20140303135549.GZ607@lukather>
References: <1393770310.4044.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EpsErgVOvBDllgej"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393770310.4044.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EpsErgVOvBDllgej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 10:25:10PM +0800, Axel Lin wrote:
> This controller only supports 8 bits word length.
> Set bits_per_word_mask so spi core will reject transfers that attempt to =
use
> an unsupported bits_per_word value.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EpsErgVOvBDllgej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTFInlAAoJEBx+YmzsjxAgz8sQAKm05sm/M6zIZmTLDfk1JlUr
2i2pBHfI9xFln1xAryo7UW63xe9qkqVD6L1aL4zprSzqnF+SHEZ+ZGD/xQiTbdhE
00ZqF2h73ScgFFecTbRT5L+06pLdKkq8ax5pU0fmy+hgLaEauvRWTNEK0lCKUqFJ
gAzu/TZ+FIR/MghoBH05hXTW0YfjVZaVO4W/ocsz2UsOhnwExNAZDom6BkMgsMSv
rQHBrMAZCen+4zsQIGEpnCBq+b2g7QYawDKuce8IQEEv2ZdX0RXPMRtjNf2cXbst
8YuK02rDacS9ZMqKfu1edREgk3x5N0jvv1NulF+PBNmlx/sxV6eTjwiNtPfhE1zP
WNoLKqSGBz3chKD3L91rbuojz9va9IDSjb7HQj9p4yDsJ8JIRfsWO5NmKX3oyxIJ
P5nKc6YgScfyi0sAav3ZQW4yvHYeocS+Z0w/x1NMK7b3DN3i7qe3/xBHgOFt1mIk
wcq5BECQdx0fPTa7gt1W5+K5YJ1P0gxgHZVKS67ZwUhEQc0MmvMv0d27lNYnsG9u
0nQq+ANJAKGIbsjUSL9u3qJ4xLXEXhioiosUiaRNNgO51uFj3K5qNHej5XLWPGPv
95fHU8hSLw2H8pdC7IcbqjUfzPEf2Ncl5zCsTCb2Egu+321TsL0/Ijc7LPSg77HC
fZwuK894k6s6J8HKFArj
=5fDo
-----END PGP SIGNATURE-----

--EpsErgVOvBDllgej--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
