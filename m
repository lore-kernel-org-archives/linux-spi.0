From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI: performance regression when using the common message queuing
 infrastructure
Date: Fri, 29 Jul 2016 11:33:00 +0200
Message-ID: <41cb8a2a-7138-d2c0-e668-6c03add1882e@atmel.com>
References: <577CD464.6050506@atmel.com> <577CD767.2080309@ti.com>
 <577E0EF3.6000308@atmel.com> <57959ADD.40700@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <hs-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57959ADD.40700-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Heiko,

Le 25/07/2016 =C3=A0 06:51, Heiko Schocher a =C3=A9crit :
> Hello Cyrille,
>=20
> sorry for the late answer, but just back from holidays ...
>=20
> Am 07.07.2016 um 10:12 schrieb Cyrille Pitchen:
>> Hi Grygorii,
>>
>> Le 06/07/2016 12:03, Grygorii Strashko a =C3=A9crit :
>>> On 07/06/2016 12:50 PM, Cyrille Pitchen wrote:
>>>> Hi Mark,
>>>>
>>>> recently Heiko reported to us a performance regression with Atmel =
SPI
>>>> controllers. He noticed the issue on a sam9g15ek board and I was a=
lso able to
>>>> reproduce it on a sama5d36ek board.
>>>>
>>>> We found out that the performance regression was introduced in 3.1=
4 by commit:
>>>> 8090d6d1a415d3ae1a7208995decfab8f60f4f36
>>>> spi: atmel: Refactor spi-atmel to use SPI framework queue
>>>>
>>>> For the test, I connected a Spansion S25FL512 memory on the SPI1 c=
ontroller of
>>>> a sama5d36ek board. Then with an oscilloscope I monitored the chip=
-select, clock
>>>> and MOSI signals on the SPI bus.
>>>>
>>>>
>>>> 1 - Reading 512 bytes from the memory
>>>>
>>>> # dd if=3D/dev/mtd6 bs=3D512 count=3D1 of=3D/dev/null
>>>>
>>>> With the oscilloscope, I measured the time between the chip-select=
 fell before
>>>> the Read Status command (05h) and the chip-select rose after all d=
ata had been
>>>> read by the 4-byte address Fast Read 1-1-1 command (13h).
>>>>
>>>> 3.14 vanilla                      : 305 =C2=B5s
>>>> 3.14 commit 8090d6d1a415 reverted : 242 =C2=B5s   -21%
>>>>
>>>> 2 - Reading 1000 x 1024 bytes from the memory
>>>>
>>>> # dd if=3D/dev/mtd6 bs=3D1024 count=3D1000 of=3D/dev/null
>>>>
>>>> Still with the scope, I measured the time to read all data.
>>>>
>>>> 3.14 vanilla                      : 435 ms
>>>> 3.14 commit 8090d6d1a415 reverted : 361 ms   -17%
>>>>
>>>>
>>>> Indeed the oscilloscope shows that more time is spent between mess=
ages and
>>>> transfers.
>=20
> Yes this fits with my observations.
>=20
>>>> commit 8090d6d1a415 replaced the tasklet used to manage a SPI mess=
age/transfer
>>>> queue by a workqueue provided by the SPI framework.
>>>>
>>>> The support of this (optional) workqueue was introduced by commit:
>>>> ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0
>>>> spi: create a message queuing infrastructure
>>>>
>>>> Though the commit message claims that is common infrastructure is =
optional,
>>>> the patch also claims the .transfer() hook is deprecated, suggesti=
ng drivers
>>>> should implement the new .transfer_one_message() hook instead.
>>>>
>>>> This is the reason why commit 8090d6d1a415 was submitted. However =
we lost
>>>> quite amount of performances moving from our tasklet to the generi=
c workqueue.
>>>>
>>>> So do you recommend us to keep our current generic implementation =
relying on
>>>> the SPI framework workqueue or to go back to a custom implementati=
on using
>>>> tasklet?
>>>> If we keep the current implementation, is there a way to improve t=
he
>>>> performances so we go back to something close to what he had befor=
e?
>>>>
>>>> We saw in commit ffbbdd21329f that we can change the workqueue thr=
ead
>>>> scheduling policy to SCHED_FIFO by setting master->rt.
>>>>
>>>
>>> master->rt is not a good choice as i know and
>>> you may find thread [1] useful for you.
>>>
>>> [1] http://www.spinics.net/lists/linux-rt-users/msg14347.html
>>>
>>
>> thanks for the link, I'll look at it :)
>=20
> Thanks for digging into this issue and your tests!
>=20
> Do you have some new results? Can I help you?
>=20
> bye,
> Heiko


We talked about moving back to a tasklet implementation but nothing was=
 done
yet so nothing new for now, sorry.
Also, I will be out of office for the next 3 weeks: I will be back on A=
ugust,
22th.


Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
