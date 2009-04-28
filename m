From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the
	OpenCores SPI controller.
Date: Tue, 28 Apr 2009 14:20:11 +0200
Message-ID: <20090428122011.GB6325@avionic-design.de>
References: <200904041227.54687.david-b@pacbell.net> <1240916464-4187-1-git-send-email-thierry.reding@avionic-design.de> <20090428111532.GA14422@avionic-design.de> <200904280458.23018.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759230AbZD1MUb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904280458.23018.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

* David Brownell wrote:
> On Tuesday 28 April 2009, Thierry Reding wrote:
> > This second version is pretty much a rewrite.
>=20
> That happens sometimes...
>=20
>=20
> > Some notes about the most=20
> > important changes:
> >=20
> > =C2=A0 * uses per-chip states to allow more slaves to use the contr=
oller
> > =C2=A0 =C2=A0 concurrently
> > =C2=A0 * rejects invalid device configurations during setup
> > =C2=A0 * rejects invalid per-message and per-transfer options
> > =C2=A0 * queues messages so that they can be processed one after an=
other
> > =C2=A0 =C2=A0 =C2=A0 - this also provides for a way to handle power=
-management
> > =C2=A0 * omits the spioc.h (and with it the platform data structure=
):
> > =C2=A0 =C2=A0 =C2=A0 - uses the platform_device.id for the bus numb=
er
> > =C2=A0 =C2=A0 =C2=A0 - always uses 8 chipselects because that's the=
 maximum that the core
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 supports
>=20
> All that sounds good.
>=20
> =20
> > I couldn't really find a way to implement per-transfer overrides fo=
r the
> > word size because the controller simply has no concept of word size=
s. Is it
> > in such cases still necessary to hardwire the word size to 8 bits?
>=20
> Is this the http://www.opencores.org/?do=3Dproject&who=3Dspi core?

Yes, it is.

> Its summary says "Variable length of transfer word up to 32 bits";
> does that mean "configurable when core is synthesized" instead of
> truly "variable"?

That summary seems out-dated. The variable length of transfer word is
actually the maximum length of a single transfer and is 128 bits in the
latest version. So you get 4 registers, each 32 bits wide into which yo=
u
program the data you want to transfer. Then you set the number of bits =
of
that transfer so the core knows which registers and what bits of those
registers to shift out serially.

I'm not sure whether this is supposed to be the same as the word size. =
If it
is it would mean that a single transfer can always only transfer one wo=
rd.
Which is kind of inefficient, I would think.

Thierry
