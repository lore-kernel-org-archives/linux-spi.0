From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 09:40:21 +0100
Message-ID: <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org> <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <06C7F4D3-EC91-46CF-90BE-FC24D54F2389-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Maybe one more argument for the spi_prepare_message interface:

For my use-case it takes about: 0.053ms to get from CS disabled+interrupt+interrupthandler+wakeup to the point where I am starting to do the "real work" - in my case preparing dma chains.
And this then takes - depending on the number of transfers and features requested for this message - another 0.026ms to compute the DMA chain.
and then finally another 0.001ms to the point where CS really gets "driven low" by the DMA.

So if we can "optimize" away this "CPU-task" with preparing the messages, then we are faster and there is a definite save on CPU cycles...

Some quick analysis shows that the dma_pool_alloc takes quite a bit of time out of those (now 0.029ms - due to additional CS up/down):
Total time spent  to create the chain of 48 dma-control-blocks is 29us
Time spent in alloc_dma_pool is 9.1us
The same, but also including the "initialization" of the control-block increases to 18.6us

So the setup of DMA is definitely expensive in itself.

But if I compare with SPI-BCM2835 "apples to apples", I get:
for the spi-bcm2835dma.c (from start of DMA calc till final CS) a total time of: 58us.
for the spi-bcm2835.c (from CS down to CS UP) a total time of: 71us.

So there is an advantage to the DMA driver from the bus-efficiency perspective.
And it would be much bigger when we would have the chains "prepared" already - in my example above it should go down to 27us, which is _almost_ optimal from the CPU perspective...

I can share some images from the logic analyzer if required for future reference.

Ciao,
		Martin

P.s: the spi_message presented in the above is of the following format:
* 4 spi_transfers
** 2 bytes write
** 2 bytes read+CS_CHANGE
** 2 bytes write
** 13 bytes read (implicit CS_change because of end of message)

also my test-workload produces the following statistics on vmstat:
on spi-bcm2835: 79000 interrupts/s and 22000 context-switches and 70% System load
on spi-bcm2835dma: 15700 interrupts/s and 20000 context-switches and 75% System load


On 29.10.2013, at 22:18, Martin Sperl wrote:

> Hi!
> 
>> But I hope that you have the necessary infrastructure using the dmaengine
>> subsystem for this, or that changes requires will be proposed to that
>> first or together with these changes.
>> 
>> As you will be using dmaengine (I guess?) maybe a lot of this can
>> actually be handled directly in the core since that code should be
>> pretty generic, or in a separate file like spi-dmaengine-chain.c?
> 
> I have to admit - I have not been using that infrastructure so far - a bit uncertain how to make it work yet - I first wanted the prototype working.
> 
> Also the kernel on the raspberry Pi (on which I do the development) is not fully upstream (I know) and also some parts are not really implemented.
> I know of people who are only using the upstream kernel on a RPI, but there are other limitations there with regards to some drivers. Also there would be a bit of experimentation required to get it in working order - time I do not want to spend momentarily...
> 
> Finally I am also not sure how dmaengine can work when 2 DMAs are required working in parallel (one for RX the other for TX).
> All this means that I have to schedule the RX DMA from the TX-DMA and vice versa - in addition to configuring the SPI registers via DMA and working arround those HW-bugs.
> 
> If the DMA engine would be able to support all of this I have no Idea yet.
> 
> But with all that said, I can do a single SPI_MESSAGE with 5 transfers ,  2 of which have CS_CHANGE only with DMA without any interrupts - besides the final interrupt to trigger the wakeup of the spi_message_pump thread.
> 
> So obviously from there it is not that much more complicated coalescing multiple spi_messages into a single running DMA thread  - it would be just adding the additional transfers to the DMA chain and making sure the DMA is still running after the fact that we have added it.
> 
> The complication then comes mostly in the form of memory management (especially releasing DMA Control blocks), locking,... - which one does not have to take too much care of with the _transfer_one_message interface.
> 
> So to put it into perspective:
> 
> My main goal is to get an efficient CAN driver for the mcp2515 chip which sits on the SPI bus of the RPI.
> I can right now receive about 3200 messages from the CAN Bus per second (close to the absolute maximum for messages with 8 bytes in length - I could more than double the packet count by reducing the packet size to 0 -   with this driver (plus an version of the mcp2515 that uses the async interface and advanced scheduling of messages to "leverage" concurrency - also self written)
> 
> With the "stock" spi-bcm2835 driver that is upstream it uses around 50k interrupts and a similar amount of context switches  and still looses packets.
> With the current incarnation of the spi-bcm2835dma driver (using the transfer_one_message interface) I run at around 16500 interrupts/s and 22000 context switches.
> Still what is biting me the most from the transfer perspective is the fact that there are still too many interrupts and context-switches, which introduces too much latency-unnecessarily.
> 
> So with the spi-bcm2835dma with transfer interface I would estimate that I would get the interrupts down to 6400 interrupts and 0 context switches. All this should also have a positive impact on CPU utilization - no longer 80% System load due to scheduling/dma overhead...
> 
> As for the prepare_spi_message - I was asking for something different than prepare_transfer_hardware (unless there is new code there in 3.12 that already includes that - or it is in a separate tree).
> One would prepare the HW in some way - say waking up a separate thread,...
> While what i would like to see would be similar to prepared statements in SQL - prepare the DMA control blocks once for a message (you may not change the structure/addresses, but you may change the data you are transferring) and then when the message gets submitted via spi_async and then via transfer to the driver, it would then make use of the prepared DMA chain to get attached to the DMA queue. This would shorten the need to calculate those DMA control blocks every time - in my case above I run the same computations 3200 times/s - including dmapool_alloc/dmapool_free/... Obviously it ONLY makes sense for SPI-transfers that have is_dma_mapped=1 - otherwise I would have to go thru the loops of dma_map_single_attrs  every time....
> 
> So this is to fill in the context for my questions regarding why the "transfer" interface is depreciated and to provide a rational for why I would want to use it.
> 
> Ciao,
> 		Martin
> 
> P.s: and for completeness: yes, I can do speed_hz and delay_usecs on a per spi_transfer basis as well in the DMA loop - probably coming closer to the "real" requested delay than the steps interrupt->interrupt-handler->wakeup pump_thread (inside the transfer_one_message handler) -> process the other arguments of xfer that are applied after the transfer-> udelay(xfer->delay_usec) 
> On the RPI something like this takes about 0.1ms from one message to the next to get deliverd - ok, it includes some overhead (like calculating the DMA control-blocks), but still it shows the order of magnitude which you can expect when you have to do wait for the message pump to get scheduled (with realtime priority).
> So a delay_usec=100 would already be in the range of what we would see naturally from the design for a low-power device with a single core - and that would result in waiting way too long. While with DMA I can get the timing correct to +-5% of the requested value (jitter due to other memory transfers that block the memory bus - but this can possibly get )
> 
> I will not mention that I believe that with this SPI-DMA driver it opens up the possibility to read 2 24-ADCs at a rate of 200k with minimal jitter with this simple hardware at 20MHz SPI-bus speed. (some calibration may be required...)
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
