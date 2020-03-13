From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date: Fri, 13 Mar 2020 17:53:24 +0100
Message-ID: <4b77ccec9d0de0615985ebf60db9cf67@walle.cc>
References: <20200310125542.5939-1-olteanv@gmail.com>
 <615284875b709f602d57e4a4621a83c1@walle.cc>
 <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
 <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc>
 <4ba077c80143c8ec679066e6d8cedca2@walle.cc>
 <CA+h21hqk+pVrGgHx4iTshfE3i4WF7VANPfMf2ykPFpL3=ragag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+h21hqk+pVrGgHx4iTshfE3i4WF7VANPfMf2ykPFpL3=ragag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 2020-03-13 17:37, schrieb Vladimir Oltean:
> Hi Michael,
> 
> On Fri, 13 Mar 2020 at 18:07, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>> 
>> Am 2020-03-10 16:22, schrieb Michael Walle:
>> > Hi Vladimir,
>> >
>> > Am 2020-03-10 15:56, schrieb Vladimir Oltean:
>> >>> (2) Also, reading the flash, every second time there is
>> >>> (reproducibly)
>> >>> an
>> >>> IO error:
>> >>>
>> >>> # hexdump -C /dev/mtd0
>> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |huhu............|
>> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |................|
>> >>> *
>> >>> 01000000
>> >>> # hexdump -C /dev/mtd0
>> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |huhu............|
>> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |................|
>> >>> *
>> >>> hexdump: /dev/mtd0: Input/output error
>> >>> 00dc0000
>> >>> # hexdump -C /dev/mtd0
>> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |huhu............|
>> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |................|
>> >>> *
>> >>> 01000000
>> >>> # hexdump -C /dev/mtd0
>> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |huhu............|
>> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> >>> |................|
>> >>> *
>> >>> hexdump: /dev/mtd0: Input/output error
>> >>> 00e6a000
>> >>>
>> >>
>> >> Just to be clear, issue 2 is seen only after you abort another
>> >> transaction, right?
>> >
>> > No, just normal uninterrupted reading. Just tried it right after
>> > reboot. Doesn't seem to be every second time though, just random
>> > which makes me wonder if that is another problem now. Also the
>> > last successful reading is random.
>> 
>> 
>> Ok I guess I know what the root cause is. This is an extract of
>> the current code:
>> 
>> > static int dspi_transfer_one_message(struct spi_controller *ctlr,
>> >                                    struct spi_message *message)
>> > {
>> > ..
>> >       /* Kick off the interrupt train */
>> >       dspi_fifo_write(dspi);
>> >
>> >       status = wait_event_interruptible(dspi->waitq,
>> >                                         dspi->waitflags);
>> >       dspi->waitflags = 0;
>> > ..
>> > }
>> >
>> > static int dspi_rxtx(struct fsl_dspi *dspi)
>> > {
>> >       dspi_fifo_read(dspi);
>> >
>> >       if (!dspi->len)
>> >               /* Success! */
>> >               return 0;
>> >
>> >       dspi_fifo_write(dspi);
>> >
>> >       return -EINPROGRESS;
>> > }
>> 
>> dspi_rxtx() is used in the ISR. Both dspi_fifo_write() and dspi_rxtx()
>> access shared data like, dspi->words_in_flight. In the EIO error case
>> the following bytes_sent is -1, because dspi->words_in_flight is -1.
>> 
>> > /* Update total number of bytes that were transferred */
>> > bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
>> 
>> words_in_flight is always -1 after dspi_fifo_read() was called. In
>> the error case, the ISR kicks in right in the middle of the execution
>> of dspi_fifo_write() in dspi_transfer_one_message().
>> 
>> > static void dspi_fifo_write(struct fsl_dspi *dspi)
>> > {
>> > ..
>> >       if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
>> >               dspi_eoq_fifo_write(dspi);
>> >        else
>> >               dspi_xspi_fifo_write(dspi);
>> 
>> Now if the ISR is executed right here..
>> 
>> >
>> >       /* Update total number of bytes that were transferred */
>> >       bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
>> 
>> .. words_in_flight might be -1.
>> 
>> >       msg->actual_length += bytes_sent;
>> 
>> and bytes_sent is negative. And this causes an IO error because
>> the returned overall message length doesn't match.
>> 
>> >       dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
>> > ..
>> > }
>> 
>> I could not reproduce the issue with the following patch. I don't
>> know if I got the locking correct though or if there is a better
>> way to go.
>> 
>> 
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 8b16de9ed382..578fedeb16a0 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -224,6 +224,7 @@ struct fsl_dspi {
>>          u16                                     tx_cmd;
>>          const struct fsl_dspi_devtype_data      *devtype_data;
>> 
>> +       spinlock_t lock;
>>          wait_queue_head_t                       waitq;
>>          u32                                     waitflags;
>> 
>> @@ -873,14 +874,20 @@ static void dspi_fifo_write(struct fsl_dspi 
>> *dspi)
>> 
>>   static int dspi_rxtx(struct fsl_dspi *dspi)
>>   {
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&dspi->lock, flags);
>>          dspi_fifo_read(dspi);
>> 
>> -       if (!dspi->len)
>> +       if (!dspi->len) {
>>                  /* Success! */
>> +               spin_unlock_irqrestore(&dspi->lock, flags);
>>                  return 0;
>> +       }
>> 
>>          dspi_fifo_write(dspi);
>> 
>> +       spin_unlock_irqrestore(&dspi->lock, flags);
>>          return -EINPROGRESS;
>>   }
>> 
>> @@ -950,7 +957,9 @@ static int dspi_transfer_one_message(struct
>> spi_controller *ctlr,
>>          struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
>>          struct spi_device *spi = message->spi;
>>          struct spi_transfer *transfer;
>> +       unsigned long flags;
>>          int status = 0;
>> +       int i = 0;
>> 
>>          if (dspi->irq)
>>                  dspi_enable_interrupts(dspi, true);
>> @@ -1009,7 +1018,9 @@ static int dspi_transfer_one_message(struct
>> spi_controller *ctlr,
>>                                  goto out;
>>                  } else if (dspi->irq) {
>>                          /* Kick off the interrupt train */
>> +                       spin_lock_irqsave(&dspi->lock, flags);
>>                          dspi_fifo_write(dspi);
>> +                       spin_unlock_irqrestore(&dspi->lock, flags);
>> 
>>                          status = 
>> wait_event_interruptible(dspi->waitq,
>> 
>> dspi->waitflags);
>> @@ -1301,6 +1312,7 @@ static int dspi_probe(struct platform_device
>> *pdev)
>>          ctlr->cleanup = dspi_cleanup;
>>          ctlr->slave_abort = dspi_slave_abort;
>>          ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
>> +       spin_lock_init(&dspi->lock);
>> 
>>          pdata = dev_get_platdata(&pdev->dev);
>>          if (pdata) {
>> 
>> 
>> 
>> -michael
> 
> Thanks for taking such a close look. I haven't had the time to follow 
> up.
> Indeed, the ISR, and therefore dspi_fifo_read, can execute before
> dspi->words_in_flight was populated correctly. And bad things will
> happen in that case.
> But I wouldn't introduce a spin lock that disables interrupts on the
> local CPU just for that - it's too complicated for this driver.

Sure. It was just a quick test whether the problem actually goes away.

> I would just keep the SPI interrupt quiesced via SPI_RSER and enable
> it only once it's safe, aka after updating dspi->words_in_flight.

I didn't want to move the interrupt_enable() around. I leave this up to
you ;)

-michael
