From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Fri, 8 Nov 2013 15:16:57 +0100
Message-ID: <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
References: <20131104184511.GR2493@sirena.org.uk> <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org> <20131106094854.GF11602@sirena.org.uk> <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org> <20131106113219.GJ11602@sirena.org.uk> <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org> <20131106162410.GB2674@sirena.org.uk> <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131107203127.GB2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

On 07.11.2013, at 21:31, Mark Brown wrote:

> On Thu, Nov 07, 2013 at 01:43:39AM +0100, Martin Sperl wrote:
> 
>> The problem is that you intend to do prepare/unprepare transparently.
> 
> Please be more concrete and specific, I'm still really struggling to
> understand what your concern is.  Please do also reply to what's being
> said rather than deleting the entire mail, it makes it easier to follow
> the thread of conversation.
...
> Bear in mind that the goals here are to refactor the code so that the
> DMA mapping is factored out of the drivers (and can be moved so that it
> runs in parallel with transfers), factor out the handling of /CS and in
> general the handling of message breaks and avoid all the drivers having
> to implement the logic required to push transfers from interrupt context
> where possible.

OK - I believe I start to see where we are diverging with our ideas about
prepare_message.

You want to refactor the message pump mechanism reducing driver code size,
which is commendable (I like the idea of having a "generic" scheduler on 
interrupt from any GPIO pin, but there are others that come to my mind as
well). And part of this you want to make drivers move away also from the 
transfer_one_message interface. And for that you need the drivers to have 
prepare and unprepare functions, which are called from the spi_pump (hence
the description, that those are called from threaded context).

While I am more concerned about the cost of running a prepare EVERY time we
schedule a message - and that becomes significant CPU utilization if you 
look at my report (doing the setup calculation for the DMA of a message,
with 2x2 Byte (write_then_read) transfer at 8MHz takes about as long as the
actual transfer over the bus. (if more data gets transmitted the ratio 
changes to the transfer side)

So my idea was to create something like SQL prepared statement API that
allows the driver to say: Hey, here is a message, that I will not modify
from a structure perspective - I still retain the "ownership" and I am
still responsible for releasing it before releasing the memory itself.

So this api, I would now call it driver_prepared_message to make a 
distinction to your case.

This specific API call would do the following:
* run its own sanity checks once (the ones in __spi_async)
* run the prepare_message function of the bus-driver (we would need to 
  keep some data in the spi_message structure that the driver may assign
  for future reference: "message->prepared_data=kalloc(...);" )
* mark the message as prepared - say message->is_driver_prepared=1;

Would this description above describe your and my "points of views"?
(not in all details, but close?)

If so then, the __spi_async call could look like this (the functions are
not in the correct order for the compiler not to complain):

struct spi_message {
	...
	/* set by spi_prepare_message() */
	unsigned                is_driver_prepared:1;
	/* an opaque structure for prepared messages 
	 * allocated on spi_prepare_message()
	 * freed in spi_unprepare_message()
	 */
	void			*prepared_data;
	...
};

static int __spi_async(struct spi_device *spi, struct spi_message *message)
{
	int ret;
	/* the non driver-prepared path */
	if (! message->is_driver-prepared) {
		/* prepare the message */
		ret=__spi_prepare_message(spi,message);
		if (ret)
			return ret;
	}
	/* setting up some fields in message */
	message->spi = spi;
	message_status = -EINPROGRESS;
	/* here we might also want to have a driver function to schedule
	 * the message immediately say to DMA, but still use the spi_pump
	 * worker for some part of the driver like memory cleanup,...
	 * if (spi->master->schedule_prepared_message_irqcontext)
	 *  spi->master->schedule_prepared_message_irqcontext(spi,message);
         */
	/* and the "normal" call of transfer, which typically would call
	 * the spi message pump.
	 */
	return master->transfer(spi,message);
}

static int __spi_prepare_message(struct spi_device *spi,
	struct spi_message *message)
{
        struct spi_master *master = spi->master;
        struct spi_transfer *xfer;

	/* the parts from __spi_async that handle message verification */

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

	/* and the custom prepare call of the bus-driver */
	if (spi->master->prepare_message)
		return spi->master->prepare_message(
			spi->master,message);

	return 0;
}

/*
 * the function that allows the driver to prepare a message
 * for later use without further processing overhead
 * the driver will retain ownership of the memory,
 * but is NOT allowed to make any changes to the structure
 * of the message in especially not:
 *   * list of transfers
 *   * length of an individual transfer
 *   * bits/speed/...
 *   * tx_buff, tx_dma
 *   * rx_buff, rx_dma
 * the driver may modify the data inside
 *   tx_buff, rx_buff
 * the calling driver has also the obligation to call
 * spi_unprepare_message prior to releasing the memory
 * erasing the message structure. 
 */
static int spi_prepare_message(struct spi_device *spi,
	struct spi_message *message, bool is_prepared)
{
	int ret;
	/* call the internal code but mark message as prepared */
	ret=__spi_prepare_message(spi,message);
	/* mark the message as prepared if there was no error*/
	if (!ret)
		message->is_driver_prepared=1;

	return ret;	
}

static int __spi_unprepare_message(struct spi_master *master,
	struct spi_message *message)
{
	int ret;
	/* if the message is not prepared, then call the handler */
	if (master->unprepare_message)
		ret=master->unprepare_message(master,message);

	/* and clear the memory structures */
	message->is_driver_prepared=0;
	message->prepared_data=NULL;

	return ret;
}

static int spi_unprepare_message(struct spi_device *spi,
	struct spi_message *message)
{
	return __spi_unprepare_message(spi->master,message);
}

void spi_finalize_current_message(struct spi_master *master)
{
        struct spi_message *mesg;
        unsigned long flags;

        spin_lock_irqsave(&master->queue_lock, flags);
        mesg = master->cur_msg;
        master->cur_msg = NULL;

        queue_kthread_work(&master->kworker, &master->pump_messages);
        spin_unlock_irqrestore(&master->queue_lock, flags);

	/* call the unprepare message if case the message is not driver prepared */
	if (!message->is_driver_prepared)
		spi_unprepare_message(mesg->spi,mesg);

        mesg->state = NULL;
        if (mesg->complete)
                mesg->complete(mesg->context);
}

there is only one thing to this:
As mentioned above, you have described the prototypes for prepare/unprepare message
as getting called from threaded context. This obviously is not (necessarily) true if 
you handle the prepare in the __spi_async function.

But waiting for the spi_pump thread to wake up is wasting valuable time waiting
for the scheduler - especially if you could submit the message to DMA immediately.
But if you get that far, then the DMA driver would also be running the complete 
calls from the DMA-IRQ handler to avoid the "scheduling" latencies in the complete
path as well...

So I hope I have summarized your ideas and you have now also a better understanding
for what I want to achieve and where I see places that can reduce CPU cost and 
latencies... I believe we could come to a common solution that fits both sides.

Thanks, Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
