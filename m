From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Sun, 13 Mar 2016 15:18:00 +0100
Message-ID: <56E57698.3050707@rempel-privat.de>
References: <56C6DB9E.5080905@rempel-privat.de>
 <20160220195641.GE18327@sirena.org.uk> <56C8DD64.1070700@rempel-privat.de>
 <20160222110948.GE18327@sirena.org.uk> <56CAF443.8010705@rempel-privat.de>
 <20160312072132.GA3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ERVQx5RqCW57jRf9EPjJeIxPuaV4lJcNr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	"EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
	<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160312072132.GA3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERVQx5RqCW57jRf9EPjJeIxPuaV4lJcNr
Content-Type: multipart/mixed; boundary="UNqoGruGsSm0dcGLfGIjIGMcgq8JXpj3h"
From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
 "EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
 <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Message-ID: <56E57698.3050707-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
References: <56C6DB9E.5080905-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
 <20160220195641.GE18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> <56C8DD64.1070700-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
 <20160222110948.GE18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> <56CAF443.8010705-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
 <20160312072132.GA3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
In-Reply-To: <20160312072132.GA3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>

--UNqoGruGsSm0dcGLfGIjIGMcgq8JXpj3h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 12.03.2016 um 08:21 schrieb Mark Brown:
> On Mon, Feb 22, 2016 at 12:42:59PM +0100, Oleksij Rempel wrote:
>> Am 22.02.2016 um 12:09 schrieb Mark Brown:
>=20
>>> Oh, so this isn't SPI_READY?
>=20
>> Not 100%.
>> According to TI documentation, transfer initiated by master looks like=
:
>> 1. Master: SPIx_CS (on)
>> 2. Slave: SPIx_READY (on)
>> 3. Master: Date transfer
>> 4. Slave: SPIx_READY (off)
>> 5. Master: SPIx_CS (off)
>=20
>> Bosch version of 5-wire transfer initiated by master:
>> 1. Master: SPIx_CS (on)
>> 2. Slave: SPIx_REQUEST (on)
>> 3. Master: Date transfer
>> 4. Master: SPIx_CS  (off)    <----- different order.
>> 5. Slave: SPIx_REQUEST (on) <-----
>=20
> I can't tell the difference between these two cases.  In the first case=

> the device gets busy after the data is transferred, in the second case
> it never changes the request line but really there's no meaningful
> difference I can see.
>=20

There is no difference from device point of view, the difference is only
on Master side. The TI SPI Master can be stopped by Slave in the middle
of transfer, and if the data transfer was actually done, then Master
will dessert CS line.
This is why i'm trying to make a difference between slaves which will
only confirm start of transfer but will never try to stop it, and Slaves
which will do it.
Because if device can use Ready line to hold or stop data transfer, then
this support can be implemented only by limited number of SPI Master
controllers (for example, currently only by: spi-davinci and spi-gpio).

In case of Bosch implementation, the slave should actually confirm
change of CS.
--=20
Regards,
Oleksij


--UNqoGruGsSm0dcGLfGIjIGMcgq8JXpj3h--

--ERVQx5RqCW57jRf9EPjJeIxPuaV4lJcNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbldp0ACgkQHwImuRkmbWmQ4wEAlmNOeWux0zYTtdju+kBhO+DX
KdQR7EWTzIQSUWYnN9ABAIRj5vsHFhm6j/ibIlm0nln1AXXl+qw4D1HXvRfSCYMV
=PPM0
-----END PGP SIGNATURE-----

--ERVQx5RqCW57jRf9EPjJeIxPuaV4lJcNr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
