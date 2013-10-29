From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Fwd: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 29 Oct 2013 12:09:23 -0700
Message-ID: <CACRpkdb4mn_Hxg=3tuBu89n6eyJ082EETkwtNbzZDFZYTHbVVg@mail.gmail.com>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F70C4469-6325-48D5-A7CA-52CC1FC404BD-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Here is Martins original message.

Yours,
Linus Walleij


---------- Forwarded message ----------
From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Date: Mon, Oct 28, 2013 at 11:42 AM
Subject: Depreciated spi_master.transfer and "prepared spi messages"
for an optimized pipelined-SPI-DMA-driver
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org


Hi!

I am currently writing an SPI driver for the raspberry pi that only
relies on DMA for the whole transfer.
It can already handle a FULL SPI_message with multiple transfers,
CS_CHANGE, and speed_hz changes only by using DMA, so it is using the
dma to the max...

Right now (for the ease of "development") the driver is still using
the transfer_one_message interface.
But unfortunately this interface introduces latencies/gaps between
individual messages because of the latencies: interrupt ->
wakeup_spinlock->schedule message_pump_thread.

So as the DMA driver is already handling a single SPI transfer very
efficiently, there is also an option to chain multiple SPI transfers
in the DMA engine and just get interrupts for completion.

This I why I thought of moving away from spi_transfer_one_message and
back to the simpler transfer interface, where the preprocessing would
get done (DMA control block-chain generation) and then appending it to
the existing (possibly running) DMA chain.

But just yesterday I was looking thru the code and came to the
message: "master is unqueued, this is depreciated" (drivers/spi/spi.c
Line 1167).
This came in with commit ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0 and
got included in 3.4.

So I am wondering why you would depreciate this interface - I agree
that for most drivers moving to the transfer_one_message interface is
the way forward and reduces code size and bugs.
And this depreciation message will hopefully motivate driver authors
to rewrite their code to make use of the new interface.

But there may be some drivers that would really benefit of using the
more complex interface without it getting depreciated and at some
point possibly removed.
And I believe that the pipelined DMA driver is a good candidate to
show that under some circumstances the transfer interface may still be
the better solution...
Obviously I could work around the inner working of the message-pump by
manssaging the data before some of the calls, which I would say is
even more depreciated!

Now this brings me to different question:
Could we implement some additional "functions" for preparing an SPI
message to reduce the overhead of computation of a spi message
repeatedly by keeping a "prepared" Transaction, which we just need to
schedule it. Changing data would not be a problem, but changing the
data block-addresses would be a change. that would require
recalculating the data.

The interface could looks something like this:
int spi_prepare_message(struct_spi_dev*, struct spi_message *);
int spi_unprepare_message(struct_spi_dev*, struct spi_message *);

together with an additional object (void* prepared) in the spi_message
structure for keeping such prepared data...
OK - abusing the existing queue and state  could be used, but -if i
read the comments correctly - this data is only guaranteed to be
available to the driver between spi_async and the corresponding
callback (outside of it it is used used by the message pump and gets
cleared in spi_finalize_current_message function.


Thanks,
              Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
