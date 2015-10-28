From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Add SPI to platform_no_drv_owner.cocci warnings
Date: Thu, 29 Oct 2015 08:22:17 +0900
Message-ID: <20151028232217.GD28319@sirena.org.uk>
References: <1446054547-23859-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CPaaJmjEtnx7DmsZ"
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446054547-23859-1-git-send-email-afd-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CPaaJmjEtnx7DmsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2015 at 12:49:07PM -0500, Andrew F. Davis wrote:
> Remove .owner field if calls are used which set it automatically
>=20
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  scripts/coccinelle/api/platform_no_drv_owner.cocci | 73 ++++++++++++++++=
++++++

You need to send this to whoever the maintainers for the coccinelle
script are.

--CPaaJmjEtnx7DmsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMVilAAoJECTWi3JdVIfQ/RQH/2JNHmv2Uj4Bk2WPqmJKaErO
L9KjhC1RuSxpV0w7mtfntZw0o96tn6r4jVNhzsJwABIfQ54TcKkmQN+W29/ZbaQK
s8JHa25cz5J2Ubr1FdAJNE4VvM3ITOJ78jVTeYDni66ewPbCPymwpu5HAvcVVJtH
Us4tHT++QwNVrbWU+oEEmhICEkIjpsju3SGODgO4ZbDbfXvoS75PhauKrIkgwLSx
X+Al09TmGe3inSNULvpzWsiHfu+6eBsL15CCfyySWKVQh4BaX3npTBfP9X9PtT9f
HpzmoOxKUtQPOYmzMMuwoqvmjanK/RYDY8pwB32h7nWWE2yy5V0Qd6qLcGiivn0=
=ldl8
-----END PGP SIGNATURE-----

--CPaaJmjEtnx7DmsZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
