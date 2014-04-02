From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some questions/info
Date: Wed, 2 Apr 2014 22:40:41 +0200
Message-ID: <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org> <20140402181547.GH2269@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140402181547.GH2269-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Thanks for the feedback.

Will try to keep emails shorter - I wanted to get everything out in one
and document it also trying to answer questions I thought would come up.

So I will take it that I can continue from where I am right now.

Just to summarize the current "modules" and their respective files:

spi-optimize - essentially the patch shared with my original email touching:
include/linux/spi/spi.h
driver/spi/spi.c

maybe adding some documentation on how to "optimize" high-volume drivers
to make optimal use of the interface.

basic generic dma-fragment support (structures/methods):
include/linux/dma-fragment.h
drivers/dma/dma-fragment.c
(maybe add: Documentation/dma-fragment.txt)

bcm2835 specific fragment support (dumping, scheduling, linking):
include/linux/dma/bcm2835-dma.h
drivers/dma/bcm2835-dma.c

generic spi specific dma-fragment code: 
include/linux/spi/spi-dmafragment.h
drivers/spi/spi-dmafragment.c
mostly about extensions pre/post dma transforms for vary support 
- also handling DMA-mapping, and data for the state-machine used in transformation
from spi-message to dma_fragment)
this could get integrated with spi.h/spi.c if it is deemed sensible

spi-bcm2835dma driver:
include/linux/spi/bcm2835.h (SPI DMA registers and Bits)
drivers/spi/spi-bcm2835dma.h (datastructures and defines)
drivers/spi/spi-bcm2835dma_drv.c (driver itself)
drivers/spi/spi-bcm2835dma_frag.c (the code filling/creating the fragments)

Does this look "ok" from an approach perspective?

I will share one module after the other for initial review.

I will brush up the code for the generic DMA fragment code, so that it
becomes presentable and will share that part in the hope that it live in
parallel to dmaengine and/or get somehow integrated - possibly as another target
besides cyclic.

It is really mostly management of those dma blocks so that they can get
joined together easily as well as the management of a group of those blocks.

Also it is designed to be generic that is why there is the bcm2835 specific code
as well as a separate module.

As such drivers using this specific interface will need to know enough about
the HW itself, my assumption is that the driver will need to know about the DMA
engine used to work properly - so I left all sorts of abstractions out of the 
design - this can get added later if needed...
Anyway this should come with deeper integration with dma-engine.

With regards to VARY: I have used the "options" provided to cover most of the
bases that I thought I would need to "auto-optimize" those simple cases of
spi_read, spi_write, spi_write_then_read. The VARY_DELAY_USEC was just added as
an after-thought, as it is not so "complex" to enable this as a feature...

As for the measurements on effective CPU utilization shared originally - is the
data shared understood/convincing? Does it need more explanation?

Ciao, Martin

P.s: as an afterthought: I actually think that I could implement a DMA driven
bit-bang SPI bus driver with up to 8 data-lines using the above dma_fragment 
approach - not sure about the effective clock speed that this could run... 
But right now it is not worth pursuing that further. --
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
