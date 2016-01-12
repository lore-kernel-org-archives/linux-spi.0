From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
Date: Tue, 12 Jan 2016 09:49:58 +0100
Message-ID: <5694BE36.7060702@atmel.com>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
 <5693C9A3.9040403@atmel.com> <yw1xh9ikw29c.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <yw1xh9ikw29c.fsf-OEaqT8BN2ezZK2NkWkPsZwC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 11/01/2016 16:43, M=E5ns Rullg=E5rd a =E9crit :
> Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>=20
>> Le 08/01/2016 01:11, Mans Rullgard a =E9crit :
>>> The driver currently chooses between internal chip-select or gpio
>>> based on the existence of the cs-gpios DT property which fails on
>>> non-DT systems and also enforces the same choice for all devices.
>>
>> Well, I fear that such a per-device choice may impact further the dr=
iver
>> than just moving a field from one structure to another...
>=20
> Could you please elaborate?

Well, the first thing that comes to my mind is that the DT property may
need to be  to the SPI device node and not the controller anymore, for =
a
need of coherency.
That would imply modifying the binding and I don't want that for such a=
n
useless "improvement".

>> Moreover, I have the feeling that it was not the objective of this
>> patch.
>=20
> Your feeling is mistaken.  If it's somehow impossible to mix CS types=
,
> please explain why.

Please only fix the avr32 issue with CS gpio selection that I admit we
have. I don't need nor want to mix CS types: it just doesn't make sense
to allow it.


