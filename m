From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 19:05:01 +0200
Message-ID: <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org> <5523FA17.6040009@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5523FA17.6040009-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 07.04.2015, at 17:39, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> Is the driver simply programming the HW incorrectly then? I would expect the driver to do something roughly like:
> 
> * Set up the HW to execute the transaction; everything except enabling IRQs and telling the HW to "go"
> * Clear stale IRQ status (perhaps do this right at the start)
> * Enable IRQs
> * Tell the HW to "go"

no it actually works differently:
* set TA and some of the other flags (POL,...) in CS-REG, which activates
  the SPI-block and as soon as there is data it will start the transfer.
  if you set the IRQ flags here, then IRQ will trigger as soon as the write
  hits the HW-block, as the fifo is empty

This is what the driver does right in 4.0rcX - it also sets the interrupt
flags.

But the problem is that it takes typcially 20us for the ISR to get REALLY
executed, which means an unecessary delay of 20us before the transfer
really starts.

The prefill approach instead:
* sets TA and some other flags, in CS,but leaves Interrupts disabled
* fills in FIFO which initiates the transfer
* sets the same values in CS-REG as above but now also with IRQ enabled

At this point in time there is a slight chance that CS will toggle for <1us
when using native CS - this does not happen with gpio-CS for obvious reasons.

Similar for the situation where you request a transfer of 13 Bytes via DMA.
You do this by filling in SPI-LEN with 13 to tell the engine to only shift
13 bytes out even if DMA fills in 16 bytes. When this transfer is finished
then there are still 3 bytes in the FIFO, so you have to clean that by 
setting CLEAR_TX/CLEAR_RX in the CS-register. 
If you set only those 2 bit without modifying the others, then there is 
again a chance that native-CS get toggled for a short period of time.

This is obviously not ideal when you have to keep CS low for the next
spi_transfer.

The only way around this was to actually cheat by using only CS2, and
modifying the CSPOL0 and CSPOL1 to do what I want because the CS only
seems to toggle for the "active" CS (as per bits 0:1 in CS).

But that is essentially the same as using cs-gpio, but just uses a
different set of registers.

I guess that there is some sort of logic in the HW that re-evaluates the
state of the native-chip-selects whenever CS-reg is written. Even for the
case where there is no change there seems to be a short period of time
when the CS is not driven (high or low), which, together with some pull-ups,
is pulling those lines high - and this is what we are seeing in some rare
cases.

So any write to the CS-register can influence native chip selects but this
only happens in rare cases typically showing after several hours of
repeated spi-transfers (in my case after 20M CAN messages received and about
100M SPI messages).

Using GPIO-cs solves these situations by not being influenced by the
SPI-hardware in any way in the first place.

Actually - if I think of it - even with the current driver in 4.0rcX
which is configuring CS-reg on every spi_transfer in a spi_message
could trigger the same behavior as well.

But as spi_messages with multiple spi_transfers are rarely used
and as the issue itself is only happening only with a low probability
and some devices not detecting cs changes that are below a certain time
the likleyhood of such a situation being detected are minimal and
would typically get attributed to other factors...

Hope that this answers the question and summarizes the observations
that i have made and why we have to move to gpio-cs for those
optimizations to become active...

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
