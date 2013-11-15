From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Fri, 15 Nov 2013 15:52:42 +0100
Message-ID: <0BA2243C-2F22-492A-B517-76E243535549@sperl.org>
References: <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131114015009.GB26614@sirena.org.uk> <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org> <20131115133312.GE26614@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131115133312.GE26614-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 15.11.2013, at 14:33, Mark Brown wrote:
> No, this isn't something which should be being open coded in individual
> drivers - it's far too much redundant work especially once you get into
> doing the tradeoffs for no queue vs queue cases.  Using regmap MMIO may
> be helpful but we need to do that in a way that allows us to integrate
> it into the DMA pipeline...
> 
> This is part of what I keep saying about doing things in a way that
> makes them generally applicable.

Well - we first need to see what is the real "common denominator" of
boards, that can do DMA to configure SPI itself. So we would need at
least 2 or 3 to figure that out (and also all the bugs we may expect to 
see and find work-arrounds for those)

but in principle it should be possible to factor processing out like
this:
* main transfer loop
* while (!transfer_last) {
*   prepareSPIRegisters()
*   prepareAdditionalTXDMA
*   do {
*     append RX/TX transfers
*   } while(do_inner) 
*   append wait_for_clock
*   append delay_us
*   if cs_change
*     append CS_UP
*     append wait_for_clock
* }
* if message->callback
*   append DMAInterrupt_and_position

I believe that might be a generic enough approach that it should work
if one would factor out the "appends" plus the do_inner loop exit 
condition into the master structure.

But my guess is that you would not even allow to get something generic as
this merged unless there are multiple drivers that would be using that
interface.

So we would be in a chicken/egg from this direction as well...

> 
>> Note that if you do that and want to leverage the "prepare_message",
>> then I would recommend you add an additional flag field to these calls.
>> Because then you may pass some hints to the engine (like if it can
>> use GFP_KERNEL or GFP_ATOMIC during allocations). And prepare 
>> could get done with GFP_KERNEL, while a "prepare" during spi_async
>> would need to be done via GFP_ATOMIC.
> 
> Or in the async case we just punt the prepare to the thread.
again: that means an uneccessary delay
especially when you think about running the message_pump without
real-time priority introduces 10us additional delay...

> Yes, this is exactly the sort of thing I'm talking about - it's cutting
> out dead time on the bus.

> Right, and the big concern with the way you're currently proposing to
> implement the optimisation is that it's leaving essentially the whole
> thing up to the individual driver.  This is going to result in limited
> adoption and is going to mean there's no sharing of learning and fixes
> between drivers.

Well, any driver that is using spi_sync can not get improved without a 
rewrite anyway - the context switching becomes prohibitive.

So what some drivers seem to do is create a separate thread, which 
they wake up from their interrupt handler, which then runs the interrupt
handling and uses SPI_sync communication in this thread.
Which means at least 2 context switches one from SPI interrupt (finished)
to wake the message pump, which then will call complete and wake up the 
real thread.

Whatever you do on the framework side you cannot improve the performance
of such drivers without touching the driver itself and converting them
to something else.

It is a whole other story if the driver is already doing async
scheduling of its messages. Then the spi_async thing streamlines the
"next" message to some extent and does not allow the message_pump to
sleep which gives it better response-times.
But you still waste time between the interrupt handler runs and wakes
up the message_pump - especially as the callback is allowed to run from
interrupt context.

As for learning & fixing:
Any driver will go unfixed until someone finds a bug or a performance 
issue and spends time on improving it.

What about writing some "documentation" to show how a driver can get
improved to get higher tru-put? 

And then you can also make the framework do more work for the driver
and thus avoiding replication of code. But then you would again get into 
a need to create a new API for just that covering all those cases.
Maybe by using a code-generator like the samba team did for the smb 
messages.

That is a huge separate project with lots or R&D required, which is 
way outside of the scope of writing a DMA pipelined bus-driver and
proposing things that may improve the performance of optimized drivers.

> To repeat yet again, something that is just a tunnel through to this one
> heavily optimised master driver isn't good.  The problem with the
> proposed implementation is that it is essentially just tunnelling
> through to a heavily optimised master, it's not generic enough.  If
> other devices can make use of it it's more interesting but then those
> uses ought to be being factored out.
Well - as I understand this, it means that:
If there were more bus-drivers that could drive the whole SPI transfer of
a message via DMA, then it would become acceptable to get that API in 
place until then if there is only a single bus and device driver, then it
is not acceptable.

So please define what would be your "critical" mass at which you would 
accept that a API-extension is worth the effort to get integrated?
(Besides metric that shows how much it improves the situation, which also
would need to get defined - we do not want to have performance-regressions
either)

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
