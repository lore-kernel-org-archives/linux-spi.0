From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: atmel: add support for the internal chip-select of the spi controller
Date: Wed, 27 Jan 2016 16:57:01 +0000
Message-ID: <yw1xfuxjj6zm.fsf@unicorn.mansr.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
	<c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
	<yw1xvb771yrl.fsf@unicorn.mansr.com> <56A8E66B.208@atmel.com>
	<yw1xk2mvj9xp.fsf@unicorn.mansr.com> <56A8F66E.6070105@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Yang\, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56A8F66E.6070105-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (Nicolas Ferre's message of "Wed, 27
	Jan 2016 17:55:10 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> Le 27/01/2016 16:53, M=E5ns Rullg=E5rd a =E9crit :
>> Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>>=20
>>> Le 05/01/2016 22:50, M=E5ns Rullg=E5rd a =E9crit :
>>>> Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>>>>
>>>>> This patch relies on the CSAAT (Chip Select Active After Transfer=
) feature
>>>>> introduced by the version 2 of the spi controller. This new mode =
allows to
>>>>> use properly the internal chip-select output pin of the spi contr=
oller
>>>>> instead of using external gpios. Consequently, the "cs-gpios" dev=
ice-tree
>>>>> property becomes optional.
>>>>>
>>>>> When the new CSAAT bit is set into the Chip Select Register, the =
internal
>>>>> chip-select output pin remains asserted till both the following c=
onditions
>>>>> become true:
>>>>> - the LASTXFER bit is set into the Control Register (or the Trans=
mit Data
>>>>>   Register)
>>>>> - the Transmit Data Register and its shift register are empty.
>>>>>
>>>>> WARNING: if the LASTXFER bit is set into the Control Register the=
n new
>>>>> data are written into the Transmit Data Register fast enough to k=
eep its
>>>>> shifter not empty, the chip-select output pin remains asserted. O=
nly when
>>>>> the shifter becomes empty, the chip-select output pin is unassert=
ed.
>>>>>
>>>>> When the CSAAT bit is clear in the Chip Select Register, the LAST=
XFER bit
>>>>> is ignored in both the Control Register and the Transmit Data Reg=
ister.
>>>>> The internal chip-select output pin remains active as long as the=
 Transmit
>>>>> Data Register or its shift register are not empty.
>>>>>
>>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>>>> ---
>>>>>  drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++-------=
--
>>>>>  1 file changed, 28 insertions(+), 9 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> @@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform=
_device *pdev)
>>>>>
>>>>>  	atmel_get_caps(as);
>>>>>
>>>>> +	as->use_cs_gpios =3D true;
>>>>> +	if (atmel_spi_is_v2(as) &&
>>>>> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>>>>> +		as->use_cs_gpios =3D false;
>>>>> +		master->num_chipselect =3D 4;
>>>>> +	}
>>>>
>>>> This part breaks the AVR32 boards and probably anything else that
>>>> doesn't use devicetree but does use GPIOs for chip select.
>>>
>>> Hi Mans,
>>>
>>> I have difficulties finding why you may enter this test. So, maybe =
you
>>> can give me a clue by reading for me the value that resides in the =
SPI
>>> version register: you can have it by reading at 0xFFE000FC for inst=
ance
>>> (actually the atmel_get_caps() dev_info() call gives it as well in =
the
>>> boot log which is somewhat easier: I tried to find one on the Inter=
net
>>> without success...).
>>>
>>> So I think that just fixing the logic in atmel_get_caps() introduce=
d by
>>> d4820b7496219edd9a7055022681364d304525f7 can make it come back to a
>>> situation where the ARV32 was more tested than nowadays.
>>=20
>> atmel_spi atmel_spi.0: version: 0x171
>> atmel_spi atmel_spi.0: Atmel SPI Controller at 0xffe00000 (irq 3)
>>=20
>> atmel_spi_is_v2() returns true for version > 0x121.
>
> Ok, thanks: we thought that AVR32 didn't have a v2 IP: obviously it h=
as.
> So yes, I extract the patch by Cyrille to correct this and send it ri=
ght
> now.
>
> If you can test it, it's even better ;-)

I saw the patch, will test it later.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
