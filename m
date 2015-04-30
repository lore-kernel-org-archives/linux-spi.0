From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: spi: bcm2835: can_dma and scatter/gather question
Date: Thu, 30 Apr 2015 12:35:04 +0200
Message-ID: <55420558.6030008@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I am trying to implement dma now for the spi-bcm2835 driver
and I have come accross a few implementation details for border
cases that make things "complicated"...

Things are fine and simple as long as transfers-length of an individual
entry in the scatter-gather-list is a multiple of 4 bytes.

Otherwise the bcm2835-SPI-HW requires that we reset(empty) the FIFO
as the DMA is pushing 32 bits with every transfer - even if we are only
interrested in 2 bytes.

If this "reset" is not done then when the HW is enabled the next
time those remaining bit will get shifted out automatically.

On top of that this also means that in case we have multiple entries
in the scatter/gather list we have to have RX and TX scater-gathers
with identical length to make things work propperly.

Here one of those complex examples for 6kb tx and rx, where the
buffers are adjacent to each other and are NOT aligned on 32 bit
boundries.

TX-scatter-gather list:
Page=0 start=0x001 end=0xfff lenfth=0xfff
Page=2 start=0x000 end=0x800 length=0x801
RX-scatter-gather list:
Page=2 start=0x801 end=0xfff length=0x7ff
Page=4 start=0x000 end=0xfff length=0x1000
Page=6 start=0x000 end=0x001 length=0x001

(page is the phyical/dma_address page, [start,end] are (inclusive) offsets
inside the page)

For something like this to work we would need to split it like this:
TX-scatter-gather list:
Page=0 start=0x001 end=0x7ff lenfth=0x7ff
Page=0 start=0x800 end=0xfff lenfth=0x800
Page=2 start=0x000 end=0x7ff length=0x800
Page=2 start=0x800 end=0x800 length=0x001
RX-scatter-gather list:
Page=2 start=0x801 end=0xfff length=0x7ff
Page=4 start=0x000 end=0x7ff length=0x800
Page=4 start=0x800 end=0xfff length=0x800
Page=6 start=0x000 end=0x001 length=0x001

note that this would require a FIFO reset after the first and last 
transfer...

The question is: can the spi-framework fullfill those requirements
as well? Otherwise there would be the need to add an additional
translation step inside the driver to translate those...

Maybe we need to make the use of the mapping code configurable
as well, or should such "custom" things go into prepare_message instead
without implementing can_dma?

One more thing: is there a helper to create a sg_table for
spi_message.is_dma_mapped==1?

Thanks, Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
