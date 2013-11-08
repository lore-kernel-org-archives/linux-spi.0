From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Fri, 8 Nov 2013 18:31:37 +0100
Message-ID: <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
References: <20131106094854.GF11602@sirena.org.uk> <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org> <20131106113219.GJ11602@sirena.org.uk> <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org> <20131106162410.GB2674@sirena.org.uk> <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org> <20131106232605.GC2674@sirena.org.uk> <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131108161957.GP2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

On 08.11.2013, at 17:19, Mark Brown wrote:
> 
> I'd want to see strong numbers from a real use case showing that the
> complexity of trying to do this was worth it.
> 

I remember having shared all sorts on values in my earlier posts 
regarding to absolute measurements.
* from CPU utilization to receive 3000 CAN messages/s
* to latency perspective (interrupt to SPI Message)
* to time spent "preparing" a message.

If you go back to my mail on the 4th November you will find this:

On 04.11.2013, at 18:33, Martin Sperl wrote:
> 
> So here a link of an example showing how much the prepared spi_messages 
> really can improve the SPI thruput - even without changing anything
> (besides) preparing the messages for direct DMA use.
> 
> http://www.raspberrypi.org/phpBB3/viewtopic.php?f=44&t=19489&p=448328#p448328
> The link goes to the RPI forum and includes the measurements plus some images
> showing both cases (configured via a module parameter for now)
> 
> Quick summary:
> For my test-usecase by just enabling "prepared messages" I have reduced the 
> time  for a "simple" transfer from 390us (without prepare) to 230us (with
> prepare) and the driver is still using the threaded message_pump.
> 
> OK - the "default" spi-bcm2835.c driver currently in the mainline takes 245us
> for the same thing, but it runs at 130k interrupts/s and 95% System load, 
> which is quite impractical to do anything else.
> So getting this down to 80% System load plus shorter responses is already
> quite an improvement. 


I included a lot more "hard" data in my previous emails - if you want to 
go back to those...

The above link also includes images images taken with the logic analyzer
comparing prepared and unprepared code-base (by simply enabling/disabling 
prepare). It also does not yet make use of "DMA chaining", for which I
need to move back to the transfer interface to get the most out of DMA...

Is this "strong" enough data for a "real" (worsted) case?

And this 3200 messages/s on the can BUS is not really the worsted case,
as the message is 8 bytes with extended ID at 500KHz.
It is more like the "best" "worsted" case, as such a message would take between
258 and 316us (depending on bit-stuffing).
This translates to 3164 to 3875 CAN-messages per second.

But If I was just using 11 bit IDs and 0 byte data a single message would be 
taking 94 to 111us, which translates to between 9009 and 10638 CAN messages/s.

And then you can double those values again if you go to 1MHz CAN Bus Speed.

Also you can easily "trigger" such a situation, if you:
* have a device that sends a message (and its controller is set to resend the 
  message if there is no recipient, which would be typical)
* have the CAN controller on the RPI configured for "listen only mode"
  (that means it does not acknowledge messages, which is a prerequisite)
* and you connect those two devices together with no other device.

Just start up the "sending" device and you get 80% SYSTEM CPU with the DMA 
driver (95% with the PIPO driver + packet-loss)!

The effect is similar to a packet storm on a network with an older
Network card with a driver that can not switch from "interrupt" to "polling"
mode...

The only difference to normal traffic is that the bus would not be saturated
100% of the time over any measured interval - you would see idle gaps.

Need more evidence? If so please tell me what you would like to see...

Ciao,
	Martin

P.s: and I can not understand why I can read 1000MHz CAN-bus saturated with
0 byte length messages on a simple 8-bit AVR at 16MHz and 4kb memory...
(with the same CAN-controller). And that microcontroller still has the time
to write the whole stream to a SD card (with all the non-deterministic 
latencies that a SD card introduces - but without a filesystem, I have to 
admit, so similar to "dd of=/dev/sdd")

So that is why I am trying to optimize the linux driver as well to get to
"better" performance and still have some cycles left for doing the "real"
work...--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
