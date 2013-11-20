From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Wed, 20 Nov 2013 16:27:06 +0100
Message-ID: <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7@martin.sperl.org>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org> <20131120112920.GX2674@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131120112920.GX2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

OK - I will supply it as 2 patches.

So it is spi_message_optimize - unless you can think of something different.

As mentioned before I will take the opportunity to move the flags into
spi_transfer for optimization hints, because there is where the change 
really happens...

The current bits come to my mind:
#define SPI_OPTIMIZE_FIXED_TX_BUF	(1<<0)
#define SPI_OPTIMIZE_FIXED_TX_DMA	((1<<1)|(1<<0))
#define SPI_OPTIMIZE_FIXED_RX_BUF	(1<<2)
#define SPI_OPTIMIZE_FIXED_RX_DMA	((1<<3)|(1<<2))
#define SPI_OPTIMIZE_FIXED_LEN		(1<<4)
#define SPI_OPTIMIZE_FIXED_DELAY	(1<<5)
#define SPI_OPTIMIZE_FIXED_SPEED	(1<<6)
#define SPI_OPTIMIZE_FIXED_BITS		(1<<7)
#define SPI_OPTIMIZE_FIXED_ALL		(-1)

The flags argument now is of type gfp_t to allow for memory allocation
policies.

> 
> Is this device part of the vanilla board out of interest?
> 
no, unfortunately not, but you can get an extension board for 20$.

>> * kernel 3.10.16 (foundation based, as the vanilla RPI kernel still misses 
>>  dmaengine, so it is easier to develop against this kernel)
> 
> Patches really need to be sent against the latest code for application -
> this is going to collide with the factoring of the validation out of the
> lock that I did too.  Normally that should be 
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> though until the merge window is over that'll need to be topic/core.
> 

I will provide the patches as soon as I have pulled your tree - only
problem is that I can not really compile it on this tree on my RPI...

As you have said: it is a bit complicated with the RPI board+kernel right
now...

I got a separate board for these exercises in the future, but without 
dma-engine or USB/networking it is a bit tough to develop and debug a 
system over the serial line...

> 
> This stuff does more than verify, it also initialises the message with
> defaults - if it were really a verify() then it'd be able to have the
> message passed as a const.
For now I will call it: spi_message_verify_and_prepare.

The issue is that we also need this when optimizing the message - 
otherwise I would have left it where it is...

Also I started to think of how I can optimize the DMA-chain generation
by creating "dma_fragments" that I just need to join together and which are
cached by the bus driver (assuming that we have similar usage all the way,
so that the cached objects are repeatedly used.
This is still work in progress, but it should bring down CPU utilization
from 45% hopefully to the same range as the current interrupt driven driver.

This might then get pushed into the direction of DMA-eninge to become more
generic.

The caches that I can think of right now are:
	dma_fragment_cache_set_cdiv
        dma_fragment_cache_init_transfer
        dma_fragment_cache_transfer_txrx
        dma_fragment_cache_cs_change
        dma_fragment_cache_delay
        dma_fragment_cache_end_of_message
These would match the "fragments" that I can think of.
OK, we could add cdiv into init_transfer, but changing bus-speeds is not 
very common - I would assume, so it would just add a delay...

Each of those unfortunately would require a separate create/free function
to populate the caches. So generalizing this into spi_master would blow up
this structure... But then these cache structures would need to sit 
somewhere anyway, so adding them to the master would need to happen
one way or another... But then maybe there are different ideas for something
like this (but I assume a driver making use of this would be required first)

Ciao,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