>>> This patch makes the method per device instead of per controller
>>> and fixes the selection on non-DT systems.  With these changes,
>>> the chip-select method for each device is chosen according to the
>>> following priority:
>>>
>>> 1. GPIO from device tree
>>> 2. GPIO from platform data
>>> 3. Internal chip-select
>>>
>>> Tested on AVR32 ATSTK1000.
>>
>> This patch breaks the SAMA5D2 SPI support at least on most recent
>> linux-next (tested by Cyrille).
>=20
> How did it fail?
>=20
>> more remarks below...
>>
>>> Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/spi/spi-atmel.c | 44 ++++++++++++++++++++++---------------=
-------
>>>  1 file changed, 22 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
>>> index aebad36391c9..8be07fb67d4d 100644
>>> --- a/drivers/spi/spi-atmel.c
>>> +++ b/drivers/spi/spi-atmel.c
>>> @@ -310,7 +310,6 @@ struct atmel_spi {
>>> =20
>>>  	bool			use_dma;
>>>  	bool			use_pdc;
>>> -	bool			use_cs_gpios;
>>>  	/* dmaengine data */
>>>  	struct atmel_spi_dma	dma;
>>> =20
>>> @@ -324,6 +323,7 @@ struct atmel_spi {
>>>  struct atmel_spi_device {
>>>  	unsigned int		npcs_pin;
>>>  	u32			csr;
>>> +	bool			use_cs_gpio;
>>>  };
>>> =20
>>>  #define BUFFER_SIZE		PAGE_SIZE
>>> @@ -388,7 +388,7 @@ static void cs_activate(struct atmel_spi *as, s=
truct spi_device *spi)
>>>  		}
>>> =20
>>>  		mr =3D spi_readl(as, MR);
>>> -		if (as->use_cs_gpios)
>>> +		if (asd->use_cs_gpio)
>>>  			gpio_set_value(asd->npcs_pin, active);
>>>  	} else {
>>>  		u32 cpol =3D (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
>>> @@ -405,7 +405,7 @@ static void cs_activate(struct atmel_spi *as, s=
truct spi_device *spi)
>>> =20
>>>  		mr =3D spi_readl(as, MR);
>>>  		mr =3D SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
>>> -		if (as->use_cs_gpios && spi->chip_select !=3D 0)
>>> +		if (asd->use_cs_gpio && spi->chip_select !=3D 0)
>>>  			gpio_set_value(asd->npcs_pin, active);
>>>  		spi_writel(as, MR, mr);
>>>  	}
>>> @@ -434,7 +434,7 @@ static void cs_deactivate(struct atmel_spi *as,=
 struct spi_device *spi)
>>>  			asd->npcs_pin, active ? " (low)" : "",
>>>  			mr);
>>> =20
>>> -	if (!as->use_cs_gpios)
>>> +	if (!asd->use_cs_gpio)
>>>  		spi_writel(as, CR, SPI_BIT(LASTXFER));
>>>  	else if (atmel_spi_is_v2(as) || spi->chip_select !=3D 0)
>>>  		gpio_set_value(asd->npcs_pin, !active);
>>> @@ -1221,8 +1221,6 @@ static int atmel_spi_setup(struct spi_device =
*spi)
>>>  		csr |=3D SPI_BIT(CPOL);
>>>  	if (!(spi->mode & SPI_CPHA))
>>>  		csr |=3D SPI_BIT(NCPHA);
>>> -	if (!as->use_cs_gpios)
>>> -		csr |=3D SPI_BIT(CSAAT);
>>> =20
>>>  	/* DLYBS is mostly irrelevant since we manage chipselect using GP=
IOs.
>>>  	 *
>>> @@ -1233,21 +1231,28 @@ static int atmel_spi_setup(struct spi_devic=
e *spi)
>>>  	csr |=3D SPI_BF(DLYBS, 0);
>>>  	csr |=3D SPI_BF(DLYBCT, 0);
>>> =20
>>> -	/* chipselect must have been muxed as GPIO (e.g. in board setup) =
*/
>>> -	npcs_pin =3D (unsigned long)spi->controller_data;
>>> -
>>> -	if (!as->use_cs_gpios)
>>> -		npcs_pin =3D spi->chip_select;
>>> -	else if (gpio_is_valid(spi->cs_gpio))
>>> -		npcs_pin =3D spi->cs_gpio;
>>> -
>>>  	asd =3D spi->controller_state;
>>>  	if (!asd) {
>>>  		asd =3D kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
>>>  		if (!asd)
>>>  			return -ENOMEM;
>>> =20
>>> -		if (as->use_cs_gpios) {
>>> +		npcs_pin =3D (unsigned long)spi->controller_data;
>>> +
>>> +		if (gpio_is_valid(spi->cs_gpio)) {
>>
>> The bug may come from here as the logic is somehow inverted and a "0=
" is
>> a valid gpio according to this gpio_is_valid() function. So we may t=
ake
>> this conditional branch instead of the third one in the sama5d2 case=
=2E
>=20
> spi->cs_gpio is set to -ENOENT if none is specified so I don't think
> this should be a problem.
>=20
>>> +			/* GPIO from DT */
>>> +			npcs_pin =3D spi->cs_gpio;
>>> +			asd->use_cs_gpio =3D true;
>>> +		} else if (npcs_pin && gpio_is_valid(npcs_pin)) {
>>> +			/* GPIO from platform data */
>>> +			asd->use_cs_gpio =3D true;
>>> +		} else {
>>> +			/* internal chip-select */
>>> +			npcs_pin =3D spi->chip_select;
>>> +			asd->use_cs_gpio =3D false;
>>> +		}
>>> +
>>> +		if (asd->use_cs_gpio) {
>>>  			ret =3D gpio_request(npcs_pin, dev_name(&spi->dev));
>>>  			if (ret) {
>>>  				kfree(asd);
>>> @@ -1262,6 +1267,8 @@ static int atmel_spi_setup(struct spi_device =
*spi)
>>>  		spi->controller_state =3D asd;
>>>  	}
>>> =20
>>> +	if (!asd->use_cs_gpio)
>>> +		csr |=3D SPI_BIT(CSAAT);
>>>  	asd->csr =3D csr;
>>> =20
>>>  	dev_dbg(&spi->dev,
>>> @@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_d=
evice *pdev)
>>> =20
>>>  	atmel_get_caps(as);
>>> =20
>>> -	as->use_cs_gpios =3D true;
>>> -	if (atmel_spi_is_v2(as) &&
>>
>> I don't see this atmel_spi_is_v2() test in the resulting code anymor=
e:
>> did you make sure that the v1 of the peripheral is protected?
>=20
> You're right, that check seems to have fallen by the wayside.
>=20
>>> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>>> -		as->use_cs_gpios =3D false;
>>> -		master->num_chipselect =3D 4;
>>
>> This line is pretty important: you mustn't remove it blindly!
>=20
> That may be the real cause of whatever problem you saw.
>=20
>>> -	}
>>> -
>>>  	as->use_dma =3D false;
>>>  	as->use_pdc =3D false;
>>>  	if (as->caps.has_dma_support) {
>>>
>>
>> So, sorry but it's a NACK for me.
>=20
> Thanks for reviewing.
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
