From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 6 Jan 2016 15:22:01 +0800
Message-ID: <20160106152201.7829bdd7@xhacker>
References: <20151223192338.128e95a4@xhacker>
	<20151223121512.GV16023@sirena.org.uk>	<20151223202952.28be5bab@xhacker>
	<20160105161231.GG6588@sirena.org.uk>
	<CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
	<20160106142340.34e2d334@xhacker>
	<CAFLsZf31bt+-uwTo3zBWkho3UxquRCeTmK3hNMrGLXkjwHanwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Khoa Dang Pham <kpham-qTEPVZfXA3Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFLsZf31bt+-uwTo3zBWkho3UxquRCeTmK3hNMrGLXkjwHanwA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Dear Khoa,

On Wed, 6 Jan 2016 14:04:30 +0700 Khoa Dang Pham wrote:

> Hi Jisheng,
>=20
> On Wed, Jan 6, 2016 at 1:23 PM, Jisheng Zhang wrote:
> > Dear Khoa, Mark,
> >
> > On Wed, 6 Jan 2016 08:45:38 +0700 Khoa Dang Pham wrote:
> > =20
> >> Hi Mark,
> >>
> >> May I provide a bit more info about the "EEPROM read" on this cont=
roller?
> >>
> >> According to the "DesignWare DW_apb_ssi Databook" (version 3.21b) =
provided
> >> by Synopsys, the EEPROM read is:
> >>
> >> "When TMOD =3D 2=E2=80=98b11, the transmit data is used to transmi=
t an opcode and/or
> >> an address to the EEPROM
> >> device. Typically this takes three data frames (8-bit opcode follo=
wed by
> >> 8-bit upper address and 8-bit lower
> >> address). During the transmission of the opcode and address, no da=
ta is
> >> captured by the receive logic (as
> >> long as the DW_apb_ssi master is transmitting data on its txd line=
, data on
> >> the rxd line is ignored). The
> >> DW_apb_ssi master continues to transmit data until the transmit FI=
=46O is
> >> empty. Therefore, you should
> >> ONLY have enough data frames in the transmit FIFO to supply the op=
code and
> >> address to the EEPROM. If
> >> more data frames are in the transmit FIFO than are needed, then re=
ad data
> >> is lost.
> >> When the transmit FIFO becomes empty (all control information has =
been
> >> sent), data on the receive line
> >> (rxd) is valid and is stored in the receive FIFO; the txd output i=
s held at
> >> a constant logic level. The serial
> >> transfer continues until the number of data frames received by the
> >> DW_apb_ssi master matches the value of
> >> the NDF field in the CTRLR1 register + 1." =20
> >
> > I tried the following combinations:
> >
> > 1. "Transmit only" to send opcode and address, "Receive only" to re=
ad the
> > response
> >
> > 2. "Transmit and Receive" to send opcode and address, "Receive only=
" to read
> > the response
> >
> > 3. "Transmit and Receive" to send opcode and address, "Transmit and=
 Receive"
> > to read the response
> >
> > 4. "Transmit and Receive" only to send opcode and address
> >
> > None of the above succeed. I only succeed when using
> >
> > 5. EEPROM Read to send opcode, address. I can get the correct NOR f=
lash
> > content from the response.
> > =20
>=20
> I met the same issue before. The issue might be caused by the CS
> signal is toggled
> when we changed the transfer modes during opcode transmission and dat=
a
> receiption.
>=20
> According to the document I referred before:
> "The slave select line is held high when the DW_apb_ssi is idle or
> disabled."
>=20
> In your first 4 options, you need to disable this controller to write
> to the CTRLR0 register
> in order to switch the transfer modes. The CS line changes from low
> level (active) to high
> level (inactive) during the configuration. The NOR flash sees this CS
> toggle as a reset and
> stops outputting requested data.

Thanks for the information. This could explain what I saw. So how to
patch the spi-dw driver to support reading from NOR flash? Except
configure the tmode dynamically, is there any other solution?

Thanks very much for your input,
Jisheng

>=20
> Regards,
> Khoa Pham
>=20
> > Thanks,
> > Jisheng
> > =20
> >>
> >> Regards,
> >> Khoa Pham
> >>
> >> On Tue, Jan 5, 2016 at 11:12 PM, Mark Brown  wrote:
> >> =20
> >> > On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote: =20
> >> > > On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote: =20
> >> > > > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrot=
e: =20
> >> > =20
> >> > > > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_c=
ontrol is =20
> >> > NULL, but we =20
> >> > > > > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my=
 solution =20
> >> > is to add and =20
> >> > > > > export one functions to set the tmode, then the nor flash =
driver =20
> >> > call it =20
> >> > > > > before reading and set back to SPI_TMOD_TR after done. =20
> >> > =20
> >> > > > What does this mean - what is TMOD and why do we need to set=
 it to read
> >> > > > NOR flash?  I've no information on this controller... =20
> >> > =20
> >> > > TMOD is one field of DW_SPI_CTRL0. Its available value could b=
e: =20
> >> > =20
> >> > > 0: Transmit and Receive
> >> > > 1: Transmit only
> >> > > 2: Receive only
> >> > > 3: EEPROM Read =20
> >> > =20
> >> > > If the one spi nor flash is connected to the SPI host, so far =
I can only =20
> >> > succeed =20
> >> > > to read the nor flash content after setting the TMOD field as =
3. =20
> >> >
> >> > Why?  What does this mean in practical terms at the hardware lev=
el, what
> >> > is "EEPROM read"?  It sounds like there's some bigger issue here=
=2E
> >> > =20
> >> =20
> > =20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
