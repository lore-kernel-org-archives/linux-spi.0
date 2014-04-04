From: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some questions/info
Date: Fri, 4 Apr 2014 16:17:24 +0200
Message-ID: <5AAD4FEA-2887-4A9D-9FE3-588210BFD1A6@martin.sperl.org>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org> <20140402181547.GH2269@sirena.org.uk> <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org> <20140403220232.GE14763@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140403220232.GE14763-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

This is again a long email - trying to answer your questions/concerns.

On 04.04.2014 00:02, Mark Brown wrote:
> There should be some win from this purely from the framework too even
> without drivers doing anything.
> 


If the device-driver does not do anything, then there is no cost involved with
framework (ok - besides an additional if "(!msg->is_optimized) ...")

If the bus driver does not support optimization there is still some win. 

I have shared the "optimization" data already, but here again the overview:

Running a compile of the driver several times (measuring elapsed time)
with different driver/optimize combinations:

driver         optimize real_compile interrupts/s irq2EOT
none                 NA          50s          300     N/A                
spi-bcm2835         off         120s        45000   293us
spi-bcm2835          on         115s        45000   290us 
spi-bcm2835dma      off          76s         6700   172us
spi-bcm2835dma       on          60s         6700    82us

For the "default" driver essentially the CPU cycles available to userspace
went up from 41.6% to 43.5% (=50s/115s). It is not much, but it is still something. This is achived by cutting out "_spi_verify", which is mostly
"_spi_async()" in the current code.

But if you take now the optimize + DMA-driver case: we have 83.3% (=50s/60s)
CPU available for userspace. And without optimize: 65.8% (=50s/76s).
And both of those numbers are big wins!

Note that the first version of the driver did not implement caching for
fragments, but was rebuilding the full DMA-chain on the fly each time, the
available CPU cycles was somewhere in the 45-50% range, so better than the 
stock driver, but not by much. Merging only 5 Fragments is way more efficient
than building 19 dma controlblocks from scratch including the time for 
allocation, filling with data, deallocation,...

As for "generic/existing unoptimized" device-drivers - as mentioned - there is
the idea of providing an auto-optimize option for common spi_read, spi_write, 
spi_write_then_read type cases (by making use of VARY and optimize on some 
driver-prepared messages)

For the framework there might also be the chance to do some optimizations of
its own when "spi_optimize" gets called for a message.
There the framework might want to call the spi_prepare methods only once.
But I do not fully know the use-cases and semantics for prepare inside the
framework - you say it is different from the optimize I vision.

A side-effect of optimize means that ownership of state and queue members is
transferred to the framework/bus_driver and only those fields flagged by vary
may change. There may be some optimizations possible for the framework based
on this "transfer of ownership"...

> That would seem very surprising - I'd really have expected that we'd be
> able to expose enough capability information from the DMA controllers to
> allow fairly generic code; there's several controllers that have to work
> over multiple SoCs.
> 


It is mostly related to knowing the specific registers which you need to set...
How to make it more abstract I have not yet figured it out.

But it might boil down to something like that:
* create Fragment
* add Poke(frag,Data,bus_address(register))
* add Poke ...

As of now I am more explicit yet, which is also due to the fact that I want
to be able to handle a few transfer cases together (write only, read only,
read-write), which require slightly different DMA parameters - and the VARY
interface should allow me to handle all together with minimal setup overhead.

But for this to know you need to "know" the DMA capabilities to make the most
of it - maybe some abstraction is possible there as well...

But it is still complicated by the fact that the driver needs to use 3 DMA 
channels to drive SPI. As mentioned actually 2, but the 3rd is needed to 
stably trigger a completion interrupt without any race conditions, that 
would inhibit the DMA interrupt to really get called (irq-flag might have
been cleared already).

So this is quite specific to the DMA + SPI implementation.

>> P.s: as an afterthought: I actually think that I could implement a DMA driven
>> bit-bang SPI bus driver with up to 8 data-lines using the above dma_fragment 
>> approach - not sure about the effective clock speed that this could run... 
>> But right now it is not worth pursuing that further. 
>> 
> Right, and it does depend on being able to DMA to set GPIOs which is
> challenging in the general case.

"pulling" GPIO up/down - on the BCM2835 it is fairly simple:
to set a GPIO: write to GPIOSET registers with the corresponding bits
 (1<<GPIOPIN) set.
To clear it: write to GPIOCLEAR registers again with the same mask.
So DMA can set all or 0 GPIO pins together.

One can set/clear up to 32 GPIO with a single writel or DMA.

Drawback is that it needs two writes to set an exact value for multiple GPIOs
and under some circumstances you need to be aware of what you do.

This feature is probably due to the "dual" CPU design ARM + VC4/GPU, which
allows to work the GPIO pins from both sides without any concurrency issues
(as long as the ownership of the specific pin is clear).
The concurrency is serialized between ARM, GPU and DMA via the common AXI bus.

Unfortunately the same is NOT possible for changing GPIO directions /
alternate functions (but this is supposed to be rarer, so it can get
arbitrated between components...)

> Broadly.  Like I say the DMA stuff is the biggest alarm bell - if it's
> not playing nicely with dmaengine that'll need to be dealt with.
> 

As for DMA-engine: The driver should (for the moment) also work with minimal
changes also on the foundation kernel - there is a much bigger user base 
there, that use it for LCD displays, CAN controllers, ADCs and more - so it
gets more exposure to different devices than I can access myself.

But still: I believe I must get the basics right first before I can start
addressing DMAengine.

And one of the issues I have with DMA-engine is that you always have to set up
tear down the DMA-transfers (at least the way I understood it) and that is why
I created this generic DMA-fragment interface which can also cache some of
those DMA artifacts and allows chaining them in individual order.

So the idea is to take that to build the DMA-control block chain and then pass
it on to the dma-engine.

Still a lot of things are missing - for example if the DMA is already running
and there is another DMA fragment to execute the driver chains those fragments
together in the hope that the DMA will continue and pick it up.

Here the stats for 53M received CAN messages:
root@raspberrypi:~/spi-bcm2835# cat /sys/class/spi_master/spi0/stats
bcm2835dma_stats_info - 0.1
total spi_messages:     160690872
optimized spi_messages: 160690870
started dma:            53768175
linked to running dma:  106922697
last dma_schedule type: linked
dma interrupts:         107127237
queued messages:        0

As explained, my highly optimized device driver schedules 3 spi_messages.
the first 2 together the 3rd in the complete function of the 1st message.
And the counters for "linked to running dma" is about double the counter
of "started DMA".

The first spi_message will need to get stated normally (as it is typically
idle) while the 2nd and 3rd are typically linked.

If you do the math this is linking happens in 66.54% of all spi_messages.
Under ideal circumstances this value should be 66.666666% (=2/3).

So there are times when the ARM is slightly too slow and typically the 3rd 
message is really scheduled only when the DMA has already stopped.
Running for more than 2 days with 500M CAN-messages did not show any further races (but the scheduling needs to make heavy use of dsb() that this does not
happen....)

This kind of thing is something that DMA-engine does not support as of now.
But prior to getting something like this accepted it first needs a proof
that it works... 

And this is the POC that shows that it is possible and gives huge gains
(at least on some platforms)...

Hope this answers your questions.

Ciao, Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
