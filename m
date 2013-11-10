From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Sun, 10 Nov 2013 11:54:16 +0100
Message-ID: <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
References: <20131106162410.GB2674@sirena.org.uk> <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131109183056.GU2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

You seem to be very hard to convince!

On 09.11.2013, at 19:30, Mark Brown wrote:
> You mentioned that systems could be constructed but you didn't mention
> examples of doing that; in general prolonged bus saturation tends to be
> something that people avoid when designing systems.
> 

True, but CAN in principle can work saturated when only 2 nodes talk to each 
other and the others are quiet. Collision detection is also in the protocol
and the one "winning" the Collision can continue transmitting its message 
without an abort. And in the Firmware upgrade case the CAN ID is typically 7
configured with the most recessive bits (so highest possible CAN ID), so that
it will loos any arbitration and thus allow other nodes to send their data
with higher priority and thus effectively slowing down the firmware upgrade 
without impacting other devices.

So a saturated bus is not "ideal", but it is possible and would not impact
devices.

Also note that some CAN controllers, like the mcp2515, can have message 
HW-filters configured to limit system load. But these are typically limited
to a certain set of filter-pattern (2 Masks and 2-3 bit pattern per mask), so
for a "central" controller these do not seem to be a good match, as you would
run out of filters, and a central CPU of a vehicle will want to get all data
on which it may base its decision and the limited amount of filters is not
scaling for this.

Also one can estimate from 100% CAN-Bus Utilization with 90% System load.
to 50% Bus utilization and 45% System load
to 25% Bus utilization and 22.5% System load

And even the 22.5% CPU load as already too much in my opinion when you can get
it down further with a simple API extension and a driver optimized for speed.

Note also, that the message-processing overhead is in principle just (mostly)
dependent on the number of messages/interval, while the possible message rate 
on the CAN-bus are primarily dependent on the length of the message.

So with those 2 receive buffers in HW, I have the following time to react
to a two buffers full + avoid an overflow situation:
29-bit IDs and 8 byte/frame at 500khz: 774us to 948 us (depending on 
 data bytes, as there is bit-stuffing happening after 5 identical bits in 
 sequence)
11 bit IDs and 0 bytes/frame at 500kHz: 282us to 333us

These shows the distinct best to worsted case form a bit-length perspective.
So if you got 3 distinct nodes that all want to send the worsted case (single
frame of 0 bytes length , what would be typically called a RTR frame) within 
a window of 188us you can easily trigger the situation of the RPI not being 
able to keep up with the request rate and will drop the packet with the lowest
priority - and that is just 3 distinct packages.

Actually I have a simple case, where a single node sends a sequence of 5
CAN messages of 8 byte size and then stays quiet for 10 seconds (so an effective 
bus utilization of 0.015%) where the "stock" in-kernel drivers (mcp251x and 
spi-bcm2835) are already running into buffer overruns and in 20% of all cases
only report 3 out of those 5 frames. 
(Not to mention that the in tree mcp251x driver stops to work after such a 
situation because of a race confition due to edge-interrupts getting 
"reactivated" too late after the INT line has already gone again.
This happens on a Foundation based kernel somewhere between version 3.2 and 3.6,
with 3.6 showing this behaviour explicitly)


So you see that the "bus saturated" is just a "prolonged" situation of my 5
frame scenario which I can easily reproduce in real-live - and I doubt you 
can say, that this scenario would count as "prolonged bus situation".

> What I'm missing with this example is the benefit of having an API for
> pre-cooked messages, how it will deliver a performance improvement?
> Flashing should be an infrequent operation and I'd expect it to involve
> little reuse of messages which I'd expect to be the main thing that we
> could gain from the API change.  I'd also not expect the controller
> specific work to be especially expensive.

It will deliver a performance improvement by not having to create identical 
structures or running sanity thest every time you transmit the prepared message.
And for the DMA chains I have to create DMA chains that are of a length 10-20 
- depending on the number of transfers.

So just running this piece of code 3000 times/ second minutes or hours is 
overhead that we could definitely safe - IMO it is a low-hanging fruit.

This does not mean that every driver has to implement it necessarily - the first
candidates are the ones that need very high SPI-message thru-put and/or low 
scheduling latencies.

We can even look into optimizing spi_write, spi_read and spi_write_then_read
for the "hot" path by spending a little more memory for "typical" transfer
sizes. Then the "generic" the "generic" drivers would also require less CPU
resources - even if the bus driver does not implement prepare_message itself.
The "sanity" checks in __spi_async would not get executed every time.

I would say any little less CPU utilization helps if it is easy to implement.

