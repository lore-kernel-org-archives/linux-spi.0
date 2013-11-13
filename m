From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 19:35:27 +0100
Message-ID: <ED58E869-A9F6-4BB2-8EC6-D71F946509DC@sperl.org>
References: <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <2252E63E-176C-43F7-B259-D1C3A142DAFE@sperl.org> <20131113154346.GT878@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113154346.GT878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark
>> As for other interesting measurements a single example with 5 transfers:
>> Interrupt to __spi_async:     19us
>> __spi_async sanity start/end:  2us
>> __SPI_ASYNC to DMA_PREPARE:   99us
>> dma_prepare start/end:        40us
>> dma_prepare_end to CS DOWN:    4us
>> CS DOWN to CS UP:             16us (real transfer)
> 
> This is making me question the use of DMA at all here, this looks like
> the situation of a lot of drivers where they switch to PIO mode for
> small transfers since the cost of managing DMA is too great.  I'm also
> curious which parts of the DMA preparation are expensive - is it the
> building of the datastructure for DMA or is it dealing with the
> coherency issues for the DMA controller?  The dmaengine API currently
> needs transfers rebuilding each time I believe...
> 
> Also how does this scale for larger messages?
> 
> I appreciate that you want to push the entire queue down into hardware,
> I'm partly thinking of the costs for drivers that don't go and do any of
> the precooking here.

Well - if you look at the above example:
it takes 99us to get from SPI_ASYNC (post-message check) to dma_prepare
inside transfer_one_message. And this is the time spent in the framework
AND scheduler!

The DMA prepare takes 40us you still can run the DMA Prepare in the same 
time and be faster... 8OK, I did not account for the "teardown" time, but
that should be faster, as it just walks the list and returns it to the
dmapool.

Also keep in mind that this message is (as said) actually comprised of 5
spi_transfers in a chain with two of those having set CHANGE_CS, so it is
already a "bigger" spi_message than you would typically see.

A write_then_read (2 transfers) has a "setup time of about 23us. 
But as this transfer happens during "setup" the dmapool may not have any 
pages allocated yet, which increases the overhead for allocation and thus
adds a bias to this measurement.

You also see that this driver is already trying to keep the latencies as
short as possible by using the chaining instead of issuing each of those
CS-enable sequence separately.

So in the end we can give a rough estimate that it takes 10us/transfer to
process - so that means we are getting the same thru-put delay for DMA 
(prepared) versus interrupt-driven (Polling being the worsted) for 
spi_messages which are <=10 transfers. Which is already a pretty big spi
message...

But then you should not forget that whith the Interrupt driven approach, 
you have delays between each transfer due to interrupts, when you 
reconfigure the data registers. And I am 100% certain that you will not
be able to achieve a 1us delay between 2 transfers (of arbitrary size)
in interrupt driven mode. This is again CPU cycles (which I am not even
sure are correctly accounted for in sys_cpu). And then on top of that -
at least the spi-bcm2835 interrupt makes a wakeup call to the workqueue
whenever it finishes a single transfer (and again the scheduler gets 
involved...). That is also why I have reported a high Interrupts and 
context-switch rate for this driver.

So you think this is really cheaper from the CPU perspective to take the
Interrupt-driven approach?

(note also that I have set the spi_queue to run with RT-priority, so the
spi_pump has a huge advantage getting CPU...

> 
> Exactly, but this is largely orthogonal to having the client drivers
> precook the messages.  You can't just discard the thread since some
> things like clock reprogramming can be sleeping but we should be using
> it less (and some of the use that is needed can be run in parallel with
> the transfers of other messages if we build up a queue).
Ok - the clock setting is possibly valid for some SPI devices, but not for
all. And we all know that a "one-size fits all" does not scale in 
performance.

Also it may be a possibility that different devices have different 
feature-sets, where in part we need to drop back to something else (thread).

At some point I had been playing with the idea of doing just that - having
a spi_pump to handle things like delay and to work around stupid "bugs"...
but still trying to do as much as possible within the DMA I found something
that solves everything that we have as abilities in the API right now.

But I have to admit, that it required a lot of effort coming up with 
something that works (and it also produces a lot more code) and also
it uncovers a lot more HW issues than expected (I found 4 so far)...

> The 40us is definitely somewhat interesting though I'd be interested to
> know how that compares with PIO too.


Some basic facts ONLY about the SPI transfers themselves:
CS down to last CS up for a message of 5 
71us transfer of the 5 transfer message with PIPO 
16us for DMA.
So that is ONLY measured on the SPI Bus!
The time lost here is between spi_transfers, which is typically between
8-12us.
But also a lot of time is lot of time is lost between the last clock and 
CS up for PIPO: 19us

So the way that the driver is written, its interrupt gets called when it 
is finished with the transfer (or if the FIFO buffer needs to get filled)
and in case of no more data, it will wake up the message pump.
Which is in this case surprisingly fast which schedules the message.

You see where PIPO looses its time?

That is also the reason why i want to move back to the "transmit" interface
and see how much this improves the driver.

Ciao,
	Martin




--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
