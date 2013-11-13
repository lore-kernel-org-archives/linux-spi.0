From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 16:48:47 +0100
Message-ID: <77070979-0CE4-4C76-B12E-DA94B2577172@sperl.org>
References: <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131113151102.GS878@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113151102.GS878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

> 
> Drivers can supply pre-mapped DMA buffers if they set is_dma_mapped
> which is about as good as you get with dmaengine at the minute.  The
> main opportunities for enhancement here are in the master interface
> rather than the client, at least as things stand.


This is part of my pre-requisite for making it prepareable in my case...

Because otherwise you have (again) to walk the tree to set the rx_dma
via dma_map_single and here the API explicitly states that between the map 
and unmap call the caller may NOT access the pages.

The reason is (probably) for old-ISA devices that may only DMA map 24 bit 
addresses. So the map/unmap actually is supposed to copy data to a bounce 
buffer and back (depending on the direction given).

Typically not an issue on ARM though, I would say...

Hence this becomes expensive to map and then creating the "whole" thing
works just as fine.

Ciao,
	Martin





--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
