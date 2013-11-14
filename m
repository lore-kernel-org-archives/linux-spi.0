From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Thu, 14 Nov 2013 20:47:35 +0100
Message-ID: <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
References: <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131114015009.GB26614@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131114015009.GB26614-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!
> Meh, it doesn't seem that urgently different to be honest.  The basic
> flow of interactions with the device is very much typical of SPI
> controllers.
> 

Well - if it was not for the requirement to call 
spi_finalize_current_message prior to leaving transfer_one message to get
the next one - I might have continued this route with pipelining.
But hacking my way around those limitations (by taking the next item of the 
list, etc.) seemed a bit absurd to be honest.

> In any case while it's not entirely clearly explained here I *think* the
> major thing that's being done differently here is that the register
> writes to the controller are being done using DMA.  Is that the case?

yes, that is true

> That's certainly a bit of an innovation and I don't think it's actually
> all that device specific - while reusing the same channel for things
> other than the actual data transfer is a bit cute I can't see any
> obvious reason why it shouldn't work and it's something that I'd expect
> a great proportion of DMA controllers would be able to support.  The
> delays are a bit dodgy for that but for untimed delays could probably be
> implemented with dummy memcpy() type transfers easily enough.
> 
> I'd expect this to integrate nicely with the general stuff to split out
> the pushing of transfers and configuration of transfers that I'd been
> kicking around - transfer_one() is intended to be split into two for
> this, one bit to configure the transfer and another bit to actually do
> it.  The original idea was more around recognising and exploiting
> scatter/gather patterns but pipelining the DMAs for configuration would
> allow that to be extended a bit.
> 
> One thing that does concern me is the overhead of all the DMA work for
> smaller transfers - once there's a queue built up it's more clearly
> useful but without a queue it's not obvious that the effort is going to
> be worth it.

Well - if you think this "approach" is also applicable to other devices,
then this is one more argument to allow device drivers to prepare its 
messages (with the is_dma_mapped requirement to keep cost low). 
Note that if you do that and want to leverage the "prepare_message",
then I would recommend you add an additional flag field to these calls.
Because then you may pass some hints to the engine (like if it can
use GFP_KERNEL or GFP_ATOMIC during allocations). And prepare 
could get done with GFP_KERNEL, while a "prepare" during spi_async
would need to be done via GFP_ATOMIC.

>> Well - as said I am wondering if the DMA engine can really can help
>> - especially if you want to keep the "prepare" code fast. I am using
>> dmapool for memory alloc/free, but I fear we would need to run 2 mallocs
>> if I was using DMA-engine and more setup/tear-down overhead, as well
>> as more code that needs to get executed to go via DMA-engine.
> 
> The big win from dmaengine is that it means that you don't need to
> implement essentially the same DMA code in each and every driver, all
> the DMA drivers end up with a uniform API.  Since by and by large the
> process of mapping a SPI message for DMA is the same no matter what the
> controller is this ends up being a win and we don't require each and
> every master driver author to jump through the same hoops.
> If it doesn't do what's desired we should fix it to make it better (same
> as here).
Well the sequencing is the trick for most parts, but I also keep extra 
data adjacent to my real control-blocks to avoid doing double allocations
and keeping data close to each other. For my "usage" I even have a method
where I can put 8 bytes for configs in this structure as well - which
allows me to avoid another set of memory allocations for just that...

In principe it should be possible to generalize that.

My basic "internal" prepare function looks like this:
static struct bcm2835dma_dma_cb *bcm2835dma_add_cb(
	struct bcm2835dma_spi *bs, /* contains dma pool parameters and 
					dma channels */
	struct bcm2835dma_spi_dma *dma, /* a descriptor to the DMA 
					channel */
	struct list_head *list, /* list where to chain the cbs to */
	struct spi_message * msg, /* the message we handle */
	unsigned long info, /* DMA flags for the engine */
	dma_addr_t src, /* the source DMA address, if -1 take from struct*/
	dma_addr_t dst, /* the dest. DMA address, if -1 take from struct*/
	unsigned long length, /* length of dma */
	unsigned long stride, /* stride - not really used as it is buggy*/
	u8 link_to_last /* if we should link this cb to the last on the
				same dma channel*/
);

This will allocate from pool, then fill in the structure
linking it to the last in the chain of the same channel
and return it.

So this might be pretty generic already - and putting dmaengine in there
might be a possibility...
> That's fine for experimentation but for an actual merged API I think it
> does need to be generally applicable so that it's worth the effort for
> client drivers to support it.
First of all it is a bus-driver that should be working.
(also to avoid the expected "short transfer issue" for some use-cases I 
would propose to run it in parallel to the existing version)

Then I believe we can start discussing any approach to refactor things
after we get that far and we see the performance improvements and 
drawbacks for each of those steps.


>> not the prime "candidates" for the improvement in the first place.
>> If they want to run with minimal latencies, they HAVE to run spi_async.
>> Anything else is not very efficient as it requires several context
>> switches by the way of the current design.
> 
> Well, the benefits of submitting things asynchronously are as much about
> giving the stack something to play with and reducing turnaround time as
> anything else - it means the stack can submit the next transfer to the
> hardware before it tells the caller that the current one completed which
> reduces the idle time on the bus and means that there's much more scope
> for reducing needless context switching.  Right now we're not doing as
> good a job of that as we can in most drivers though frankly even the
> current state is an improvement on what we had.

Well, actually if you do it right - like I did in my version of the
mcp2515 driver, I am actually scheduling 2 spi_messages back to back.
and only the first has a callback. 

The first reads the status registers on which to base decisions what
to do and also pulls the interrupt high.

While the second message does a speculative transfer of the 
first inbound message buffer and reads some error counters.

