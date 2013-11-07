From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Thu, 7 Nov 2013 01:43:39 +0100
Message-ID: <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
References: <20131031001004.GW2493@sirena.org.uk> <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org> <20131104184511.GR2493@sirena.org.uk> <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org> <20131106094854.GF11602@sirena.org.uk> <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org> <20131106113219.GJ11602@sirena.org.uk> <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org> <20131106162410.GB2674@sirena.org.uk> <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131106232605.GC2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

The problem is that you intend to do prepare/unprepare transparently.

OK - but I see problems with heuristics on when it is safe to assume
that a message has not been changed since the last call (either xfers
or tx/rx_buff pointer). If it has not changed then we can use the cached 
computations from the previous step ( equivalent to prepared).

Figuring out if the message has changed or not is consuming too much CPU
and that is - as far as I am understanding - the main reason why we want to 
have the option to prepare/unprepare a message: save CPU cycles.

See my "quick&dirty" modification to _spi_async how prepare could help 
improve avoid spending CPU cycles even for "normal" cases that do not 
run on HW where preparing would not help except for avoiding running the 
sanity checks on the message every time.

As said: running a single transfer 10000 times/s will run the following code:
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

10000 times/s.

With a "prepared" message by the driver instead, this message would get prepared 
(maybe in this case better call it sanity-checked) once and from then on this
piece of code does not get run at all, which would reduce CPU load immediately.

But if you have to loop over the message to see if it has changed (by calculating 
a checksum or comparing to something else), then you have lost this opportunity 
to optimize out the above code...

Is the above described scenario of 10k spi messages/s realistic?

Yes - definitely.

The can Driver for which I have started my investigation is processing about 3200 
can-messages/second. Each generates an interrupt - so 3200 interrupts and each
is sending 3 spi_messages with multiple transfers in sequence (all of which can
get and are already prepared...)

So we are essentially at the example above with 9600 SPI messages/s and the
code getting run 9600 times unnecessarily.

Obviously this is not so important for drivers that run maybe 10 SPI messages/s, but 
it becomes an important factor at higher volumes.

That is the reason why I am so persistent about this subject and trying to get
a solution that does not require a lot of CPU cycles.

Ciao,
	Martin

P.s: And my guess is that avoiding this "sanity-check" alone would reduce the 
system load for my test-case by 2-3% alone that would be down from 77% to 74% CPU.
(and I am sure I can bring it down further if I am moving away from the scheduling
overhead that is immanent to the "transfer_one_message" worker interface.
The preparing of the DMA Structure reduced the System load by about 7-8%.

I can try to quantify this number if you really want by NOT using spi_async but calling 
  message->spi=spi;
  message->status=-EINPROGRESS;
  status=spi->master->transmit(spi,message);
directly.

But not tonight...

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
