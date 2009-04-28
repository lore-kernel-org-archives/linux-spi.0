From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the OpenCores SPI controller.
Date: Tue, 28 Apr 2009 15:41:20 +0200
Message-ID: <200904281541.21238.florian@openwrt.org>
References: <200904041227.54687.david-b@pacbell.net> <200904280458.23018.david-b@pacbell.net> <20090428122011.GB6325@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756860AbZD1Nlg@vger.kernel.org>
In-Reply-To: <20090428122011.GB6325@avionic-design.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le Tuesday 28 April 2009 14:20:11 Thierry Reding, vous avez =C3=A9crit=C2=
=A0:
> * David Brownell wrote:
> > On Tuesday 28 April 2009, Thierry Reding wrote:
> > > This second version is pretty much a rewrite.
> >
> > That happens sometimes...
> >
> > > Some notes about the most
> > > important changes:
> > >
> > > =C2=A0 * uses per-chip states to allow more slaves to use the con=
troller
> > > =C2=A0 =C2=A0 concurrently
> > > =C2=A0 * rejects invalid device configurations during setup
> > > =C2=A0 * rejects invalid per-message and per-transfer options
> > > =C2=A0 * queues messages so that they can be processed one after =
another
> > > =C2=A0 =C2=A0 =C2=A0 - this also provides for a way to handle pow=
er-management
> > > =C2=A0 * omits the spioc.h (and with it the platform data structu=
re):
> > > =C2=A0 =C2=A0 =C2=A0 - uses the platform_device.id for the bus nu=
mber
> > > =C2=A0 =C2=A0 =C2=A0 - always uses 8 chipselects because that's t=
he maximum that the
> > > core supports
> >
> > All that sounds good.
> >
> > > I couldn't really find a way to implement per-transfer overrides =
for
> > > the word size because the controller simply has no concept of wor=
d
> > > sizes. Is it in such cases still necessary to hardwire the word s=
ize to
> > > 8 bits?
> >
> > Is this the http://www.opencores.org/?do=3Dproject&who=3Dspi core?
>
> Yes, it is.
>
> > Its summary says "Variable length of transfer word up to 32 bits";
> > does that mean "configurable when core is synthesized" instead of
> > truly "variable"?

This is indeed configured at synthesis time.

>
> That summary seems out-dated. The variable length of transfer word is
> actually the maximum length of a single transfer and is 128 bits in t=
he
> latest version. So you get 4 registers, each 32 bits wide into which =
you
> program the data you want to transfer. Then you set the number of bit=
s of
> that transfer so the core knows which registers and what bits of thos=
e
> registers to shift out serially.
--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
