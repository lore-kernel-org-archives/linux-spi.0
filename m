From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] regmap: Add eplicit dependencies to catch "select"
 misuse
Date: Sun, 17 Aug 2014 07:31:33 -0500
Message-ID: <20140817123132.GA2863@katana>
References: <1408270138-29811-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408270138-29811-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2014 at 12:08:57PM +0200, Geert Uytterhoeven wrote:
> Add explicit dependencies for the various regmap modules, so Kconfig
> will print a warning message when another module selects a regmap module
> without fulfilling its dependencies.
>=20
> Without this, it's much more difficult to find out which module did the
> offending select.
>=20
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8KCkAAoJEBQN5MwUoCm2HeIP/2ZIAC6VYd0ayPPUIQl4JQ1n
+YL4tfff/yGSQGWlfci7sbm0RTvrb4sEPF1vsOc0PuTDlwaZKHvYpgYLf9JvZStb
LqWHI9FF3MgawG45twvM59UifPa48PX949o4zxHQJRcReRWzjDjrkYHImKLGGOUk
kd7XyfmgHFm6k37u8UF9LkLqTZ4mL/4QbRbQzbiOymohqbO4Wsbgai8ZiKtDVAr9
hrNCFB0+ZHSVHpfyKuxR8PRNMzSItec6I2NBvd8pdlyRFHJ2u3FUCJMWQSXQVuev
LqbsNaqeKCOD4Qfxd8yHqmUrNFk3mhzr93JXrmHa++T4OsGU72NZecW2hz8B+UCf
+d6FEggpZWkR6ZNzrzxxTv6/QSJCiXgwxFokoTJuISNwytOdEvfmM/+18Y/EiBdt
77wDswfxl9Mtu6RRITEShwhsRJ5PaPMB6DnCC2qkOHb2mMrcKlIPF5fVgYLQu+HB
HS6C0Cq/AcxUmNj1DQ/Ee/38v0aykIKJjnQFlT4wMu+HQWzDoi7t2Avn8aFVNr50
RMBJjXwX/u+IvtE3ltZNAuInYVdusCxD76MYDpo9ZNv1CbjjOO/QwUzG26dOIgFC
Q6aLWeIciPUx6qBgY54bFKmd+ngBfZ7GfG5mJpCiRb5T+hUvhU0A0lHdWuyhURsZ
ISkYA6xWBn85OQSL925Y
=FsWB
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
