From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Fri, 15 Nov 2013 12:15:55 +0100
Message-ID: <5286026B.2090903@sperl.org>
References: <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131114015009.GB26614@sirena.org.uk> <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9640F4C7-7F82-453E-9D83-5875A1559A20-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

I thought a bit about what you had said about DMA and building-blocks,
and I have come up with a possible vision of the "future".

You essentially gave me the idea that we could reduce restrictions
on the proposed spi_prepare_message by adding some flags of in what way
the structure may change. So if you got a "fully" fixed structure,
then we could add "flags" here to indicate if the structure also is
fixed with regards to:
* Length of Transfers
* Change in Pointer to Transfers
* providing DMA data or not (this could get indicated via is_dma_mapped)

Then the bus-driver (or framework) could start to use different
construction schemes to build the DMA chain based on different flag
variations and thus optimizing the time it takes to build the DMA (which
is currently the worsted case in my driver).

This would definitely "improve" the performance of those sync calls
(if we make a prepare in the sync call somehow for the hot-path)

Also the driver can start to use (pre-built/cached) "building-blocks"
that make up a lot of the DMA control blocks that are needed.
(configuring the SPI controller and such)

For more complex drivers we may also defer the DMA-preparation (and
scheduling thereof) of messages to a worker thread which would produce
DMA chains to schedule.

But if the message is prepared it would get scheduled from spi_async
context immediately, unless there is something in the prepare queue,
which then would have to wait so that no reordering occurs.

This comes with a potential "trap": We would need to define if a
"reorder" of SPI messages between two different SPI Bus devices with
different CS is a valid operation or not.
(the question is mostly: would this "queuing" happen on a per bus-driver
basis or on a per CS basis)

The timing sequence would be like this (for scheduling spi_async
messages at the same time):
driver A:
  spi_async(spi0,msg0_unprepared); /* getting put into the "queue" */
driver B:
  spi_async(spi1,msg1_prepared); /* getting scheduled immediately */

On the SPI Bus you would see the following:
  msg1_prepared;
  msg0_unprepared;

Here we have the requirements of a "definition" of scheduling policies.

As far as I can tell (and I may be wrong) the issue described would only
impact if a single device-driver would require two or more different CS
to make a device work properly.

So I would say that "reordering" is essentially allowed if we talk about
two different drivers talking to different devices (or multiple
instances of a single driver talking to distinct devices of the same type).

Note that this could show some strange "concurrency behavior" in some
drivers due to implicit assumptions which are not defined until now and
which would never show up on the current setup.

That is unless you find a board with 2 SPI buses and you connect an
identical device on each SPI Bus. But if one looks at this from this
direction, then such an assumption in the driver would be a bug in the
device-driver that would need to get fixed in the driver itself.

But if a driver exists for a device that requires two (or more) Chip
selects with the additional "requirement" of "proper" ordering, then:

Either the driver needs to make both messages "prepared".
We may need to provide an extra flag to the "prepare" to force "global
ordering" on the SPI-bus.
or we make it a requirement that - in such cases - the spi_lock_bus
interface is used to block the whole bus.

But the first question is: are there any drivers currently that require
multiple CS to do its work?

All of these ideas will also help us in the future and may then may get
used for other bus-drivers as well - we then could even start using a
"DMA-sequencing" engine inside the framework to reduce the code on the
driver (how to define those would be tricky though - we would need to
see how "flexible" other devices are compared to bcm2835).

But first we need to get one working driver with "optimal" performance
that we may confirm it is working in principle and then continue to see
where optimizations can get made and finally refactor this into a
"generic" solution sharing code in the SPI framework and it may
eventually move into dmaengine...

Another thing that came to my mind is a means to give spi_async a hint
if it runs in an interrupt context or not.

This would give the opportunity to allow memory allocations in spi_async
and transfer using GFP_KERNEL instead of GFP_ATOMIC for cases that run
in non_interrupt cases.

We could make this a flag in the spi_message structure or use different
functions: spi_async_threaded and spi_async_interrupt while having the
spi_async map to spi_async_interrupt for compatibility reasons with
older drivers.

Both are valid approaches - I believe it is a matter of taste which one
gets used...

Another thing that you may have mentioned could be a message that would
be like "read(8|16)bitReadXbyte". You first read (1/2) bytes and then
read X bytes that come from the first one or two bytes. The problem here
may be that such a "scheme" would not (not necessarily) work with a
fully DMA pipelined approach - especially endian-nes might be different
(possibly could work around this with 1 byte DMA transfers, if the DMA
engine supports it). But for some HW-devices length might be mixed with
other control-bits, which would require some "and+shift" logic, which
would become impossible to implement in DMA for most DMA-engines (the
mcp2515 would be such a case). The question here is really: how many
such devices do exists that provide such, that would make it worth doing
that in a generic way?

Finally I have a proposal to avoid the "naming" conflict as we have seen
in our discussions so far:

why not call the new interface:
int spi_(pre)build_message(struct spi_device*,struct spi_message,
	unsigned long flags);
int spi_unbuild_message(struct spi_device*,struct spi_message);

with the corresponding equivalent methods in spi_master?

Other naming ideas are welcome (I just would not say DMA, as it might
get used for other things as well)

So I think all the above ideas give us a lot to ponder how/where we may
want to move in the future...

In the meantime I will try to move to the SPI bus-driver to the transfer
interface and I will probably add a module parameter to allow the
selection of which interface is used.

This way we have then many more scenarios to compare to see how they
fare with different situations/use-cases/...

But in the end I would guess that going with the "direct" DMA chaining
approach would give the best results...

Martin

P.s: maybe we should start renaming the subject of this thread?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