So ideally while the callback of the 1st message is running the 2nd
message is running in HW.

And this callback will schedule acknowledgement of the read rx buffer
as well as schedule the read of the second hw buffer if needed and 
finally reenabling interrupts.
This 3rd message also contains a callback to push the previously read 
HW buffers to the network stack and create error frames if necessary...

So it is in itself geared towards minimizing interrupt "latencies".
If everything works as fast as possible (interrupts,...) the whole
set of messages would look like a giant chain without gaps on the 
SPI bus totally reducing the time from start to finish.

And if everything is done in interrupt context, then one such 
interrupt from the device would trigger 2 additional interrupts 
(one to trigger the 1st and the other to trigger the 3rd message)
and be done with it in a total of 3 interrupts and 0 context switches.

And if you have all the messages "prepared" then the async_spi call
is a cheap thing as well:
*  message->spi=spi;
*  schedule message in dma by just chaining it to a currently running 
     chain.

If I would estimate such an ideal situation, then the whole transfer
including callbacks (maybe except for the last) would be handled in:
* 18us from interrupt to first spi_async end scheduling DMA
* 17us for the first message (1W1R+2W3R+3W)
* 29us for the second message (2W2R+2W/13R+1W1R)
* 25us for the third message (1W+1W/13R+3W)

in total that should be finished in 89us.

Again - the final callback is not included - SPI Bus-speed: 8MHz,
these timings have been taken from actual samples measured and just 
added up.

Also note that this example assumes both Message buffer being full
otherwise you can remove the 1W/13R from the 3rd message and thus 
reduce the time there by 17us.

By comparison the shortest possible CAN message (@500KHz, standard ID
and 0 data bytes) is between 94us and 111us (depending on the ID bit-
pattern)

This is obviously still theoretical and not proven.
But to get to all those gains to work the bus driver has to work DMA
streaming, the API has to implement prepare_message and the 
device-driver needs to be also very "efficient" in its scheduling.

And that is the tricky part - the device driver needs to be designed
to have good scheduling to reduce its latencies.

So if you get that far into the game of optimizing your driver, then
* you will prepare your messages in the init code
* dma mapping the transfers becomes easy, because you can easily 
  allocate the data you need for your transfers from DMA
* and then adding the optional "call" to spi_prepare_message is the
  simplest exercise.

For any driver that is _not_ optimized for latencies and where one 
needs low latency then a rewrite is required.

Also just put the prepare_message api into perspective with other
apis that are rarely used:
extern int spi_bus_lock(struct spi_master *master);
extern int spi_bus_unlock(struct spi_master *master);

There we have 2 users of that interface in the kernel:
drivers/iio/adc/ad_sigma_delta.c
drivers/mmc/host/mmc_spi.c

So we have interfaces for rare uses - why not have another one
that is equally light-weight on the hot path of spi_async?
And which gives a slight benefit to all drivers by avoiding the 
checks every time...
> I'm having a really hard time getting excited about the improvements
> from saving the checks though, they just seem so small for the effort by
> themselves.  You are right, they do exist, but they seem so small in
> relation to the overall transfer time.  That said if a patch were to
> appear which did that and didn't provide any master side hooks I think
> that'd probably be OK.
> 
...
> 
> Sure, there's room for improvement but let's make that as general an
> improvement as possible.  Something that flows better for existing
> drivers is much more of a win there.  I'm getting alarm bells that the
> gains for this one system might be hard to realise on other systems.
> 

Unfortunately 1+us is not that small for a low-end device - it may be small
for a multi-core system, but then you just hide it behind more CPU...
And as said - if you run 10000 spi messages/s that is >10ms of time spent
just doing the API and that is >1% system load on a single core.

I believe I should finish my POC to get fully up to my expectations
and then I can show you the advantage of having this "minimal" change,
which has also an overall positive impact (even though slight).


>> The proposed SPI-test driver is academic to some extent, but it
>> still tries to simulate "real" device traffic with optimal thru-put.
>> Or do you think that reading an ADC as fast as possible is an
>> academic exercise? (the test driver would essentially mimic that and
>> allow for
>> scheduling mechanism to work that allow high thruput (if you
>> configure multiple messages)
> 
> I'm suspicous of benchmarks which limit so that you end up running so
> fast you don't have time to actually do anything with the data, you can
> end up tuning things so that more realistic users suffer (spending too
> much time in interrupt context for example).
Well - maybe we should make this a separate thread...

On my proposed list would be something:
* like the generic version I had talked about
* the mcp2515 CAN-driver that I have described above
* the enc28j60 network driver
* the spi-mmc sd card driver

For all of them we can provide well-defined performance pattern
(READ/Write/s or Packets/s) plus some kind of ADC testing


>> And as said: all the spi_sync methods are candidates to optimization
>> of this - at the cost of some memory used for caching multiple
>> messages.
>> (say having 16 times 1xspi_message+1xspi_transfer structures for
>> transfer length 1 to 16 in spi_write. Similar for spi_read. Or 256
>> 1xspi_message+2xspi_transfer to transfer 1-16 writes and 1-16 reads.
>> plus some memory copy for the reads and writes)
> 
> But then that's a memory plus cache management cost (per master), not to
> mention complexity.

Well, that is something we would need to look into - but it should not be
_that_ complicated and the SPI_master could allocate those via a framework
call or a bit in the spi_master structure - say, if it supports message,
then set it up during registering the device and remove it afterwards...
That is very generic and not a lot more overhead that spi_sync_write/read
does it right now.

But let us first show how far we can go with this first bus-driver that 
does everything in dma and then we can compare results with and without
the "optimize"...

Ciao,
		Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
