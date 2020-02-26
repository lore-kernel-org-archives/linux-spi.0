From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Date: Wed, 26 Feb 2020 14:03:00 +0100
Message-ID: <20200226130300.GB2800@duo.ucw.cz>
References: <20191212033952.5967-1-afaerber@suse.de>
 <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
 <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
 <E33E27B9-D33C-4182-A5B1-C72FA40470BC@easyb.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>,
        linux-realtek-soc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        csd-uX/v2g6dJhB25pISuqNqZg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sales-quSABqrs8DPQT0dZR+AlfA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        zypeng-Svy83JD6bw5Wk0Htik3J/w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezra Buehler <ezra-z8Bw++XM6qA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E33E27B9-D33C-4182-A5B1-C72FA40470BC-z8Bw++XM6qA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 13 Dec 2019, at 15:07, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> >=20
> > I also have one of the H96 Max boxes (which I picked up out of curiosity
> > for the mysterious RK3318) with an FD6551, although I've not attacked
> > that one with the logic analyser yet to see how similar it is.
>=20
> I have a T9 (RK3328) TV box with the same chip in it. The FD6551 uses an
> I2C-like protocol. Every digit (and the symbols) have an I2C address,
> but, the display does not signal ACK. AFAIK the FD650 and FD655 which
> are used in other boxes (Amlogic) are very similar.
>=20
> So far, I have whipped up a proof-of-cocept driver that uses i2c-gpio.
> The digits seem to be rotated by 180 degrees. So, in order to use
> map_to_7segment.h I had to define the BIT_SEG7_* constants differently.
> My display also has multiple symbols (WIFI, network, pause, play, USB,
> alarm) that are controlled by writing to the same address as for the
> colon.
>=20
> I=E2=80=99d love to work on a driver (similar to Andreas=E2=80=99 SPI bas=
ed driver) for
> these I2C connected chips.

Create a driver in drivers/auxdisplay for alphanumeric parts. You can
then export any remaining symbols as LEDs if it will provide benefits.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlZshAAKCRAw5/Bqldv6
8kZqAJ0eHpZJIq9KvRkuA970vGoHRW+FxwCfUVhxIMi58/nyPvs2Fhxkk2zlRec=
=UP4r
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
