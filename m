From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 12 Nov 2013 15:42:59 +0100
Message-ID: <52823E73.503@sperl.org>
References: <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131112011954.GH2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

 >> It will deliver a performance improvement by not having to create 
identical
>> structures or running sanity thest every time you transmit the prepared message.
>
> But is that a 0.01% improvement or a 50% improvement and is that because
> we're pushing a silly implementation into a corner or because there's
> actually substantial work that needs doing there?

well - in the case of the DMA driver of mine it is an 8% improvement
so from 88% System load down to 80% System load. (and the current code 
is still walking some lists to find a match - to avoid changing spi.h 
for now)

And that is with the transfer_one_message approach.

I will try to find some time to patch spi.c so that it will toggle the
CS lines while it is doing the "verification" code. then I can look
with my logic analyzer to see how many ns it takes (in 64ns step 
granularity).

And then I will take the stock spi-bcm2835 driver from upstream and
the enc28j60 network driver also from upstream and report on those numbers.

Note that - as far as I have seen - the enc28j60 is mostly using 
write_then_read for its SPI-transactions

>
> If the error checking and so on is really that expensive this sounds
> like we need to fix that anyway, even if it's just quick things like
> making some of the validation debug only or pushing some of the work
> out to the message update functions.
>
> The messages and transfers ought to be totally reusable already, the
> only bit that should need to be recreated is any data the driver creates
> internally, most likely that's only going to be data for DMA.  We do
> already have an interface for drivers to do the DMA mapping though it's
> not very well loved at the minute...

Well - that is what I have been asking for - a means to shortcut the 
computation and a set of 2 fields (one flag and one void pointer both of 
which are defined as fully owned by the bus driver - unlike state and 
queue, which is ONLY in the ownership of the driver/framework between 
calls to spi_async() and complete())

What DMA-interface are you talking about? at least in spi.h in 3.10 I 
find nothing that would indicate an extra DMA interface...

>> And for the DMA chains I have to create DMA chains that are of a length 10-20
>> - depending on the number of transfers.
>
> What's the expense here - the mapping or something else?  This does also
> seem like a lot of scatter/gather, why is the data so spread out and is
> there room to do better in the client driver?
Well - that is a bit long to answer, so here a short description first:

