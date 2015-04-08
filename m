From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts
 to
Date: Tue, 07 Apr 2015 20:01:43 -0600
Message-ID: <55248C07.8070903@wwwdotorg.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org> <5523FA17.6040009@wwwdotorg.org> <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/07/2015 11:05 AM, Martin Sperl wrote:
> 
>> On 07.04.2015, at 17:39, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> Is the driver simply programming the HW incorrectly then? I would expect the driver to do something roughly like:
>>
>> * Set up the HW to execute the transaction; everything except enabling IRQs and telling the HW to "go"
>> * Clear stale IRQ status (perhaps do this right at the start)
>> * Enable IRQs
>> * Tell the HW to "go"
> 
> no it actually works differently:
> * set TA and some of the other flags (POL,...) in CS-REG, which activates
>   the SPI-block and as soon as there is data it will start the transfer.
>   if you set the IRQ flags here, then IRQ will trigger as soon as the write
>   hits the HW-block, as the fifo is empty
>
> This is what the driver does right in 4.0rcX - it also sets the interrupt
> flags.
> 
> But the problem is that it takes typcially 20us for the ISR to get REALLY
> executed, which means an unecessary delay of 20us before the transfer
> really starts.
> 
> The prefill approach instead:
> * sets TA and some other flags, in CS,but leaves Interrupts disabled
> * fills in FIFO which initiates the transfer
> * sets the same values in CS-REG as above but now also with IRQ enabled

Can you fill the FIFO as step 1? That way, you could presumably write to
that CS-REG just once, with all the desired bits set in one go.

> At this point in time there is a slight chance that CS will toggle for <1us
> when using native CS - this does not happen with gpio-CS for obvious reasons.
> 
> Similar for the situation where you request a transfer of 13 Bytes via DMA.
> You do this by filling in SPI-LEN with 13 to tell the engine to only shift
> 13 bytes out even if DMA fills in 16 bytes.

That sounds pretty typical for a 32-bit/dword-wide FIFO containing 8-bit
data. Surely DMA isn't relevant here; every dword write will put 4 bytes
into the FIFO irrespective of whether the write comes from the CPU or a
DMA engine. Generally, the HW will pull dword-sized values out of the
FIFO, and ignore any extra bytes that are packed into the dword beyond
whatever the programmed transfer length is. Doesn't the bcm283x SPI HW
do that too?

> When this transfer is finished
> then there are still 3 bytes in the FIFO, so you have to clean that by 
> setting CLEAR_TX/CLEAR_RX in the CS-register. 

That sounds pretty unusual. Have you tried not cleaning out the FIFO and
seeing if the next transfer does in fact only transfer the data you
write next, not the extra/stale bytes from the previous transfer?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
