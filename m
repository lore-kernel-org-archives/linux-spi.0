From: Khoa Dang Pham <kpham-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 6 Jan 2016 09:03:41 +0700
Message-ID: <CAFLsZf2NC3gx=2G9M_Pqsgq1vp6t5_t+ZFuBXEuOohzbVpsHJw@mail.gmail.com>
References: <20151223192338.128e95a4@xhacker>
	<20151223121512.GV16023@sirena.org.uk>
	<20151223202952.28be5bab@xhacker>
	<20160105161231.GG6588@sirena.org.uk>
	<CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

May I provide a bit more info about the "EEPROM read" on this controlle=
r?

According to the "DesignWare DW_apb_ssi Databook" (version 3.21b)
provided by Synopsys, the EEPROM read is:

"When TMOD =3D 2=E2=80=98b11, the transmit data is used to transmit an =
opcode
and/or an address to the EEPROM
device. Typically this takes three data frames (8-bit opcode followed
by 8-bit upper address and 8-bit lower
address). During the transmission of the opcode and address, no data
is captured by the receive logic (as
long as the DW_apb_ssi master is transmitting data on its txd line,
data on the rxd line is ignored). The
DW_apb_ssi master continues to transmit data until the transmit FIFO
is empty. Therefore, you should
ONLY have enough data frames in the transmit FIFO to supply the opcode
and address to the EEPROM. If
more data frames are in the transmit FIFO than are needed, then read
data is lost.

When the transmit FIFO becomes empty (all control information has been
sent), data on the receive line
(rxd) is valid and is stored in the receive FIFO; the txd output is
held at a constant logic level. The serial
transfer continues until the number of data frames received by the
DW_apb_ssi master matches the value of
the NDF field in the CTRLR1 register + 1."
Regards,
Khoa Pham


On Wed, Jan 6, 2016 at 8:45 AM, Khoa Dang Pham <kpham-qTEPVZfXA3Y@public.gmane.org> wrote:
> Hi Mark,
>
> May I provide a bit more info about the "EEPROM read" on this control=
ler?
>
> According to the "DesignWare DW_apb_ssi Databook" (version 3.21b) pro=
vided
> by Synopsys, the EEPROM read is:
>
> "When TMOD =3D 2=E2=80=98b11, the transmit data is used to transmit a=
n opcode and/or
> an address to the EEPROM
> device. Typically this takes three data frames (8-bit opcode followed=
 by
> 8-bit upper address and 8-bit lower
> address). During the transmission of the opcode and address, no data =
is
> captured by the receive logic (as
> long as the DW_apb_ssi master is transmitting data on its txd line, d=
ata on
> the rxd line is ignored). The
> DW_apb_ssi master continues to transmit data until the transmit FIFO =
is
> empty. Therefore, you should
> ONLY have enough data frames in the transmit FIFO to supply the opcod=
e and
> address to the EEPROM. If
> more data frames are in the transmit FIFO than are needed, then read =
data is
> lost.
> When the transmit FIFO becomes empty (all control information has bee=
n
> sent), data on the receive line
> (rxd) is valid and is stored in the receive FIFO; the txd output is h=
eld at
> a constant logic level. The serial
> transfer continues until the number of data frames received by the
> DW_apb_ssi master matches the value of
> the NDF field in the CTRLR1 register + 1."
>
> Regards,
> Khoa Pham
>
> On Tue, Jan 5, 2016 at 11:12 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrot=
e:
>>
>> On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote:
>> > On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote:
>> > > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:
>>
>> > > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_contr=
ol is
>> > > > NULL, but we
>> > > > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my sol=
ution
>> > > > is to add and
>> > > > export one functions to set the tmode, then the nor flash driv=
er
>> > > > call it
>> > > > before reading and set back to SPI_TMOD_TR after done.
>>
>> > > What does this mean - what is TMOD and why do we need to set it =
to
>> > > read
>> > > NOR flash?  I've no information on this controller...
>>
>> > TMOD is one field of DW_SPI_CTRL0. Its available value could be:
>>
>> > 0: Transmit and Receive
>> > 1: Transmit only
>> > 2: Receive only
>> > 3: EEPROM Read
>>
>> > If the one spi nor flash is connected to the SPI host, so far I ca=
n only
>> > succeed
>> > to read the nor flash content after setting the TMOD field as 3.
>>
>> Why?  What does this mean in practical terms at the hardware level, =
what
>> is "EEPROM read"?  It sounds like there's some bigger issue here.
>
>

--=20
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,=
 is=20
for the sole use of the intended recipient(s) and contains information =
that=20
is confidential and proprietary to Applied Micro Circuits Corporation o=
r=20
its subsidiaries. It is to be used solely for the purpose of furthering=
 the=20
parties' business relationship. All unauthorized review, use, disclosur=
e or=20
distribution is prohibited. If you are not the intended recipient, plea=
se=20
contact the sender by reply e-mail and destroy all copies of the origin=
al=20
message.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
