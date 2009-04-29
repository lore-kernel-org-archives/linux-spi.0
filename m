From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the OpenCores SPI controller.
Date: Wed, 29 Apr 2009 11:15:34 +0200
Message-ID: <200904291115.34847.florian@openwrt.org>
References: <200904041227.54687.david-b@pacbell.net> <200904281354.12192.david-b@pacbell.net> <20090429063104.GB7784@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755976AbZD2JPv@vger.kernel.org>
In-Reply-To: <20090429063104.GB7784@avionic-design.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le Wednesday 29 April 2009 08:31:04 Thierry Reding, vous avez =E9crit=A0=
:
> * David Brownell wrote:
> > On Tuesday 28 April 2009, Florian Fainelli wrote:
> > > > > Is this the http://www.opencores.org/?do=3Dproject&who=3Dspi =
core?
> > > >
> > > > Yes, it is.
> > > >
> > > > > Its summary says "Variable length of transfer word up to 32 b=
its";
> > > > > does that mean "configurable when core is synthesized" instea=
d of
> > > > > truly "variable"?
> > >
> > > This is indeed configured at synthesis time.
> >
> > Now I'm confused again.  Thierry says (below) that the number of bi=
ts
> > can be set per-"transfer".
> >
> > Now, I can easily understand that a *maximum* would be configured
> > at synthesis time ... if there's a 32-bit CPU or DMA engine, it'd
> > make very limited sense to interact using 128-bit I/O words.

The maximum size of the FIFO is configured at synthesis time should hav=
e made=20
this clear before, sorry for the confusion.

>
> I can't really comment on the synthesis because I'm not involved with=
 that
> part. What I was saying that the core provides a field in the control
> register which defines the number of bits to transfer from/to the
> transmit/receive registers. The maximum number of bits that can be
> specified in this way is 128.

Yes, which matches the FIFO size configured in the IP at synthesis time=
=2E

>
> > Is there both a configurable maximum, *and* a word-size setting tha=
t
> > can be changed on the fly?  That's what I would expect; it's what
> > most other designs do.  The only time I've seen fixed "you must use
> > N-bit words" designs is on cost-eradicated 8-bit microcontrollers.
>
> Perhaps that maximum number of bits that can be set through the contr=
ol
> register is what can be configured at synthesis time.

Provided that your FIFO is 128-bits, you can of course ask the core to =
do up=20
to the FIFO-size transfers for instance provided that you do not exceed=
 the=20
size of the FIFO. The later can obviously not be changed on-the-fly sin=
ce=20
physical resources of the FPGA for this should be reserved at synthesis=
 time.=20
Of course, one could use partial reconfiguration to increase the size, =
but=20
that's slightly off-topic ;)
--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
