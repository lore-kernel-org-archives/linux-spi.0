From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG] spi/spi-atmel: DMA rx buffer corruption with SPI_IOC_MESSAGE
Date: Mon, 21 Oct 2013 10:26:03 +0200
Message-ID: <CACQ1gAh-ZmL27q2w-0Aj4Lw6p6Y87cEJL7k_Ai9taDmsH_-qjg@mail.gmail.com>
References: <CACQ1gAhNFTdG_2OCTnsOCaBozHnGb9EwAGHT5+f=cARRpC_WBg@mail.gmail.com>
 <CACQ1gAjT30VLg5u5s6skRw0svMLavM2rZkG879VzmphtoKb=Vg@mail.gmail.com> <B256D81BAE5131468A838E5D7A24364172E9CFB1@penmbx01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B256D81BAE5131468A838E5D7A24364172E9CFB1@penmbx01>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2013/10/21 Yang, Wenyou <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>:
> Hi Richard,
>
>> -----Original Message-----
>> From: Richard Genoud [mailto:richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: 2013=E5=B9=B410=E6=9C=8817=E6=97=A5 19:01
>> To: Yang, Wenyou
>> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ferre, =
Nicolas;
>> Mark Brown
>> Subject: Re: [BUG] spi/spi-atmel: DMA rx buffer corruption with
>> SPI_IOC_MESSAGE
>>
>> 2013/10/8 Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> > Hi all,
>> >
>> > I finally found the bug I saw months ago, before "[PATCH v8 3/8]
>> > spi/spi-atmel: add dmaengine support" was merged.
>> >
>> > Here it is:
>> >
>> > When the ioctl SPI_IOC_MESSAGE is used with small and big buffers,
>> > the big RX buffer is corrupted with bytes from the big TX buffer.
>> > (Small means size < DMA_MIN_BYTES, Big means size >
>> DMA_MIN_BYTES)
>> >
>> > I'm attaching the test software that I used ( ./spi_test /dev/spid=
evx.x )
>> >
>> > It fills 3 TX buffers with 0xAA pattern: a small, a big and a smal=
l again.
>> > It reads in return 3 RX buffers.
>> > The MISO pin has to be on 3.3v.
>> >
>> > It checks if the received buffers are filled with 0xFF (they shoul=
d
>> > be, as MISO is high).
>> > And I've got a lot of buffers filled partially with 0xAA bytes.
>> >
>> > BUT, if you apply this patch:
>> > ---8<----
>> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
>> > index 83cf609..cde42a4 100644
>> > --- a/drivers/spi/spi-atmel.c
>> > +++ b/drivers/spi/spi-atmel.c
>> > @@ -187,7 +187,7 @@
>> >  /* use PIO for small transfers, avoiding DMA setup/teardown overh=
ead
>> and
>> >   * cache operations; better heuristics consider wordsize and bitr=
ate.
>> >   */
>> > -#define DMA_MIN_BYTES  16
>> > +#define DMA_MIN_BYTES  0
>> >
>> >  struct atmel_spi_dma {
>> >         struct dma_chan                 *chan_rx;
>> > ---8<----
>> > There's no error any more.
>> > So there's something wrong happening when switching from/to pio
>> > transfer to/from DMA.
>> >
>> > We didn't saw that at the time of the merge because we did the tes=
t
>> > with a loop on MISO/MOSI,
>> > so the RX buffer was corrupted with identical bytes.
>> >
>> > Best regards,
>> > Richard.
>>
>> Hi Wenyou,
>>
>> Did you have the opportunity to give it a test ?
>>
>> Thread: https://lkml.org/lkml/2013/10/8/329
> I tried to reproduce it with this thread, but I didn't
> Which slave device did you use?

Hi Wenyou,

I'm not using any slave device, I'm just setting the MISO pin to 3.3V,
then I execute the C code ( https://lkml.org/lkml/2013/10/8/329 )
So, we should only receive 0xFF in the buffer.
But i'm getting :
aa aa aa aa aa aa aa aa aa aa aa aa aa aa ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff
aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
aa aa aa aa aa aa aa aa aa aa aa aa aa aa ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff

Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
