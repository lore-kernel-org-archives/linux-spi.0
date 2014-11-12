From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add driver for IMG SPFI controller
Date: Wed, 12 Nov 2014 14:54:57 -0800
Message-ID: <CAL1qeaH1rMcy37vcoHZ9xsmYs5iHz3Pp0GrC7agLmQ4Y7==iTw@mail.gmail.com>
References: <1415828274-24727-1-git-send-email-abrestic@chromium.org>
	<1415828274-24727-3-git-send-email-abrestic@chromium.org>
	<20141112220740.GR3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141112220740.GR3815-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 12, 2014 at 2:07 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Wed, Nov 12, 2014 at 01:37:54PM -0800, Andrew Bresticker wrote:
>> Add support for the Synchronous Peripheral Flash Interface (SPFI) master
>> controller found on IMG SoCs.  The SPFI controller supports 5 chip-select
>> lines and single/dual/quad mode SPI transfers.
>
>>  drivers/spi/spi-img.c | 703 ++++++++++++++++++++++++++++++++++++++++++++++++++
>
> How about spi-img-spfi?  That way if someone makes another SPI
> controller (say a more generic one, this one seems flash specialized)
> there won't be a collision.

Despite the name, I believe this controller is used for generic SPI
stuff as well.  I'm not sure if there is a separate one which is more
generic (James?).

>> +static void spfi_flush_tx_fifo(struct img_spfi *spfi)
>> +{
>> +     spfi_writel(spfi, SPFI_INTERRUPT_SDE, SPFI_INTERRUPT_CLEAR);
>> +     while (!(spfi_readl(spfi, SPFI_INTERRUPT_STATUS) &
>> +              SPFI_INTERRUPT_SDE))
>> +             cpu_relax();
>> +}
>
> This will busy loop for ever if we don't get the response we want from
> the hardware...  some cap on the number of spins would be good.

Ok, I'll add a timeout or something here.

>> +     while ((tx_bytes > 0 || rx_bytes > 0) &&
>> +            time_before(jiffies, timeout)) {
>> +             unsigned int tx_count, rx_count;
>> +
>> +             if (xfer->bits_per_word == 32) {
>> +                     tx_count = spfi_pio_write32(spfi, tx_buf, tx_bytes);
>> +                     rx_count = spfi_pio_read32(spfi, rx_buf, rx_bytes);
>> +             } else {
>> +                     tx_count = spfi_pio_write8(spfi, tx_buf, tx_bytes);
>> +                     rx_count = spfi_pio_read8(spfi, rx_buf, rx_bytes);
>> +             }
>
> switch statement please (here and elsewhere).  Apart from the
> defensivenes it means that we'll do the right thing if someone decides
> to add 16 bit support to the hardware.

Ok.

>> +             tx_buf += tx_count;
>> +             rx_buf += rx_count;
>> +             tx_bytes -= tx_count;
>> +             rx_bytes -= rx_count;

I don't think so.  The spfi_pio_* functions just read/write from the
FIFO until it's empty/full - they don't check for any errors, nor are
there really any to check for.  The loop will time-out eventually if
we are unable to transmit/receive the requested number of bytes.

>> +
>> +             cpu_relax();
>
> Seems random - we already relax in the data transfer?

We don't relax in the transfers - would that be a better place to put
it?  I thought it was better here since we reach this point once the
TX FIFO has filled or RX FIFO has emptied.

>> +     if (tx_buf)
>> +             spfi_flush_tx_fifo(spfi);
>> +     spfi_disable(spfi);
>
> What does the enable and disable actually do?  Should this be runtime
> PM?

It starts/stops the transfer.  The control registers (bit clock,
transfer mode, etc.) must be programmed before the enable bit is set
and the bit does not clear itself upon completion of the transfer.  I
don't think it makes sense to have this be part of runtime PM.

>> +       if (xfer->tx_nbits == SPI_NBITS_DUAL ||
>> +           xfer->rx_nbits == SPI_NBITS_DUAL)
>> +               val |= SPFI_CONTROL_TMODE_DUAL << SPFI_CONTROL_TMODE_SHIFT;
>> +       else if (xfer->tx_nbits == SPI_NBITS_QUAD ||
>> +                xfer->rx_nbits == SPI_NBITS_QUAD)
>> +               val |= SPFI_CONTROL_TMODE_QUAD << SPFI_CONTROL_TMODE_SHIFT;
>
> This suggests that dual and quad mode must be symmetric but doesn't
> enforce that; I rather suspect that in reality these modes are only
> supported on the transmit side.

Actually it looks like they are symmetric.  I'll update these checks
to enforce that.

>> +static irqreturn_t img_spfi_irq(int irq, void *dev_id)
>> +{
>> +     struct img_spfi *spfi = (struct img_spfi *)dev_id;
>> +     u32 status;
>> +
>> +     status = spfi_readl(spfi, SPFI_INTERRUPT_STATUS);
>> +     if (status & SPFI_INTERRUPT_IACCESS) {
>> +             spfi_writel(spfi, SPFI_INTERRUPT_IACCESS, SPFI_INTERRUPT_CLEAR);
>> +             dev_err(spfi->dev, "Illegal access interrupt");
>> +     }
>> +
>> +     return IRQ_HANDLED;
>> +}
>
> This will unconditionally claim to have handled an interrupt even if it
> didn't get any interrupt status it has ever heard of.  At the very least
> it should log unknown interrupts, ideally return IRQ_NONE though since
> it seems to be a clear on read interrupt that's a bit misleading.

There's a clear register actually (see the writel() above), but yes,
an error and returning IRQ_NONE sound appropriate in the event of an
unexpected interrupt.

>> +     ret = clk_prepare_enable(spfi->sys_clk);
>> +     if (ret)
>> +             goto put_spi;
>> +     ret = clk_prepare_enable(spfi->spfi_clk);
>> +     if (ret)
>> +             goto disable_pclk;
>
> We should have runtime PM callbacks to enable these clocks only when the
> controller is active, this will improve power consumption slightly - the
> core can manage the runtime PM for you.

Ok, will do.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
