From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove unused pointer in omap1_spi100k_txrx_pio()
Date: Mon, 10 Feb 2014 11:09:50 +0100
Message-ID: <xa1tlhxji8i9.fsf@mina86.com>
References: <20140208190223.45d1dcf8@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140208190223.45d1dcf8@spike>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08 2014, Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org> wrote:
> Remove unused devdata pointer 'spi100k' in function omap1_spi100k_txrx_pi=
o().
>
> Detected by Coverity: CID 1077869.
>
> Signed-off-by: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>

Acked-by: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>

> ---
> Applies against v3.14-rc1 as well as branch for-next in tree
> git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> ---
>  drivers/spi/spi-omap-100k.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 0d32054..8eaf0cd 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -204,12 +204,10 @@ static void omap1_spi100k_force_cs(struct omap1_spi=
100k *spi100k, int enable)
>  static unsigned
>  omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  {
> -	struct omap1_spi100k    *spi100k;
>  	struct omap1_spi100k_cs *cs =3D spi->controller_state;
>  	unsigned int            count, c;
>  	int                     word_len;
>=20=20
> -	spi100k =3D spi_master_get_devdata(spi->master);
>  	count =3D xfer->len;
>  	c =3D count;
>  	word_len =3D cs->word_len;
> --=20
> 1.8.3.2

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>--<xmpp:mina86-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJS+KVuAAoJECBgQBJQdR/0g5QP/R16cop9xeWGN4mqyGbiHXEv
z2fMiDIs7FGOpwonvDU3caWRJ8vuvueXSNk0xNUMn6517eiVt5dKgwwQ22zH5JkL
KPOtGuIplHKA15gSVxturE8P7uo0gpE9VGAzWJXRrhvhchqbp0qngM5p9Pf9E9Y+
jmjm1P3zlnBM9pc09TMJf0ZVZ/AWyxoDkxGJFoC2iaiMo0OfVxlCL4sf5Q9FiJyZ
+LC4+eYSSrGbSOpWcB0ytAsaWVNFL+A/2oXkIXstyhoTjY1mUbW1Zdy2uE9FHS3/
26XNDN1C4cLkavZiTn43BhTAMF4PlBYyJFnU4S8V29EPCJP9JSLfj6Oa8bvrWGwJ
2t/5OKmS9hd7Z7FozzQ2AmT7KyU9XJIFSUyWXtlgw4jDjp7cOjzURMEKUE8VP6iv
6wxbWPOqr3WouW7QGIXMc1Jszg2bRrise6n+PWc5aheaZwFs//bk+K/rEd9EaDCT
TgEM7FtqEzxSBeIF9OmCzMvg8Cqntz8+2FpnwiH/7GF4pcWTwPyweLqZEDFX3HWj
SefFPudvv2sntBqsKUmt5/AOulp64SOPfjDNXWUIFghEqy/j+EoWog8DSI4g0cko
8QhzfkVY24CzX6vjp6YQWp0au0+RTUbhVn2ZPEgWDbzRdMupl/9dEuLcnHNXPf7w
UfqiH+zDNyAARTBHJEf0
=XQvO
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
