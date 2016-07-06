From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: SPI: performance regression when using the common message queuing
 infrastructure
Date: Wed, 6 Jul 2016 11:50:28 +0200
Message-ID: <577CD464.6050506@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <hs-ynQEQJNshbs@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

recently Heiko reported to us a performance regression with Atmel SPI
controllers. He noticed the issue on a sam9g15ek board and I was also a=
ble to
reproduce it on a sama5d36ek board.

We found out that the performance regression was introduced in 3.14 by =
commit:
8090d6d1a415d3ae1a7208995decfab8f60f4f36
spi: atmel: Refactor spi-atmel to use SPI framework queue

=46or the test, I connected a Spansion S25FL512 memory on the SPI1 cont=
roller of
a sama5d36ek board. Then with an oscilloscope I monitored the chip-sele=
ct, clock
and MOSI signals on the SPI bus.


1 - Reading 512 bytes from the memory

# dd if=3D/dev/mtd6 bs=3D512 count=3D1 of=3D/dev/null

With the oscilloscope, I measured the time between the chip-select fell=
 before
the Read Status command (05h) and the chip-select rose after all data h=
ad been
read by the 4-byte address Fast Read 1-1-1 command (13h).

3.14 vanilla                      : 305 =C2=B5s
3.14 commit 8090d6d1a415 reverted : 242 =C2=B5s   -21%

2 - Reading 1000 x 1024 bytes from the memory

# dd if=3D/dev/mtd6 bs=3D1024 count=3D1000 of=3D/dev/null

Still with the scope, I measured the time to read all data.

3.14 vanilla                      : 435 ms
3.14 commit 8090d6d1a415 reverted : 361 ms   -17%


Indeed the oscilloscope shows that more time is spent between messages =
and
transfers.

commit 8090d6d1a415 replaced the tasklet used to manage a SPI message/t=
ransfer
queue by a workqueue provided by the SPI framework.

The support of this (optional) workqueue was introduced by commit:
ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0
spi: create a message queuing infrastructure

Though the commit message claims that is common infrastructure is optio=
nal,
the patch also claims the .transfer() hook is deprecated, suggesting dr=
ivers
should implement the new .transfer_one_message() hook instead.

This is the reason why commit 8090d6d1a415 was submitted. However we lo=
st
quite amount of performances moving from our tasklet to the generic wor=
kqueue.

So do you recommend us to keep our current generic implementation relyi=
ng on
the SPI framework workqueue or to go back to a custom implementation us=
ing
tasklet?
If we keep the current implementation, is there a way to improve the
performances so we go back to something close to what he had before?

We saw in commit ffbbdd21329f that we can change the workqueue thread
scheduling policy to SCHED_FIFO by setting master->rt.


Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
