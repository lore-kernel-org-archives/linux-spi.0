From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Wed, 8 Apr 2015 09:14:58 +0200
Message-ID: <3C9A0EA9-7394-4793-A717-DF54889F68AD@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org> <5523FA17.6040009@wwwdotorg.org> <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org> <55248C07.8070903@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55248C07.8070903-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 08.04.2015, at 04:01, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> Can you fill the FIFO as step 1? That way, you could presumably write to
> that CS-REG just once, with all the desired bits set in one go.
Actually the "manual" says that you first need to enable TA - even for a
polling driver and then you can fill the FIFO.

But I have also tried it - it does not work, as the TA flag not only 
initiates the transfer but also activates/deactivates the whole SPI block
(and probably also all the registers). So the data filled into the FIFOs
is lost when TA is inactive.

> That sounds pretty typical for a 32-bit/dword-wide FIFO containing 8-bit
> data. Surely DMA isn't relevant here; every dword write will put 4 bytes
> into the FIFO irrespective of whether the write comes from the CPU or a
> DMA engine. Generally, the HW will pull dword-sized values out of the
> FIFO, and ignore any extra bytes that are packed into the dword beyond
> whatever the programmed transfer length is. Doesn't the bcm283x SPI HW
> do that too?
As the HW can do LoSSI (=9 bit) with the corresponding "command" parsing
where some commands trigger 8 bit reads, others 24 and others 32 bit
reads, it seems as if it reads as many byte from the fifo as necessary
for the specific transfer.

> That sounds pretty unusual. Have you tried not cleaning out the FIFO and
> seeing if the next transfer does in fact only transfer the data you
> write next, not the extra/stale bytes from the previous transfer?
I remember having tried this more than a year ago, but then you get the
"missing" data from the last word transfer (when using DMA).

As I am planning on implementing DMA I guess I will get there.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
