From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Sun, 10 Nov 2013 17:41:30 +0100
Message-ID: <3361A01A-C7D0-4689-AFBD-085D3E62A67C@sperl.org>
References: <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <20131110110524.GA878@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131110110524.GA878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10.11.2013, at 12:05, Mark Brown wrote:
> An example of the sort of thing I'm concerned about: if I understand
> correctly one of the things the prepare and unprepare operations in the
> driver do is the DMA mapping.  This will mean that if you prepare in the
> caller the system will be able to do the DMA mapping while a prior
> transfer is in progress which should help performance.  That's a good
> thing to do but it should be something that can be done as part of the
> existing API without needing drivers using SPI to be updated.

yes - but that comes back to my argument that this is feasible to do 
transparently within the framework, but the cost of doing so would
eat away most of the possible performance gains unnecessarily and make the
situation worse for situations where there IS a change.

As explained - you would need to make an educated guess if a spi_transfer 
chain has changed or not (and I talk about the need to check the chain 
itself, speed, transferlength, rx_buff,tx_buff,... have not changed).

Doing this sort of checking will still take a few usecs per message and call.
One could do some hashing (with the risk of collisions) or keeping a second
copy of the data and do a byte wise compare of spi_message and the spi_transfer
chain. Or some other.

But still this requires processing you need to run on each spi_async call, 
independently if it has been prepared via the framework preciously or not.

And the risk of finding a false positive is non-0 (in case of hashing) and 
then you still spend spinning CPU cycles on it (not to mention the debugging
nightmare if such a situation occurs on a production system)

So you waste CPU cycles unnecessarily for something where you are unsure.

So assuming you need 1us per message for this kind of "test" if the structure 
has changed or not, and you run 3000 such SPI messages/s, then you are wasting
3ms of time.

And (again to repeat myself) you have on top of that a memory management
issue, because you then would need to garbage collect your prepared resources
for all those cases where the message just got allocated on the heap and 
discarded afterwards - there is no means in the current API to release the 
memory when releasing the memory of the spi_message. 
So to make things efficient here you would need to extend the API - but this
time it would be a mandatory change for all drivers (and I doubt you will find
EVERY instance resulting in bugs to fix down the road)

Also with this approach the "message" would possibly need to get prepared in
IRQ context (because spi_async can get called from interrupt handler) 
which would require allocation of memory in GFP_ATOMIC context just to play 
it safe in all situations. Not so good either.

I am mostly seeing this "spi_prepare_message" as a method for the driver to 
give some optimization hints to the engine to minimize "parsing" of the 
structures. 

And I would also prefer - if possible - to see the API to be able
to allocate memory from "blocking" memory pools, so the spi_prepare_message
would be allowed to run only in threaded context and may not get called from
interrupt contexts. Anyway those "typical" calls can easily get prepared 
during the module initialization phase and to avoid memory allocation in 
interrupt handlers and callbacks...

Ok - I have tried to explain my concerns again.

So if you still think you can do the things requested via the framework, then

Here a "quick" example where the "prepared messages" would reduce CPU overhead
immediately without any bus-driver specific implemention:

static int __spi_async(struct spi_device *spi, struct spi_message *message)
{
        struct spi_master *master = spi->master;
        struct spi_transfer *xfer;
+	/* run the below computations only if our message has not been changed */
+ 	if (__spi_message_has_changed(spi,message)) {
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
+		/* call spi_prepare_message */
+		if (master->prepare_message) {
+			ret=master->prepare_message(master,message);
+			if (ret)
+				return ret;
+		}
+	}
        message->spi = spi;
        message->status = -EINPROGRESS;
        return master->transfer(spi, message);
}

So how would you implement the __spi_message_has_changed function in a manner 
that is performance efficient and worth called in a "hot-path"?

And how would you handle the garbage collection required for the "transparent case"
you are trying to get.

Please stop wishfull thinking, instead provide alternative ideas how to solve the issue.

Please provide a solution that works as simple as:
/* in the driver init code - if you want to "improve" the latency of spi_async */
spi_prepare_message(spi,message);
/* in the driver release code - if you want to "improve" the latency of spi_async */
spi_unprepare_message(spi,message);

/* and the "check" itself */
static int __spi_message_has_changed(spi,message) 
{ 
	return (! message->is_driver_prepared); 
}

So what about the performance measurements I have mentioned?
Do you have any concerns with the described approach and the metrics proposed?
You want me to measure and publish those results?

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
