From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
Date: Tue, 12 Jan 2016 08:51:00 +0000
Message-ID: <yw1xmvsbuqob.fsf@unicorn.mansr.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
	<5694BBCD.8020700@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Yang\, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5694BBCD.8020700-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (Cyrille Pitchen's message of "Tue,
	12 Jan 2016 09:39:41 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> Hi Mans,
>
> I've tried to apply your patch on a next-20160112 branch to test it b=
ut it
> failed. I've also looked at the for-next branch of the SPI sub-system=
 git
> tree.
>
> It seems that one issue occurred within a chunk patching the atmel_sp=
i_setup()
> function. Please see below.
>
> Le 11/01/2016 17:01, Mans Rullgard a =E9crit :
> [...]
>> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
>> index 08cbb3e43c76..d4a806e24060 100644
>> --- a/drivers/spi/spi-atmel.c
>> +++ b/drivers/spi/spi-atmel.c
> [...]
>> @@ -1603,6 +1611,7 @@ static int atmel_spi_setup(struct spi_device *=
spi)
>>  		}
>> =20
>>  		asd->npcs_pin =3D npcs_pin;
>> +		asd->use_cs_gpio =3D use_cs_gpio;
>>  		spi->controller_state =3D asd;
>>  	} else {
>>  		atmel_spi_lock(as);
> [...]
>
> There is no 'else' statement in the source code I'm looking at.

Sorry, I'll send a new patch against the correct base.  I forgot I had
something else earlier in my local branch.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
