From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 12:04:36 +0200
Message-ID: <20150427100436.GP5627@lukather>
References: <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather>
 <CAOMqctR5NiuZ2T3wYOpqu6Ez1yk7U9VoxDZHBT6uEqftRN_Z-g@mail.gmail.com>
 <20150426155404.GL5627@lukather>
 <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2015 at 08:53:16PM +0200, Michal Suchanek wrote:
> >> Also for driver prototyping you need a compatible which makes the
> >> device accessible.
> >>
> >> If no spidev general compatible is available people will just use
> >> compatible for some random device which happens to bind to spidev and
> >> will send many letters of thanks to the DT maintainers when the device
> >> used for this purpose suddenly grows a Linux driver.
> >
> > If people do dumb things, they should expect it to backfire.
>=20
> Yes, dumb things like not allowing people to say in the DT that the
> board actually has pins on it connected to a SPI bus. Which is the
> actual hardware which should be described in the DT.

It's not connected to an SPI bus. It's connected to a device using an
SPI bus. If you just had floating SPI lines, I'm pretty sure you
wouldn't care about spidev at all.

> Do you have to describe a modem or terminal emulator in DT to connect
> it to your serial port? You just describe the port. So here you have a
> SPI port and it should be described in the DT as faithfully as the
> serial port.

Except that in the serial port, you have a representation of a bus,
while spidev represents a *device* connected on an SPI bus. So these
are two different things, really.

> >> >> > https://lkml.org/lkml/2014/4/28/612
> >> >> >
> >> >> >> But how do you know there is a device?
> >> >> >>
> >> >> >> Devices on i2c can be probed. On spi you just transfer random da=
ta and
> >> >> >> hope it does something useful. Some devices have readable regist=
ers
> >> >> >> and can be probed in a device-specific way but others are write-=
only.
> >> >> >
> >> >> > Well, what's the point of communicating with a non-existent devic=
e in
> >> >> > the first place?
> >> >>
> >> >> I have multitude of SPI devices which are not part of the board and
> >> >> hence its DT and can be connected to the board with jumper wires.
> >> >>
> >> >> Most of them don't have a linux driver or compatible to bind with.
> >> >
> >> > Then create such a compatible...
> >>
> >> I will if and when the device is usable.
> >
> > That's backward. The fact that your "driver" works really doesn't
> > depend on what the device actually is.
>=20
> Indeed.
>=20
> However, for the device to have a compatible the compatible must be
> specified in a driver and then I need a driver for the device to
> record the compatible in.
>=20
> Or do you suggest that I patch the compatible into spidev, write a
> driver for it, and then back out the compatible from spidev and check
> in the compatible again with the driver?
>=20
> Now that is backwards.

What Mark was suggesting was that you add a compatible to the spidev
driver, and then you have access to spidev from userspace, period.

If later on, you introduce a real driver for that, then yes, you would
have to remove the compatible from spidev, and have that matching
compatible in that new driver.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPgm0AAoJEBx+YmzsjxAgbz8P/A8//4ks4kGrtzibNAUch7Ik
rmbue9Rn/UGQCh8HDgR8y2PglgJmogurYmHhP8+0STHGF7MGtELLEcev4sPbMxau
St8EBuoU729/i8PYsttWvl/7n3dYKPZVgoBCgyvNtyXrj/nXHltlhNPqHkqoW/3o
R88sgulpAZC/iHwhDlYadqYlUaDjAPOjrwjG5qgQ0ero+ndDN1/NOulVStQBW88o
T/lNGwtvXwcTb+DBCFFsFJFkq97NA0Y7Fkc2yTpGkftNddCfQJHNCkPKZePvzTDJ
VzMoxkdt+62frC/ZLBsLoW2WQXqoLNPuZzXeyvr/GqCmA1yCCg0AV03zRHdfjnEA
+ZXwzdj3O5eNdz4x1dah51vWEf0Hkk/mNGMCQvxZNOUH8XAHTB1Qlx6rt/L1qdEP
V5tbhfBeVuDSdBGMSC1OPdW06jnM1ue0ygSbff3k7O0m8aZdYsAux5v1rR44adDV
6DVIisdUCBLKPAGERJ9mCWllnV7ZsrIylCRtWZc8C5cKrmlRnN9M8rXYjjjYHd2z
UxdfrbDHzG9WY7BAONkv1DgvDZe5qs1IZWoKRbPRiZ8i/fDLpDKpuaH1aSuY7l8C
QXJPr4nTcY+mvO6wFuO9/pm6kgjCMatVj+nB20q51JXu4JP6/lroljF4DcYlWMJl
N0DnXhFypkJzsAYmQFdx
=J1of
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
