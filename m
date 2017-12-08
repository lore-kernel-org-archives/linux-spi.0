From: Radu Nicolae Pirea <radu.pirea@microchip.com>
Subject: Re: [RFC PATCH 2/2] spi: atmel: Fix DMA transfers data corruption
Date: Fri, 8 Dec 2017 15:26:33 +0200
Message-ID: <f3ed96fa-3d4e-6670-18f8-b6425a53e826@microchip.com>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
 <1510763732-10151-3-git-send-email-radu.pirea@microchip.com>
 <20171116104508.rm7xdabyvucowlaj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171116104508.rm7xdabyvucowlaj@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 16.11.2017 12:45, Mark Brown wrote:
> On Wed, Nov 15, 2017 at 06:35:32PM +0200, Radu Pirea wrote:
> 
>> +#ifdef CONFIG_SOC_SAM_V4_V5
>> +	/*
>> +	 * On Atmel SoCs based on ARM9 cores, the data cache follows the VIVT
>> +	 * model, hence the cache aliases issue can occur when buffers are
>> +	 * allocated from DMA-unsafe areas, by vmalloc() for instance, where
>> +	 * cache coherency is not taken into account or at least not handled
>> +	 * completely (cache lines of aliases are not flushed and invalidated).
>> +	 * This is not a theorical issue: it was reproduced when trying to mount
>> +	 * a UBI file-system on a at91sam9g35ek board.
>> +	 */
>> +	flush_kernel_vmap_range((void *)xfer->rx_buf, xfer->len);
>> +#endif
> 
> Shouldn't we be fixing this in the DMA mapping operations for the SoC,
> won't this affect everything that does DMA on this platform and not just
> this driver?  I'd expect that dma_map_sg() and so on would do the right
> thing.
> 

I didn't find a bug like this in other drivers and the only way I can reproduce 
the bug is with UBIFS on top of a spi-nor memory. dma_map_sg() does the right 
thing, but data from cache are not written-back. If I enable 
CONFIG_CPU_DCACHE_WRITETHROUGH bug disappears. Anyway, enabling 
CONFIG_CPU_DCACHE_WRITETHROUGH is not an option because performance will drop.

Fixing the bug in DMA driver is not an option because other DMA operations are 
not affected and the bug comes from the fact that UBIFS allocates memory with 
vmalloc.

Until now I have two solutions for this bug:
1. This one with cache flushing.
2. Another solution, based on ti-qspi driver, is to transfer the data whit a 
bounce buffer allocated with dma_alloc_coherent when rx_buf or tx_buf is 
allocated with vmalloc.

So, witch solution do you think is suitable to solve this bug?