>> 
>> Also my next work is moving to DMA scheduling multiple messages via "transfer".
>> This should bring down the CPU utilization even further and it should also
>> decrease the context switches as the spi_pump thread goes out of the picture...
>> (and that will probably decrease the number of overall interrupts as well...)
> 
> Right, and simply driving transfers from interrupt rather than task
> context probably gets an awfully long way there.  This is the sort of
> improvement which will benefit all users of the API - the main reason
> I'm so cautious about changing the API is that I don't want to make it
> more complex to implement this sort of improvement.

Also as an example if you would want the framework to provide "generic" GPIO
interrupt handling to send a (prepared) message without the driver having to 
write the code itself, then on the "registration" call of the message to send
in case of a triggered Interrupt, the framework can also execute this
preparation call in the framework already, so the drivers would not even care
for that!

>>> I'd like to see both a practical use case and specific analysis showing
>>> that changing the API is delivering a benefit as opposed to the parts
>>> which can be done by improving the implementation of the current API.
> 
>> I have already shared at some point and also it shows in the forum:
> 
> You've been doing a bunch of other performance improvements as well,
> it's not clear to me how much of this is coming from the API change and
> how much of this is due to changes which can also be done by improving
> the implementation and without requiring drivers to be specifically
> updated to take advantage of it. 
I have told you, that I have created a module parameter which enables/disables 
the prepare code.

then I ran the loading of the modules, configuring can speeds,...
and ran
vmstat 10 6
then removed the modules.

and then I ran the same again with the parameter to disable prepare.

and we get the different values...

88% System versus 80% system (and the 80% are actually too high, as the system 
got so much faster, that it does not need to handle 2 packets at a time
can handle each packet individually.

Nothing else changed besides this enable/disable parameter.

>> Does this answer your question and convince you of this being realistic?
> 
> It's still not clear to me exactly how this works and hence if the
> benefit comes from the API change itself.
There is no change in API - there is only an optional extension...

If you are not convinced yet, then here a proposal for measurements I can try 
to gather for you to hopefully convince you:
I would implement the previously posted patches to modify the spi_async call to 
allow us to avoid running the "sanity checks" in the __spi_async function.

Here the bus-drivers I would use for testing:
* spi-bcm2708 (from the raspbien kernel using the transfer interface)
* spi-bcm2835 (from the "stock" kernel using the transfer_one_message interface
  with an patch to allow for real time priority in the message pump - enabled 
  via a module parameter).
  * run with and without RT priority
* spi-bcm2835dma with the message_pump interface
  * run with and without RT priority (module parameter as well)
* spi-bcm2835dma with the transfer interface and implementing the message queue
  in DMA itself without any processing

And 2 device-drivers:
* A (hypothetical) ADC read driver, where we want to achieve the highest 
  possible thru-put. I would implement this as "2 messages" that get scheduled
  in sequence.
  both of them having a callback scheduling itself again immediately in the 
  callback call. 
  Why not not work with a single message, you may ask.
  Well, with a single message and a callback scheduling the message again
  the "limiting" factor becomes the processing of the callback and subsequent.
  while with this 2 message approach, when one message is "finished" the other 
  message could get executed while the callback of the first message is running.
  This makes a difference for the pipelined DMA driver as we can leverage
  "the DMA/ARM code concurrency". (not to work effectively in the end it might 
  require more than 2 messages, as there might still be a situation where the
  DMA driver would stall because there is no message in the pipeline.
  Important metrics are:
  * higher means better:
    * spi-message thru-put
  * lower means better:
    * System CPU%
    * interrupts
    * context switches
* maybe also a version of the above that would mimic reading an max187 ADC,
  which requires clock idle after CS down for 8.5us during which it does the
  conversion is run - only then data is valid and clock may start for the
  transfer.
* the optimized mcp2515 driver that I have been writing running in loopback mode
  connected to a 100% saturated CAN-bus@500kHz due to retransmits because of 
  unacknowledged CAN-messages.
  Important metrics are:
  * higher means better:
    * total number of messages processed (there is a top limit)
  * lower means better:
    * ratio of messages processed from second buffer versus first HW buffer
    * number of buffer overruns resulting in packet-loss
    * number of overruns not even detected due to "latencies that miss a 
      second frame"
    * System CPU%
    * interrupts
    * context switches

Both drivers would have a parameter to enable/disable the
spi_prepare_message(spi,message) calls during their initial setup based on
a module parameter.

Would these be good enough scenarios for you to finally convince you if the
numbers are favorable?

Martin

P.s: You know, it would be a LOT of work to get such values!--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
