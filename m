From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Thu, 20 Aug 2015 11:36:34 -0700
Message-ID: <20150820183634.GN12027@sirena.org.uk>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FX+Db2fp7WJhXKrW"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440054451-1223-19-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FX+Db2fp7WJhXKrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 09:07:31AM +0200, Javier Martinez Canillas wrote:
> From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>=20
> An SPI driver that supports both OF and legacy platforms, will have
> both an OF and SPI ID table. This means that when built as a module,
> the aliases will be filled from both tables, e.g:

This is tagged as something that can't be applied but you've not
explained why it can't be applied or what comments might be useful :(

--FX+Db2fp7WJhXKrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1h4xAAoJECTWi3JdVIfQWQ4H/3pcnIVJhYNDBko1XGJVvzPn
RaHqaNrUIs3iyiBrtIUf3jJddmq7j9El3S42EInXaxh7PqveLiGep771/+bD3x+7
LASGg1LKM2EIRYwNb0tnTx/gyWcuJ23g7eXwM4xEuUfcdjsKkg7xEyFRc+OusfjZ
e0JjyDjGAITJuGkj0SiYYMRB2amu8Yx4g2VXOmvSJaGS5S9BcbqgI2bz3rZRa0af
E7YC8mfd3fAXoaM+NXTZb4TEFaISeG8N9NYuhKSE2T3GbggbvVaF7EOu/VyfPUs/
vWJm0Pgb3o/cJXH1coXDaVzvNVzrIO8aDvbITsRJx1cpDcr2fb1TU1eVFiDRnJo=
=Ridd
-----END PGP SIGNATURE-----

--FX+Db2fp7WJhXKrW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
