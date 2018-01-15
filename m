From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 2/3] spi: Add spi driver for Socionext Synquacer platform
Date: Mon, 15 Jan 2018 18:35:04 +0530
Message-ID: <CAJe_ZheEmU_jBch=RGbwHiAgGkCsxtBNnVyHV9bwVibNoKbQag@mail.gmail.com>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
 <1515503448-9025-1-git-send-email-jassisinghbrar@gmail.com> <1515527945.25398.59.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515527945.25398.59.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 10 January 2018 at 01:29, Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 2018-01-09 at 18:40 +0530, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This patch adds support for controller found on synquacer platforms.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> +static int synquacer_spi_config(struct spi_master *master,
>> +                               struct spi_device *spi,
>> +                               struct spi_transfer *xfer)
>> +{
>> +     struct synquacer_spi *sspi = spi_master_get_devdata(master);
>> +     unsigned int speed, mode, bpw, cs, bus_width;
>> +     unsigned long rate, transf_mode;
>> +     u32 val, div;
>> +
>> +     /* Full Duplex only on 1bit wide bus */
>> +     if (xfer->rx_buf && xfer->tx_buf &&
>> +                     (xfer->rx_nbits != 1 || xfer->tx_nbits != 1)) {
>> +             dev_err(sspi->dev, "RX and TX bus widths must match!\n");
>
> This looks like the wrong error message is being printed.  It does not
> match the comment nor the code.
>
Well, TX and TX bus widths should both be 1 for Full-Duplex mode.
I have anyway tried to made it clearer.

>> +     speed = xfer->speed_hz ? : spi->max_speed_hz;
>> +     bpw = xfer->bits_per_word ? : spi->bits_per_word;
>
> You shouldn't need to do this checking. __spi_validate() should have
> already set these fields in xfer to their defaults if they weren't set,
> checked xfer speed is less than controller max speed, checked bus width
> is supported, etc.
>
Cool. Thanks

>> +     /* return if nothing to change */
>> +     if (speed == sspi->speed &&
>> +                     bus_width == sspi->bus_width && bpw == sspi->bpw &&
>> +                     mode == sspi->mode && cs == sspi->cs &&
>> +                     transf_mode == sspi->old_transf_mode) {
>> +             return 0;
>> +     }
>
> Good optimization to not reprogram on every xfer, since usually speed,
> bits, etc. stays the same for a series of xfers.  However, often SPI
> clients generate a number write, read pairs.  In this case transf_mode
> will alternate and the optimization will fail to work, even through it
> is very likely that nothing (especially bus speed, which can be slow to
> change) else changed.
>
> Consider allowing changing between read and write without unnecessarily
> reprogramming everything else.
>
Tracking transf_mode is actually redundant. I have removed it.

>> +
>> +     if (xfer->tx_buf)
>> +             sspi->old_transf_mode = TXBIT;
>> +     else
>> +             sspi->old_transf_mode = RXBIT;
> Why not just:
>
> sspi->old_transf_mode = transf_mode;
>
> Also, why is this "old_" when all the other ones, sspi->speed, etc.,
> don't have "old_" in front.  Seems inconsistent unless there is
> something special about transf_mode I have missed.
>
>>
>> +
>> +     if (xfer->tx_buf && xfer->rx_buf)
>> +             val |= (DATA_TXRX << DATA_SHIFT);
>> +     else if (xfer->rx_buf)
>> +             val |= (DATA_RX << DATA_SHIFT);
>> +     else
>> +             val |= (DATA_TX << DATA_SHIFT);
>
> Looks like one needs to set three different modes for bi, rx, and tx.
> But your transf_mode variable only has two settings, rx and tx.  It
> won't detect change between tx and bi.
>
>>
>> +
>> +     val = readl_relaxed(sspi->regs + FIFOCFG);
>> +     val |= RX_FLUSH;
>> +     val |= TX_FLUSH;
>> +     writel_relaxed(val, sspi->regs + FIFOCFG);
>
> If this causes the master to pulse the chipselect it will mess up
> messages that have more than one xfer.
>
No, that just resets the fifos.

>> +
>> +     /* See if we can transfer 4-bytes as 1 word even if not asked */
>> +     bpw = xfer->bits_per_word ? : spi->bits_per_word;
>
> Don't neeed this as xfer->bits_per_word is already normalized.
>
OK

>> +     if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST)) {
>> +             bpw = xfer->bits_per_word;
>> +             xfer->bits_per_word = 32;
>> +     } else {
>> +             bpw = xfer->bits_per_word;
>> +     }
>
> What's the point of the bpw = xfer->bits_per_word above?  It would
> already be set to that value.
>
Cleaned.

>> +
>> +     ret = synquacer_spi_config(master, spi, xfer);
>> +     if (ret) {
>> +             xfer->bits_per_word = bpw;
>
> Why not restore xfer->bits_per_word immediately after call to
> synquacer_spi_config, before if statement.  It's not used again.  Then
> you don't have to restore it also at the end of the function.
>
Done.

>>
>> +
>> +     spin_lock_irqsave(&sspi->lock, flags);
>
> What's this lock for?  I see no other use than here.
>
Remnant of old driver. Dropped.


>> +     master->min_speed_hz = master->max_speed_hz / 254;
>
> The configure function rejects divisors larger than 127.  Seems like
> these should match.
>
Fixed.

> I notice your transfer function does not use interrupts.  It will spin
> in a tight loop polling DMSTATUS waiting for data to arrive.  Not very
> friendly for a multitasking operating system.  It would be much better
> if there was a way wait for in an interrupt at the start of your while
> loop and have the controller trigger one when the tx and/or rx fifo has
>  some amount of data in it (like half full).
>
> You'll likely also find that in an interruptable kernel that your
> transfer function will eventually stop running and another process will
> run.  Multitasking.  When this happens, it might be many milliseconds
> before it is scheduled to run again.  Hope that fifo is large...
>
> Usually when a device has a fifo that must be emptied before it
> overflows, it is either emptied from an interrupt handler or the
> interrupt handler will queue a work function or tasklet that will empty
> it.  Doing it from user context has a maximum latency that is too high.
>
I am aware of the benefits of interrupts, unfortunately the h/w
doesn't seem to support.

Thank you.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
