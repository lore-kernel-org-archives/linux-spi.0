From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 6 Jan 2016 15:45:40 +0800
Message-ID: <20160106154540.15ff75a8@xhacker>
References: <20151223192338.128e95a4@xhacker>
	<20151223121512.GV16023@sirena.org.uk>	<20151223202952.28be5bab@xhacker>
	<20160105161231.GG6588@sirena.org.uk>
	<CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
	<20160106142340.34e2d334@xhacker>
	<CAFLsZf31bt+-uwTo3zBWkho3UxquRCeTmK3hNMrGLXkjwHanwA@mail.gmail.com>
	<20160106152201.7829bdd7@xhacker>
	<CAFLsZf3pdk6EdTRoax7Mp5GGZoGKm4PuwMdG2nC-hr+StYwYQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Khoa Dang Pham <kpham-qTEPVZfXA3Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFLsZf3pdk6EdTRoax7Mp5GGZoGKm4PuwMdG2nC-hr+StYwYQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ linux arm kernel

Dear Khoa,

On Wed, 6 Jan 2016 14:36:08 +0700 Khoa Dang Pham  wrote:

> Hi Jisheng,
>=20
> For me, I use the "EEPROM Read" mode as well, but I am not sure if an=
y
> other solution. We may need some feedbacks from other experienced
> developers.

Indeed, this is a common issue for spi-dw controllers, all spi-dw users
(FWICT, most users are arm based SoCs) are impacted.

> Could you please provide your solution? Any suggestion would be appre=
ciated.

My solution is: implement and export one function dw_spi_set_mode(),
NOR flash driver call this function before and after transfer.

Thanks,
Jisheng

> Regards,
> Khoa Pham
>=20
>=20
> On Wed, Jan 6, 2016 at 2:22 PM, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> w=
rote:
> > Dear Khoa,
> >
> > On Wed, 6 Jan 2016 14:04:30 +0700 Khoa Dang Pham wrote:
> > =20
> >> Hi Jisheng,
> >>
> >> On Wed, Jan 6, 2016 at 1:23 PM, Jisheng Zhang wrote: =20
> >> > Dear Khoa, Mark,
> >> >
> >> > On Wed, 6 Jan 2016 08:45:38 +0700 Khoa Dang Pham wrote:
> >> > =20
> >> >> Hi Mark,
> >> >>
> >> >> May I provide a bit more info about the "EEPROM read" on this c=
ontroller?
> >> >>
> >> >> According to the "DesignWare DW_apb_ssi Databook" (version 3.21=
b) provided
> >> >> by Synopsys, the EEPROM read is:
> >> >>
> >> >> "When TMOD =3D 2=E2=80=98b11, the transmit data is used to tran=
smit an opcode and/or
> >> >> an address to the EEPROM
> >> >> device. Typically this takes three data frames (8-bit opcode fo=
llowed by
> >> >> 8-bit upper address and 8-bit lower
> >> >> address). During the transmission of the opcode and address, no=
 data is
> >> >> captured by the receive logic (as
> >> >> long as the DW_apb_ssi master is transmitting data on its txd l=
ine, data on
> >> >> the rxd line is ignored). The
> >> >> DW_apb_ssi master continues to transmit data until the transmit=
 FIFO is
> >> >> empty. Therefore, you should
> >> >> ONLY have enough data frames in the transmit FIFO to supply the=
 opcode and
> >> >> address to the EEPROM. If
> >> >> more data frames are in the transmit FIFO than are needed, then=
 read data
> >> >> is lost.
> >> >> When the transmit FIFO becomes empty (all control information h=
as been
> >> >> sent), data on the receive line
> >> >> (rxd) is valid and is stored in the receive FIFO; the txd outpu=
t is held at
> >> >> a constant logic level. The serial
> >> >> transfer continues until the number of data frames received by =
the
> >> >> DW_apb_ssi master matches the value of
> >> >> the NDF field in the CTRLR1 register + 1." =20
> >> >
> >> > I tried the following combinations:
> >> >
> >> > 1. "Transmit only" to send opcode and address, "Receive only" to=
 read the
> >> > response
> >> >
> >> > 2. "Transmit and Receive" to send opcode and address, "Receive o=
nly" to read
> >> > the response
> >> >
> >> > 3. "Transmit and Receive" to send opcode and address, "Transmit =
and Receive"
> >> > to read the response
> >> >
> >> > 4. "Transmit and Receive" only to send opcode and address
> >> >
> >> > None of the above succeed. I only succeed when using
> >> >
> >> > 5. EEPROM Read to send opcode, address. I can get the correct NO=
R flash
> >> > content from the response.
> >> > =20
> >>
> >> I met the same issue before. The issue might be caused by the CS
> >> signal is toggled
> >> when we changed the transfer modes during opcode transmission and =
data
> >> receiption.
> >>
> >> According to the document I referred before:
> >> "The slave select line is held high when the DW_apb_ssi is idle or
> >> disabled."
> >>
> >> In your first 4 options, you need to disable this controller to wr=
ite
> >> to the CTRLR0 register
> >> in order to switch the transfer modes. The CS line changes from lo=
w
> >> level (active) to high
> >> level (inactive) during the configuration. The NOR flash sees this=
 CS
> >> toggle as a reset and
> >> stops outputting requested data. =20
> >
> > Thanks for the information. This could explain what I saw. So how t=
o
> > patch the spi-dw driver to support reading from NOR flash? Except
> > configure the tmode dynamically, is there any other solution?
> >
> > Thanks very much for your input,
> > Jisheng
> > =20
> >>
> >> Regards,
> >> Khoa Pham
> >> =20
> >> > Thanks,
> >> > Jisheng
> >> > =20
> >> >>
> >> >> Regards,
> >> >> Khoa Pham
> >> >>
> >> >> On Tue, Jan 5, 2016 at 11:12 PM, Mark Brown  wrote:
> >> >> =20
> >> >> > On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote=
: =20
> >> >> > > On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote: =20
> >> >> > > > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang w=
rote: =20
> >> >> > =20
> >> >> > > > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if c=
s_control is =20
> >> >> > NULL, but we =20
> >> >> > > > > need to set it as SPI_TMOD_EPROMREAD to read nor flash,=
 my solution =20
> >> >> > is to add and =20
> >> >> > > > > export one functions to set the tmode, then the nor fla=
sh driver =20
> >> >> > call it =20
> >> >> > > > > before reading and set back to SPI_TMOD_TR after done. =
=20
> >> >> > =20
> >> >> > > > What does this mean - what is TMOD and why do we need to =
set it to read
> >> >> > > > NOR flash?  I've no information on this controller... =20
> >> >> > =20
> >> >> > > TMOD is one field of DW_SPI_CTRL0. Its available value coul=
d be: =20
> >> >> > =20
> >> >> > > 0: Transmit and Receive
> >> >> > > 1: Transmit only
> >> >> > > 2: Receive only
> >> >> > > 3: EEPROM Read =20
> >> >> > =20
> >> >> > > If the one spi nor flash is connected to the SPI host, so f=
ar I can only =20
> >> >> > succeed =20
> >> >> > > to read the nor flash content after setting the TMOD field =
as 3. =20
> >> >> >
> >> >> > Why?  What does this mean in practical terms at the hardware =
level, what
> >> >> > is "EEPROM read"?  It sounds like there's some bigger issue h=
ere.
> >> >> > =20
> >> >> =20
> >> > =20
> >> =20
> > =20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
