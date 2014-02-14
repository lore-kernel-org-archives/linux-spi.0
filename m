From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: sun6i: Fix define for SUN6I_TFR_CTL_CS_MASK
Date: Fri, 14 Feb 2014 22:13:51 +0100
Message-ID: <20140214211351.GH15350@lukather>
References: <1392257895.3964.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392257895.3964.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 10:18:15AM +0800, Axel Lin wrote:
> Current code in sun6i_spi_set_cs() actually clears CPHA and CPOL bits whi=
ch is
> obvious wrong. The define for SUN6I_TFR_CTL_CS_MASK is wrong. Fix it.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Oops, good catch.

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS/ocOAAoJEBx+YmzsjxAg+u0P/0wSRUi6jTlM6oXKhv8snBYK
GHPOtiZ5bvu9WpSEheiMyycbLt5WbfRGygZkZQo23lNBdX4jLbUACliXP0Cp3q8K
bSQpykNes4jI/OerovTV5tAjfdMKo1VJkzgSiv3vHVD0B88hv6LjQshjrebM0D9q
uxIpe54FTSAJEbR4v5VnoYa9IyHrL2flQ+N5a3AkokUkssJljq9YNAI+JVfgKAUB
e6L6Qk3Jh0f58a6nvXHELGH4WoEvtUPwMVUWe/6c0A2iIluTgwmLA5IHFHcmOJvr
biVm+nv91W5KA9bJMcugJkj06Md6WAysQaIOQLhB5AO3h1JAmh5TIX3m2dg572U9
QDKX2iaXPaHGgh0xDuOorWg9Yl+SCx5ezOO9ah4o1NeSkiFfXbBIeZqagaj4WNWe
OQ244EW7WPptyr4avsDMQTF+a/kwXVks9JYxCjc7tO0dGZ2y9YoFaxBTzh4rySUY
CXdMA2exVhwQ/21TdCOS8GUAmcOPMlt0jW9abw1nzPS9H0hnQcCaL61mvl9Ojytg
SGsmGkXMV35WnXXPM4oCRwNI5u6v+UmPr8/XshXYuwDCkMlhzyx8oIZPmfSV2YnG
DI//xJ+RAM08x3sBpjvwcr+x4JKJjoPce9bL9bZlLiaJM9bYJCf+wvv/Uk0358wT
kZKGaHapDEyXC7I8FadZ
=8R+9
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
