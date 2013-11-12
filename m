From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Tue, 12 Nov 2013 18:59:02 +0100
Message-ID: <2252E63E-176C-43F7-B259-D1C3A142DAFE@sperl.org>
References: <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52823E73.503-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

First, sorry for the bad formatting in the last email - it looked ok when typing 
it with Thunderbird... I even used the recommended plugin to make it wrap 
correctly (still format=flowed).

OK, but here some statistics that I had promised.
I got the following data from my logic analyzer with a patched spi.c
that brings CS down while running the sanity check in __spi_async!
(note that this kind of debugging has some potential race-conditions with HW 
- if a DMA-transfer is running -  but for the minimal cases it gives
good enough data with minimal "overhead")

This is the code that I measure:
	/* bring CS1 down by switching polarity */
        writel((1<<22),*regs);
        /* Half-duplex links include original MicroWire, and ones with
         * only one data pin like SPI_3WIRE (switches direction) or where
         * either MOSI or MISO is missing.  They can also be caused by
         * software limitations.
         */
        if ((master->flags & SPI_MASTER_HALF_DUPLEX)
                        || (spi->mode & SPI_3WIRE)) {
                unsigned flags = master->flags;

                list_for_each_entry(xfer, &message->transfers, transfer_list) {
                        if (xfer->rx_buf && xfer->tx_buf)
                                return -EINVAL;
                        if ((flags & SPI_MASTER_NO_TX) && xfer->tx_buf)
                                return -EINVAL;
                        if ((flags & SPI_MASTER_NO_RX) && xfer->rx_buf)
                                return -EINVAL;
                }
        }

        /**
         * Set transfer bits_per_word and max speed as spi device default if
         * it is not set for this transfer.
         */
        list_for_each_entry(xfer, &message->transfers, transfer_list) {
                if (!xfer->bits_per_word)
                        xfer->bits_per_word = spi->bits_per_word;
                if (!xfer->speed_hz)
                        xfer->speed_hz = spi->max_speed_hz;
                if (master->bits_per_word_mask) {
                        /* Only 32 bits fit in the mask */
                        if (xfer->bits_per_word > 32)
                                return -EINVAL;
                        if (!(master->bits_per_word_mask &
                                        BIT(xfer->bits_per_word - 1)))
                                return -EINVAL;
                }
        }
	/* bring CS1 up by switching polarity again */
        writel(0x00,*regs);

Depending on the message actually delivered I see that CS is down for about 
1 transfers/message: 0.75us
3 transfers/message: 2.5us
8 transfers/message: 4.7us

Now the preparing of the DMA structure described before takes:
1 transfers/message: 26us
2 transfers/message: 18-23us
3 transfers/message: 46-55us
8 transfers/message: 106us

There are obviously variations depending on what data is in L2 cache.

As for other interesting measurements a single example with 5 transfers:
Interrupt to __spi_async:     19us
__spi_async sanity start/end:  2us
__SPI_ASYNC to DMA_PREPARE:   99us
dma_prepare start/end:        40us
dma_prepare_end to CS DOWN:    4us
CS DOWN to CS UP:             16us (real transfer)

the values differ between interrupts, but I believe it still shows
where we see the delays that produce latencies.

If we use the prepare Message interface, with my proposed change
then the 2us for sanity checks are not applied
and also 40us for dma_prepare are not applied.

This shows that we can reduce necessary CPU cycles both for "normal"
use for bus drivers that do NOT implement any internal "preparations"
to make DMA work and how much we can save if we go the DMA route.

Also you see how long it takes from the time we have called transfer
to the time when DMA_Prepare gets run inside transfer_one_message?

This is actually one of the biggest "factors" to latency on its own.
And that is the scheduling delay of the message-pump!

So the "threaded" approach - even though nice on paper - is actually
introducing long latencies. And that is why i would like to see how 
a fully DMA pipelined driver would fare - my guess is that the delays
would be much smaller. It will not change the delays interrupt to
running the handler, but the scheduling of the message pump would go
away immediately.

To summarize: 10k SPI messages/s with stock drivers produce 10ms/s of 
CPU utilization when running with "stock" code. When optimizing the
device-drivers to run the same messages prepared (by adding the
spi_prepare/unprepare_message in the initialization phase) we save
about 1% System CPU (assuming messages with a single transfer)

So I hope that these are some hard enough facts for you to say, that 
"preparing" messages, that do not "change in structure" in a device
driver _does_ bring an advantage.


Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
