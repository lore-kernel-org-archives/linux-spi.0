From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Fri, 8 Nov 2013 20:18:25 +0100
Message-ID: <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
References: <20131106113219.GJ11602@sirena.org.uk> <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org> <20131106162410.GB2674@sirena.org.uk> <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131108180934.GQ2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08.11.2013, at 19:09, Mark Brown wrote:

> On Fri, Nov 08, 2013 at 06:31:37PM +0100, Martin Sperl wrote:
>> On 08.11.2013, at 17:19, Mark Brown wrote:
> 
>>> I'd want to see strong numbers from a real use case showing that the
>>> complexity of trying to do this was worth it.
> 
>> I remember having shared all sorts on values in my earlier posts 
>> regarding to absolute measurements.
>> * from CPU utilization to receive 3000 CAN messages/s
>> * to latency perspective (interrupt to SPI Message)
>> * to time spent "preparing" a message.
> 
> This sounds like an artificial benchmark attempting to saturate the bus
> rather than a real world use case, as does everything else you mention,
> and the contributions of the individual changes aren't broken down so it
> isn't clear what specifically the API change delivers.
> 
As explained - it is a reasonable use-case that you can easily trigger.

For example: updating the firmware of a 128KB Flash via the CAN bus requires
about: 22528 8 byte can packets to transfer just the data and some signaling.
With 3200 CAN-messages/s as the upper limit for these 8 byte messages
this requires 7.04seconds to transfer all the Flash data.

As CAN is a broadcast medium every node on the bus will see this data-rate.
Even if it is NOT involved in the real communication.

So if you are just listening while this happens between 2 other devices,
then you still would be running into a performance bottleneck while the Flash
is getting written.

And if you can not keep up with that rate (packet-loss,...) then you might be 
missing out on other messages that are more important and are directed at you.

OK, there would be gaps every 44 packets while a flash page gets written.
But even then, at that time other devices that are blocked, will send their
messages as the Firmware update is idle. So with more nodes under such a 
situation the bus becomes very likely saturated for 10 seconds.

So it is IMO a realistic load simulation to take the "automatic re-broadcast"
as a repeatable scenario.

> I'd like to see both a practical use case and specific analysis showing
> that changing the API is delivering a benefit as opposed to the parts
> which can be done by improving the implementation of the current API.

I have already shared at some point and also it shows in the forum:
Without prepare I see:
* 14.6k interrupts
* 17.2k context-switches
* 88%CPU-System load

While with prepare I see:
* 29.2k interrupts
* 34.5k context-switches
* 80%CPU-System load

The reason why we see more interrupts is because without the "prepared"
messages we are close to packet loss as 44% of all packets are fetched 
from the second buffer of the CAN controller - if this reaches 50% then 
we start to have packet-loss... So we get 1 Controller interrupt for 2
messages and that triggers some more interrupts for other parts.

While the "prepared" case has only 4% of all packets coming from the
2nd buffer - that is why we have doubled the number of interrupts, as
the number of interrupts from the GPIO device has almost doubled.

How did I measure?

The difference is a different module parameter to the SPI bus driver

Basically looking like this from the code-perspective:
static bool allow_prepared = 1;
module_param(allow_prepared, bool, 0);
MODULE_PARM_DESC(allow_prepared, "Run the driver with spi_prepare_message support");

int bcm2835dma_spi_prepare_message(struct spi_device *spi,
                                struct spi_message *message)
{
        struct bcm2835dma_prepared_message *prep;
        struct bcm2835dma_dma_cb *cb;
        int status=0;
        /* return immediately if we are not supposed to support prepared spi_mes
sages */
        if (!allow_prepared)
                return 0;
...
}

and the above mentioned values have been measured like this:
cat /proc/net/dev; vmstat 10 6; cat /proc/net/dev

Does this answer your question and convince you of this being realistic?

Also my next work is moving to DMA scheduling multiple messages via "transfer".
This should bring down the CPU utilization even further and it should also
decrease the context switches as the spi_pump thread goes out of the picture...
(and that will probably decrease the number of overall interrupts as well...)

How far I can optimize this way is a good question and then we can have a look how
much "penalty" the move to DMA engine will produce. (I have just seen that someone
has just started to post an initial DMA engine for the RPI...)

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
