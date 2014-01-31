From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Fri, 31 Jan 2014 11:49:35 +0000
Message-ID: <20140131114935.GA22609@sirena.org.uk>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
 <CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QBJnsLb0QyYEYRYK"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QBJnsLb0QyYEYRYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2014 at 08:49:45AM +0100, Geert Uytterhoeven wrote:

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -829,6 +829,9 @@ void spi_finalize_current_message(struct spi_master *=
master)
>           queue_kthread_work(&master->kworker, &master->pump_messages);
>           spin_unlock_irqrestore(&master->queue_lock, flags);
>=20
> +         if (!mesg)
> +                 return NULL;
> +

Note that this is for transfers, not for messages, and we don't change
the completion path for the message here so I'm not sure why the message
would be affected?  That said there is definitely an issue here - we
should probably be adding some sort of error teardown callback to try to
stop the hardware if we do hit a timeout.

--QBJnsLb0QyYEYRYK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS643MAAoJELSic+t+oim9Ej8P+wfsoaNb+JGFKVNVX4geQkx3
Y3zWav5nunjMYuntgl7G5HQMoxoXiQyKfwDMer4iRzRlmiDw0ILYyMluBDdF5lOT
M1VS/LhRzoWPaV1tMvaBbFKQ2kiTEHb/+bWiqje++yNtiltF/yJVp953GFnsQH4E
6uBatMJSoy+Z7QvxeP14OlEDmcGaOGKhEj0A1HXvnA3FDAh3WeonXx8E5drgrcL1
PgQ18KhqK26c+EK9zMwnjy2X9WNcL3rQo1p8+qm52TYI2x04Dv0CIAvo5Mo5brbv
ptbJM/KdX+VR0uYIWFPrBwFZjVrL0/1JAwvNmj9vg1mwJV1bvSEsHDCS9Ug4SSSD
y9NeYqnMlmAf+dZGPIhBE4AGl/N9jsMBzBkO8pYlg79vWajCO5HwwuRzImQa5wEQ
t8JrkEUkNLLVemyx2re6CzihNT5qCRBqKphCeELUonEN/JEZavdl5+qR7RCs5DuC
9r2dwiTqfWmDgI0Ww0/zhYbVKYRl7GgvBSqD5/I9KSOBJD2ydu9wh/KQzGw2jdCA
JhWgoDozN866rTpWLI2hgORLiSq5ERZHPhCmJ1FdWsku5XO+Oj6x3O8zoz04Zy+B
bvB2mGKEbz+G2eDsqSSFyYOCRlBUKUXISXfWglqeF3X0UYe4cgP5VAMirfB6hmbN
0jVA6UgnBayK7A+KsTj1
=HRVE
-----END PGP SIGNATURE-----

--QBJnsLb0QyYEYRYK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