the driver runs ALL configs of the SPI-register needed also via DMA. The 
main reason for this is that I want to be able to pipeline the DMAs 
without any interaction from the CPU - besides the scheduling/chaining 
to existing DMA and in case the message defines a complete() callback, 
then trigger an interrupt for that portion. (with the driver still using
the spi_message_pump and transmit_one_message, this

this means that as long as you just schedule spi_async messages, then 
the DMA is doing everything on its own.

So (with some extension to the SPI API to allow for cyclic messages) you 
may even run a LCD display that gets updated 25 times per second 
streaming from two frame buffers to the display. And that without any
CPU interaction at all (besides the complete() if you need to get 
notified of the buffer "swap").

But that is an idea for the future...

So here the long description on what we need to do for say a message 
that implements write_then_read (2 bytes write, 10 bytes read) showing 
the RX and TX DMA:

RX-DMA                                    TX-DMA
configure CDIV register
  (= SPI Clock Divider)
reset RX/TX-FIFOs
configure number of Bytes in TX/RX-DMA (2)
configure Control-register to start SPI
configure next Control block for TX-DMA
trigger start of TX-DMA controlblock
                                           Transfer 2 bytes to SPI-FIFO
transfer 2 bytes from SPI-FIFO (with DST_IGNORE)

 >> if delay_usec is set, then:
configure some delay cycles in DMA by
   (tranfer X bytes with DMA_IDLE_CYCLES=31
    and SRC_IGNORE and DST_IGNORE)

 >> if the transfer would have been a multiple of 4 and cs_change is NOT 
set and no change in CDIV we would skip the following steps:

 >> if change_cs is set for the transfer:
configure Control_register to bring CS up
configure some delay so that CS is high for
   about half a SPI-clock cycle (otherwise
   devices might not recognize it)

 >> now the second transfer:

 >> if cdif has changed, then:
configure CDIV register
  (= SPI Clock Divider)

reset RX/TX-FIFOs
configure number of Bytes in TX/RX-DMA (10)
configure Control-register to start SPI
configure next Control block for TX-DMA
trigger start of TX-DMA controlblock


 >> here we continue (in case the first transfer is a multiple of 4)
                                           Transfer 10 bytes to SPI-FIFO
                                             (with src_ignore, so 0)
transfer 10 bytes from SPI-FIFO

 >> if we need to trigger a DMA (because of callback())
configure next Control block for TX-DMA
trigger start of TX-DMA controlblock
					  transfer information which
					  message we have finished
					  and trigger DMA Interrupt

So this includes "all" options that we have currently implemented in SPI 
(change_cs, speed_hz, delay_usec) and which the device supports.

And as mentioned in the "short" description the next message can get 
chained immediately to the last control block of the RX-DMA chain.
And all that with minimal delay and CPU overhead (as soon as the chain
has been set up).

This "chaining" is _obviously_ not possible with the transfer_one 
message BUS-master-API (or it would require some "ugly hacks" to make 
use of transfer_one_message API)

The code right now does not make use of dmaengine, but is using dmapool
for memory management of the control blocks+extra management data.

And this is taking some time already without even going thru the 
dmaengine layer, which possibly would mean two allocations instead of a
single

And that setup cost of this is what I would like to avoid to run for 
every time we call spi_async for a spi_message that has not changed.

> We ought to modernise this interface to be more in tune with what
> dmaengine is doing anyway (probably taking scatterlists for example) -
> you were also talking about DMA a lot in some of your earlier messages
> and it is where I'd expect the cost to be so I'm wondering if this isn't
> actually more to do with this interface being poor and if we don't need
> dmaengine changes too to realise the benefits.

You might look at my example above (and at some time at the driver code 
itself - when it becomes stable - unless you want to peak at git-hub..) 
to see how we may generalize it.

And at least in the ARM arena it should be possible to apply the same
principle to other SPI controllers+DMA as well. But you might need to 
work around some HW bugs that differ from the 4 that I have found in the 
bcm2835 SOC (DMA-Interrupt only on chain end, CLEAR-FIFO-TX will bring 
CS high in 5% of all cases, CLEAR-FIFO-XX+start transfer will trigger a 
bug that some SCK does not change while MOSI does change, ADCS needs to 
be set for "the described" way to do SPI-DMA on the SOC - which is 
totally different from what I do to get all features into the DMA 
chain), so other "scheduling plans" might be needed.

So I would not try to come up with a generic approach when we have a 
single driver that can do that right now.

Well - as said I am wondering if the DMA engine can really can help - 
especially if you want to keep the "prepare" code fast. I am using
dmapool for memory alloc/free, but I fear we would need to run 2 mallocs
if I was using DMA-engine and more setup/tear-down overhead, as well
as more code that needs to get executed to go via DMA-engine.

As said: I will keep it as is for now and first implement the full DMA
chaining approach. then we can see how much the move to DMA-Engine is 
costing...

> I'm not clear on the easy to implement bit here (though obviously there
> haven't been patches posted for review yet), especially the interaction
> with DMA if that's a part of this, or what exactly you're expecting to
> be allowed to happen to the message while it's been partially initalised
> by the driver (I wouldn't use the term prepared for what you're
> suggesting by the way, I'd expect preparation to be interacting with the
> hardware) since that will affect how widely clients could take advantage
> of this.
well, my naming comes form the analogy of prepared SQL statements, which 
also takes a SQL and precompiles an optimization plan for it once.
The big difference is that comparing 2 SQL-strings is cheaper than 
comparing 2 memory structures and DBs typically run on much faster HW 
than an ARM at 700Mhz, so the prepared SQL is not so important any more.
It is still kept as a hint to the execution planner (also it reduces 
bytes to transfer over the network...).

As for "unmodified" drivers taking advantage of this:
I believe that any driver that only uses the sync interfaces spi_read, 
spi_write, spi_write_then_read can get improved (at the cost of memory)
by having optimized versions of those functions that keep the structures 
in a cache for the "hot" path.
But then all those drivers that make use of the sync interface are not 
geared towards thru-put in the first, as they are blocking, so these are
not the prime "candidates" for the improvement in the first place.
If they want to run with minimal latencies, they HAVE to run spi_async.
Anything else is not very efficient as it requires several context 
switches by the way of the current design.

> The other bit of easy to implement that concerns me is making sure that
> it's easy to implement for the stack as a whole - one of the big
> problems with the existing stack is that there is too little factoring
> out of code into the core so we end up with individual drivers
> implementing good ideas that are widely useful and most drivers being
> basic so drivers are more complex to review and the benefits are not
> widely distributed.  This makes me worry about an API that just
> delegates everything to the driver and which requires both master and
> client drivers to specifically support the feature.
If you can get away from the idea that prepare is ONLY related to the 
Master, then it may provide additional "advantages". Also when you do 
have a non-prepared message, you can still can call the prepare code 
from the framework and afterwards unprepare it - like I had proposed.
That way any "checks" the driver would need to do to see if it can 
handle the message, it can do immediately in the "prepare" code.

So essentially start to think of "prepare_message" as: do any 
verifications on the message that is needed to set it up correctly and 
find unsupported situations as well as optimize the message into 
whatever the driver may find helpful for its own purpose. One candidate 
here could be also implement dma_map_single in the prepare call...

Then the change would look like this:
static int __spi_prepare_message (struct spi_device *spi,
                 struct spi_message *mesg)
{
	/* sanity check message and copy the fields - see __spi_async */

	/* call master prepare if it exists */
	if (spi->master->prepare_message)
		return spi->master->prepare_message(spi->master,mesg);

	return 0;
}

static int spi_prepare_message (struct spi_device *spi,
                 struct spi_message *mesg)
{
	status=__spi_prepare_message(spi,mesg);
	if (!status)
		mesg->is_prepared=1;
	return status;
}

static int __spi_unprepare_message (struct spi_device *spi,
                 struct spi_message *mesg)
{
	/* call master prepare if it exists */
	if (spi->master->unprepare_message)
		return spi->master->unprepare_message(spi->master,mesg);
	return 0;
}

static int spi_unprepare_message (struct spi_device *spi,
                 struct spi_message *mesg)
{
	mesg->is_prepared=0;
	return __spi_unprepare_message(spi,mesg);
}

static int __spi_async(struct spi_device *spi,
                 struct spi_message *mesg)
{
	int status;
	/* prepare the message using the internal prepare */
	if (!message->is_prepared) {
		status=__spi_prepare_message(spi,messsage);
		if (status)
			return status;
         message->spi = spi;
         message->status = -EINPROGRESS;
         return master->transfer(spi, message);
}

And this is what I would envision as a total change you would have to 
do... (besides the 2 fields as mentioned...)

So now if you want to start refactoring the transfer_one into a generic 
version - as far as I know it could get reduced to:

static int spi_transfer_one(struct spi_master *master,
                 struct spi_message *message)
{
	int status;
	/* schedule the message in the Controller */
	status=spi->master->schedule_message(master,message);
	if (status)
		goto error:
	/* wait for completion */
	if (wait_for_completion_timeout(
                         &bs->done, /* wherever you put complete */
                         msecs_to_jiffies(SPI_TIMEOUT_MS)) == 0) {
		status=-ETIMEDOUT;
	}

error:
	if (!message->is_prepared) {
		status=__spi_prepare_message(spi,messsage);
		if (status)
			return status;

	spi_finalize_current_message(master);
	return status;
}

with this the bcm2835_spi_transfer_one function could (mostly) get 
reduced to: bcm2835_spi_start_transfer (and some of the additional 
xfer-scheduling moved to the interrupt handler).

So separating things out immediately reducing code of the individual 
drivers if they move to the newer interface of schedule_message...
if they do not need prepare/unprepare, then it is (almost) a NOP.

> Right, and what I'm saying is that I'm not clear what's being done in
> that code and hence why moving it makes a difference.

well - the calculation of the above DMA chain takes a few usecs.
and with the code "above" plus the prepare in the driver we avoid those 
few usecs that get run every time.

> Adding new interfaces is a change too, on the driver side as well.
Which is optional and would get first used only by device-drivers that 
need high tru-put. And those device-drivers that need this, should 
already be heavily optimized to avoid memory allocations (even if it is 
just on the heap) and message setup for every call.

> These seem rather artificial and I'm not sure they'd tell us much about
> why the effects were being observed.  What would be more interesting
> would be seeing where the time is being spent at the minute for real
> loads (for example by using trace points like those that are currently
> being added in mainline for examining the behaviour of the message pump)
well - my use case is exactly that CAN issue where I have message loss
when only sending 5 packets in sequence in 30% of all cases with stock 
drivers. That is why I started investigating the issue in the first 
place - so do not tell me it is academic!

The proposed SPI-test driver is academic to some extent, but it still 
tries to simulate "real" device traffic with optimal thru-put.
Or do you think that reading an ADC as fast as possible is an academic 
exercise? (the test driver would essentially mimic that and allow for
scheduling mechanism to work that allow high thruput (if you configure 
multiple messages)

> - if we really are spending a noticeable proportion of the time in setup
> then that's obviously a good case for optimising it but right now I
> don't feel I understand which bits are slow enough to register in the
> context of the overall transaction and hence if the suggested approach
> is the best way to optimise them.
well - you see the setup I have to make to transfer 2 writes 10 reads?
that is 10+ calls to dmapool_alloc, then filling in the structure.
That takes some time (cant remember how many usec right now).
And then tearing it down I need to do the same again - ok mostly 
dmapool_release...

> An implementation that avoided the need to have the master drivers
> updated in order to get benefits would be a lot more interesting since
> that would make this much more generally useful, and of course concrete
> patches would be good too, but the main thing I'm missing is clarity on
> how the gains are being made.
a master driver will never be able to profit from the new interface, 
besides the "small" gain of not having to validate the messages every 
time in __spi_async (if the device-driver does call prepare)

And as said: all the spi_sync methods are candidates to optimization of 
this - at the cost of some memory used for caching multiple messages.
(say having 16 times 1xspi_message+1xspi_transfer structures for 
transfer length 1 to 16 in spi_write. Similar for spi_read. Or 256 
1xspi_message+2xspi_transfer to transfer 1-16 writes and 1-16 reads.
plus some memory copy for the reads and writes)

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
