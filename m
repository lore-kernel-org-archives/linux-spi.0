From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: use platform drvdata correctly in
 rspi_remove()
Date: Fri, 15 Nov 2013 10:28:59 +0000
Message-ID: <20131115102859.GY26614@sirena.org.uk>
References: <CAPgLHd9kYK9p9K=6DycGJXHF4J-vygD4v4puOoZLbCuF6LaLFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zll6mx50Q8J7qlLQ"
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9kYK9p9K=6DycGJXHF4J-vygD4v4puOoZLbCuF6LaLFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zll6mx50Q8J7qlLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:44:02PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> We had set the platform drvdata in rspi_probe() as a type of
> struct rspi_data, but use it as struct spi_master in rspi_remove()
> Fix by remove the unnecessary spi_master_[get|put]() since rspi->master
> is no longer used after spi_unregister_master().

Applied, thanks.

--Zll6mx50Q8J7qlLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfdnAAoJELSic+t+oim9Vd4QAJvdpuyxNyKCuF7v28LZ1pMl
7PV2fGMxi/vLPNUmIoEgV2MBssq7um5J9DgyPfGvNl/BhyqgC0ubmDRCq09XfxO+
KZtgiS19nvLoip9ggrW1JXPM7qwWPuNM6mM0oQuTZ8WbwXRCTyVFFm65RG3A6IcZ
Slf3vJBw+d9EF83kQMaDQvcw3jvgYjg5DZTA8zbiBosB23wcWfhwSFYSyqJTgY6H
rUcMJIBzE4J+pw747o7PTTk4s5f2QpXmbnKwf4qN7Izg/jM+9fxoRfZx0HsOYEbF
MEGyDZHwE6kLiB0+WgcDiLvt6R694vc9uXquejHLRwqDT9U0tZdKERxan9B7giZf
K62LdMMioqx+rzTBCxBt4niFEFIbSx2Okqkkt+CrkJ2Tq045LkMaaCm/C0otZ87F
mK8dIMByo/GzhG4qunJSCiTfGps2GRGdIIhjerCADnOADkAvTSngeA5bP9//Qqv8
QPUR03AMVqzpzoqDzNlCXOzqxpO894q+aVPZ1P+BAH88F2KCkgWgxqV0ausHEBrq
TxsUsA/EOcbKWiaIMxU3q8WZmvYz2iPpIT1FZIueHObfw563fHGZ3tMV6xCyJ+QL
uKXo3XvPwhzbWCWXLbtO8w6XvzK2HkqFWBXM/LOUJvv7+lLuuo0WSsNrcUYYr/lD
QdgruCNKWwqKn/YSPkAc
=w8fW
-----END PGP SIGNATURE-----

--Zll6mx50Q8J7qlLQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
