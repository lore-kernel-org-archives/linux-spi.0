From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH] gpio: gpio driver for max7301 SPI GPIO expander
Date: Thu, 12 Jun 2008 10:00:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806120958450.18017@axis700.grange>
References: <Pine.LNX.4.64.0806061625260.3338@axis700.grange>
 <200806120015.50953.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757324AbYFLIAn@vger.kernel.org>
In-Reply-To: <200806120015.50953.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 12 Jun 2008, David Brownell wrote:

> Some comments about one routine; presumably more to follow:

Thanks, David, I'll pass your comments on to the author and try to get=20
them acted upon.

Thanks
Guennadi

>=20
>=20
> On Friday 06 June 2008, Guennadi Liakhovetski wrote:
> > +/**
> > + * max7301_read - Read back register content
> > + * @spi: The SPI device
> > + * @reg: Register offset
> > + *
> > + * A read from the MAX7301 means one message with two transfers
>=20
> That's not what you implement though ... what it needs is:
>=20
> 	- transfer #1:
> 		* select
> 		* write 16 bit command, discard rx data
> 		* deselect
> 	- transfer #2
> 		* select
> 		* write 16 bit command, saving rx data
> 		* deselect
>=20
> That's from the data sheet.  Now, that *could* be implemented
> with a single message ... or, as you do, with two messages.
>=20
> You should at least correct the comment, if you don't want to
> switch to a slightly faster single-message implementation.  :)
>=20
>=20
> > + *
> > + * Returns positive 8 bit value from device if successfull or a
> > + * negative value on error
>=20
> Actually it returns a 16 bit value... also, "successful" has one "l".
> You seem to have forgotten to mask off the high byte ...
>=20
>=20
> > + */
> > +static int max7301_read(struct spi_device *spi, unsigned int reg)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0int ret;
> > +=A0=A0=A0=A0=A0=A0=A0u16 word;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0word =3D 0x8000 | (reg << 8);
> > +=A0=A0=A0=A0=A0=A0=A0if ((ret =3D spi_write(spi, (const u8*)&word,=
 siz
>=20
> > eof(word))) !=3D 0)=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > +=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0 * FIXME: This read should write 0x0000 (=3DN=
OOP at MAX7301 side)
>=20
> Take out this FIXME, and just replace it with a note that this relies
> on the fact that TX always shifts out zeroes if there's no data speci=
fied.
>=20
> > +=A0=A0=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0=A0=A0if ((ret =3D spi_read(spi, (u8*)&word, sizeof=
(word))))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > +=A0=A0=A0=A0=A0=A0=A0return word;
> > +}
> > +
>=20
>=20
> Oh, and in the probe():
>=20
> > +=A0=A0=A0=A0=A0=A0=A0spi->master->setup(spi);
>=20
> should be
>=20
> 	ret =3D spi_setup(spi);
> 	if (ret < 0)
> 		return ret;
>=20
> It's quite possible that something get misconfigured, so you end up t=
rying
> to talk through a spi_master controller that doesn't support 16-bit w=
ords.
>=20
> - Dave
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
