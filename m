From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Sat, 20 Feb 2016 22:40:52 +0100
Message-ID: <56C8DD64.1070700@rempel-privat.de>
References: <56C6DB9E.5080905@rempel-privat.de>
 <20160220195641.GE18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="86fowTqkI0BuavvNqOlGEhUamPpNkieUR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160220195641.GE18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--86fowTqkI0BuavvNqOlGEhUamPpNkieUR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 20.02.2016 um 20:56 schrieb Mark Brown:
> On Fri, Feb 19, 2016 at 10:08:46AM +0100, Oleksij Rempel wrote:
>=20
>> i'm working on a project which depends on 5 Wire SPI communication. It=

>> is probably identical to spi-davinci.c with SPI_READY signal. Only
>> difference is that SPI_READY is not supported by hardware, in this cas=
e
>> GPIO input is used.
>=20
>> Currently this project implements SPI_READY and CS on top of spidev
>> driver. What makes it really ugly, slow and complicated.
>=20
>> My question is, are there any better, upstreamable way to implement it=
?
>> For example directly insight of spi framework? Any suggestions and
>> comments are welcome.
>=20
> Unless the hardware support SPI_READY a GPIO is going to be as good as
> it gets I think, someone else might have better ideas but nothing
> springs to mind for me.  I'd be OK with a GPIO based implementation in
> the core for systems that don't have hardware support for it but I don'=
t
> see anything that'd be fundamentally better in terms of system
> performance right now.
>=20

Ok, i'm working on it.

I would need some naming suggestions (we call our protokol SSI). It
looks like the protocol used by us has some differences with Davinci.
The Dav. using SPI_READY line only
to allow or pause transmission (fix me if i'm wrong)
We call it Request line and use it to: Ready to Receive; Receive
Finished; and Request data shift by slave.

In this case probably spi framework need to be extended with kind of
request call back. If data is currently not transmitted and Req line is
not used for flow control, then call driver specific function to
initiate data shift.

--=20
Regards,
Oleksij


--86fowTqkI0BuavvNqOlGEhUamPpNkieUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbI3WoACgkQHwImuRkmbWmgLwD/XfcYOzAlR2azyF7EWddcSvin
RpGWcWtU37oli8r0JjkA/j5iKfeVCAu1qayRex8Erb7a8ecUzc+aCyOjuMxVqvdE
=cqhL
-----END PGP SIGNATURE-----

--86fowTqkI0BuavvNqOlGEhUamPpNkieUR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
