From: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some questions/info
Date: Fri, 11 Apr 2014 14:40:07 +0200
Message-ID: <25BB67E3-2929-49D2-BDDE-2D6B3D43534E@martin.sperl.org>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org> <20140402181547.GH2269@sirena.org.uk> <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org> <20140403220232.GE14763@sirena.org.uk> <5AAD4FEA-2887-4A9D-9FE3-588210BFD1A6@martin.sperl.org> <20140410223531.GF6518@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140410223531.GF6518-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11.04.2014 00:35, Mark Brown wrote:
> Right, I was more pointing out that you were underselling here - you were 
> talking only about the benefits when everything is updated. This also means
> we can usefully merge partial support, addressing only some of the 
> improvements is still going to give some wins and makes it easier to digest
> the code overall.
Well - I thought I had shown this with my shared timing-data already... 
(it was just a 5s gain for the PIO driver, but still...)

> The main thing I'd like to do is actually coalesce adjacent transfers within
> a message if they are compatible and we're doing DMA so we end up with fewer
> hardware interactions overall. There's a fairly common pattern of writing
> multiple registers (for firmware download or setting coefficients) where you
> have a small transfer for a register then a larger one for a data block which
> would benefit.

I just found out something similar just a few days ago: 
doing a write then read with 2+1 is more effort to handle than a read/write
of 3 bytes and some moving of data arround. Also it actually saves memory,
as an spi_transfer is bigger than those 3 extra bytes needed.
With the DMA Driver this saved me 4us on overall transfer time -  It dropped
from 52us to 47us. For comparisson: the real data transfer for those 36 
bytes (without 7x CS) takes 35us - so we are pretty close to ideal...

There is not so much of a difference with the PIO drivers as they take 200us
for the same, but it sees a drop on the number of interrupts (typically 
1 IRQ/transfer), which increases CPU availability for userspace...
Redesigning the interrupt-handler to push bytes spanning multiple 
spi_transfers into the fifo together would help, but then it becomes much 
more complex - at least the spi-bcm2835 does call "complete(&bs->done);"
when it has finished the transfer.

I believe I will add all those findings to the documentation with the 
spi_optimize patch...

> Registers where?  If it's in the DMA controller we can just add ops for
> the DMA controller can't we?

Possibly - still working on cleaning up the code and making it as generic
as possible

> Right, that's a peculiarity of your system (hopefully) which makes life
> difficult for that. The Samsung controller has a vaugely similar thing
> where the transmit interrupt goes off too early for what we want so we 
> need to ensure there's always a read if we're doing interrupts but that
> is a lot easier to work around.

Specs says to use 2 Interrupts one for feeding data to FIFO the other to
read data from FIFO. Probably one could use multiple interleaved DMAs for
reads and writes, but then you would be limited to 32 byte transfers and
would have some "gaps" between the fifos filling/emptying - this way at 
least 65535 bytes can get sent with a single transfer...

The interrupt DMA is more on the tricky side - if we had to have an 
interrupt every time an spi_message finished, it would be possible with
2 DMAs, but as we have the possibility of chaining multiple spi_messages
together for higher thruput, then this "waiting" for interrupt is not
possible (IRQ flag gets sometimes cleared by the next DMA controlblock),
so we need to have another "stable" IRQ source and hence DMA3.
(actually I was using the TX DMA for that, which gets started by the
RX-DMA, so we have a race-time between DMA for IRQ and the interrupt
handler on the CPU reading the registers quickly enough to find out the
source of the IRQ)

> That's quite convenient for this sort of use - lots of controllers
> just have a register where you need to set the values of some GPIOs so
> you end up doing a read/modify/write which is obviously hard with DMA.
> We would need gpiolib to export an interface to allow this operation; 
> it should be doable but I expect it's like the regular bulk set and 
> tends to get bogged down.

yes - it is most convenient - but on the other hand it is also a bit of
a pain if you need to do that on the ARM, as you have to do 2 writes for
a single change in gpiolib and ordering could become a problem with 
bitbanged SPI, but it is possible (zero first, set last...

> Sounds like you already have a pretty good prototype?
> 
As said: it mostly works, but i need to cleanup the code before I can
post it, but before I do that I had to finish the CAN driver that makes
use of the features to see what pitfalls we still have.

One of those found is the fact that an optimized message can only reliably
get used with spi_async. For spi_sync use it has to have the complete 
function defined when optimizing, as it would otherwise not implement a
callback IRQ in DMA. And then when spi_sync sets the complete function
the DMA would still issue the optimized message without interrupts.

Also there is one other race-condition, that happens sometimes quickly
sometimes after 48 hours, but I think I might have an idea but for that
I need more info on the event itself...

> Right, that's the biggest thing I can see in what you're suggesting for
> dmaengine and it sounds like something other users could also benefit
> from so I'd not expect massive pushback.
> 
> 
>> This kind of thing is something that DMA-engine does not support as of now.
>> But prior to getting something like this accepted it first needs a proof
>> that it works... 
>> 
> On the other hand you may find that what you've got already is enough
> for people, or get a feel for the sort of things people are looking for
> to show a win.  Sometimes you'll even get "oh, that's a really good idea
> I'll just add the feature" (if you're very lucky).
> 
So who else should I involve as soon as I have presentable code?
(coding standard issues I have already fixed - mostly...)

> BTW I have acquired a RPi for some other use - is the CAN board you are
> using something I can order?  I'm not sure if I'd ever have much time to
> look at it but I'm generally trying to expand the range of SPI hardware
> I have available for test.

Could be as simple as a bread-board + mcp2515 + mcp2551 + 16MHz Oszillator 
+ 4 Resistors + 2-3 Capacitors for the chips...

Other people have bought the pican module, which essentially implements
the same, but is specific to the PI...
http://skpang.co.uk/catalog/pican-canbus-board-for-raspberry-pi-p-1196.html

And in both cases you probably will need a peer which accepts messages or
sends them...

It is a bit tricky - especially the setting up of the correct Baud rate
on the CAN-Bus side - so people are complaining that it is hard to make
it work...

Ciao,
        Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
