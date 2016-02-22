From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Mon, 22 Feb 2016 12:30:22 +0100
Message-ID: <56CAF14E.3040907@rempel-privat.de>
References: <56C6DB9E.5080905@rempel-privat.de>
 <CAMuHMdW0P-uNBA94jvvVQqXH2c4DY45U4GnYufkPDQAqZm7u9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ADfftf0Ki4xqr11W1IbSrJbjIpIoMWGvJ"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
	<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW0P-uNBA94jvvVQqXH2c4DY45U4GnYufkPDQAqZm7u9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ADfftf0Ki4xqr11W1IbSrJbjIpIoMWGvJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 22.02.2016 um 10:21 schrieb Geert Uytterhoeven:
> Hi Oleksij,
>=20
> On Fri, Feb 19, 2016 at 10:08 AM, Oleksij Rempel <linux@rempel-privat.d=
e> wrote:
>> i'm working on a project which depends on 5 Wire SPI communication. It=

>> is probably identical to spi-davinci.c with SPI_READY signal. Only
>> difference is that SPI_READY is not supported by hardware, in this cas=
e
>> GPIO input is used.
>=20
> Sounds interesting!
>=20
>> Currently this project implements SPI_READY and CS on top of spidev
>> driver. What makes it really ugly, slow and complicated.
>=20
> Can you please point me to some SPI slave hardware that supports this?

It is automotive filed. Used for inter chip communication.
There are many products with it. Currently i can't say more :(

>=20
> Thanks a lot!
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker=
=2E But
> when I'm talking to journalists I just say "programmer" or something li=
ke that.
>                                 -- Linus Torvalds
>=20


--=20
Regards,
Oleksij


--ADfftf0Ki4xqr11W1IbSrJbjIpIoMWGvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbK8VMACgkQHwImuRkmbWk27QD+Kn9HP3Cwz9Ux4a2F2AJCvq13
Liqti3UOCbefXDNpx4cBAICvXe28owZ2+EvJszeBWykVTmZ/pVFjn5J/2/83Ni58
=ydrb
-----END PGP SIGNATURE-----

--ADfftf0Ki4xqr11W1IbSrJbjIpIoMWGvJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
