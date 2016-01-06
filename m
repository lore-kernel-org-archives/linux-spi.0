From: Khoa Dang Pham <kpham-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 6 Jan 2016 14:04:30 +0700
Message-ID: <CAFLsZf31bt+-uwTo3zBWkho3UxquRCeTmK3hNMrGLXkjwHanwA@mail.gmail.com>
References: <20151223192338.128e95a4@xhacker>
	<20151223121512.GV16023@sirena.org.uk>
	<20151223202952.28be5bab@xhacker>
	<20160105161231.GG6588@sirena.org.uk>
	<CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
	<20160106142340.34e2d334@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160106142340.34e2d334@xhacker>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jisheng,

On Wed, Jan 6, 2016 at 1:23 PM, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wro=
te:
> Dear Khoa, Mark,
>
> On Wed, 6 Jan 2016 08:45:38 +0700 Khoa Dang Pham wrote:
>
>> Hi Mark,
>>
>> May I provide a bit more info about the "EEPROM read" on this contro=
ller?
>>
>> According to the "DesignWare DW_apb_ssi Databook" (version 3.21b) pr=
ovided
>> by Synopsys, the EEPROM read is:
>>
>> "When TMOD =3D 2=E2=80=98b11, the transmit data is used to transmit =
an opcode and/or
>> an address to the EEPROM
>> device. Typically this takes three data frames (8-bit opcode followe=
d by
>> 8-bit upper address and 8-bit lower
>> address). During the transmission of the opcode and address, no data=
 is
>> captured by the receive logic (as
>> long as the DW_apb_ssi master is transmitting data on its txd line, =
data on
>> the rxd line is ignored). The
>> DW_apb_ssi master continues to transmit data until the transmit FIFO=
 is
>> empty. Therefore, you should
>> ONLY have enough data frames in the transmit FIFO to supply the opco=
de and
>> address to the EEPROM. If
>> more data frames are in the transmit FIFO than are needed, then read=
 data
>> is lost.
>> When the transmit FIFO becomes empty (all control information has be=
en
>> sent), data on the receive line
>> (rxd) is valid and is stored in the receive FIFO; the txd output is =
held at
>> a constant logic level. The serial
>> transfer continues until the number of data frames received by the
>> DW_apb_ssi master matches the value of
>> the NDF field in the CTRLR1 register + 1."
>
> I tried the following combinations:
>
> 1. "Transmit only" to send opcode and address, "Receive only" to read=
 the
> response
>
> 2. "Transmit and Receive" to send opcode and address, "Receive only" =
to read
> the response
>
> 3. "Transmit and Receive" to send opcode and address, "Transmit and R=
eceive"
> to read the response
>
> 4. "Transmit and Receive" only to send opcode and address
>
> None of the above succeed. I only succeed when using
>
> 5. EEPROM Read to send opcode, address. I can get the correct NOR fla=
sh
> content from the response.
>

I met the same issue before. The issue might be caused by the CS
signal is toggled
when we changed the transfer modes during opcode transmission and data
receiption.

According to the document I referred before:
"The slave select line is held high when the DW_apb_ssi is idle or
disabled."

In your first 4 options, you need to disable this controller to write
to the CTRLR0 register
in order to switch the transfer modes. The CS line changes from low
level (active) to high
level (inactive) during the configuration. The NOR flash sees this CS
toggle as a reset and
stops outputting requested data.

Regards,
Khoa Pham

> Thanks,
> Jisheng
>
>>
>> Regards,
>> Khoa Pham
>>
>> On Tue, Jan 5, 2016 at 11:12 PM, Mark Brown  wrote:
>>
>> > On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote:
>> > > On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote:
>> > > > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:
>> >
>> > > > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_con=
trol is
>> > NULL, but we
>> > > > > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my s=
olution
>> > is to add and
>> > > > > export one functions to set the tmode, then the nor flash dr=
iver
>> > call it
>> > > > > before reading and set back to SPI_TMOD_TR after done.
>> >
>> > > > What does this mean - what is TMOD and why do we need to set i=
t to read
>> > > > NOR flash?  I've no information on this controller...
>> >
>> > > TMOD is one field of DW_SPI_CTRL0. Its available value could be:
>> >
>> > > 0: Transmit and Receive
>> > > 1: Transmit only
>> > > 2: Receive only
>> > > 3: EEPROM Read
>> >
>> > > If the one spi nor flash is connected to the SPI host, so far I =
can only
>> > succeed
>> > > to read the nor flash content after setting the TMOD field as 3.
>> >
>> > Why?  What does this mean in practical terms at the hardware level=
, what
>> > is "EEPROM read"?  It sounds like there's some bigger issue here.
>> >
>>
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
