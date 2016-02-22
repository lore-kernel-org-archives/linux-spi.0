From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Mon, 22 Feb 2016 12:42:59 +0100
Message-ID: <56CAF443.8010705@rempel-privat.de>
References: <56C6DB9E.5080905@rempel-privat.de>
 <20160220195641.GE18327@sirena.org.uk> <56C8DD64.1070700@rempel-privat.de>
 <20160222110948.GE18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HkT7i6kCCnDuWiNLXAvgBETgdN7CHlo1k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	"EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
	<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160222110948.GE18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HkT7i6kCCnDuWiNLXAvgBETgdN7CHlo1k
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 22.02.2016 um 12:09 schrieb Mark Brown:
> On Sat, Feb 20, 2016 at 10:40:52PM +0100, Oleksij Rempel wrote:
>=20
>> I would need some naming suggestions (we call our protokol SSI). It
>> looks like the protocol used by us has some differences with Davinci.
>> The Dav. using SPI_READY line only
>> to allow or pause transmission (fix me if i'm wrong)
>> We call it Request line and use it to: Ready to Receive; Receive
>> Finished; and Request data shift by slave.
>=20
> Oh, so this isn't SPI_READY?

Not 100%.
According to TI documentation, transfer initiated by master looks like:
1. Master: SPIx_CS (on)
2. Slave: SPIx_READY (on)
3. Master: Date transfer
4. Slave: SPIx_READY (off)
5. Master: SPIx_CS (off)

Bosch version of 5-wire transfer initiated by master:
1. Master: SPIx_CS (on)
2. Slave: SPIx_REQUEST (on)
3. Master: Date transfer
4. Master: SPIx_CS  (off)    <----- different order.
5. Slave: SPIx_REQUEST (on) <-----


>=20
>> In this case probably spi framework need to be extended with kind of
>> request call back. If data is currently not transmitted and Req line i=
s
>> not used for flow control, then call driver specific function to
>> initiate data shift.
>=20
> This is sounding awfully like SPI slave support?

Not completely. Transfer initiated by Slave has only one difference to
Master transfer.

Bosch version of 5-wire transfer initiated by slave:
1. Slave: SPIx_REQUEST (on) <----- different order.
2. Master: SPIx_CS (on)  <----
3. Master: Date transfer
4. Master: SPIx_CS (off)
5. Slave: SPIx_REQUEST (off)

--=20
Regards,
Oleksij


--HkT7i6kCCnDuWiNLXAvgBETgdN7CHlo1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbK9EcACgkQHwImuRkmbWkmHwD+PRz7D+zVQouk70MmJZXal7qO
ttq7dVTnU4sNZythDdcA/AnvkMmsnK3HwU4VCh+0fYqckIVDjrsyV2pgWR8FZhRH
=1MQl
-----END PGP SIGNATURE-----

--HkT7i6kCCnDuWiNLXAvgBETgdN7CHlo1k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
