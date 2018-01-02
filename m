From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer for
 data transfer
Date: Tue, 2 Jan 2018 15:30:37 +0530
Message-ID: <b4794d21-817f-b67b-1569-05e1400bdbee@ti.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514317385.26695.39.camel@impinj.com>
 <1a7dc424-1ce0-6c64-fc52-bb88ec7db8fa@wedev4u.fr>
 <1514487276.26695.94.camel@impinj.com>
 <08be8b42-732a-bf28-40c4-f46bf9d71c80@ti.com>
 <1514570627.26695.114.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "radu.pirea@microchip.com" <radu.pirea@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514570627.26695.114.camel@impinj.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On Friday 29 December 2017 11:33 PM, Trent Piepho wrote:
> On Fri, 2017-12-29 at 15:46 +0530, Vignesh R wrote:
>> On Friday 29 December 2017 12:24 AM, Trent Piepho wrote:
>> > 
>> > > Vignesh has suggested to call virt_addr_valid() instead.
>> > > I think Boris has also told me about this function.
>> > > So it might be the right solution. What do you think about their proposal?
>> > 
>> > Not sure what exactly the differences are between these methods.  The
>> > fact that each of the many existing DMA fixes uses slightly different
>> > code to detect what is unsafe speaks to the difficulty of this problem!
>> 
>> My understanding based on Documentation/DMA-API-HOWTO.txt and
>> Documentation/arm/memory.txt is that
>> virt_addr_valid() will guarantee that address is in range of
>> PAGE_OFFSET to high_memory-1 (Kernel direct-mapped RAM region) which is
>> address range of buffers that are DMA'able.
> 
> There's code in gpmi-nand.c that does:
> 
>         /* first try to map the upper buffer directly */
>         if (virt_addr_valid(this->upper_buf) &&
>                 !object_is_on_stack(this->upper_buf)) {
>                 sg_init_one(sgl, this->upper_buf, this->upper_len);
> 
> So whoever wrote that thought that stack objects needed an additional
> test beyond virt_addr_valid.  But it does appear to be far more common
> to depend on just virt_addr_valid, so perhaps the code in gpmi-nand is
> in error.
> 

The test in gpmi-nand.c is right. Enabling CONFIG_DMA_API_DEBUG does
warn about DMA'ing into stack objects (in lib/dma-debug.c). So other
places needs to be fixed, I guess.

>> >  virt_addr_valid() is already used by spi-ti-qspi.  spi core uses for
>> > the buffer map helper, but that code path is for buffers which are NOT
>> > vmalloc or highmem, but are still not virt_addr_valid() for some other
>> > reason.
>> > 
>> 
>>        if (vmalloced_buf || kmap_buf) {
>>                /* Handle vmalloc'd or kmap'd buffers */
>>                ...
> This stuff does get DMAed.  So I have to wonder, if spi.c thinks it can
> use DMA with vmalloc or highmem, couldn't spi-not do the same instead
> of the bounce buffer?

SPI core does try to DMA into underlying physical pages of vmalloc'd
buffer. But this has two problems:

1. Does not work well with VIVT caches[1].
2. On ARM LPAE systems, vmalloc'd buffers can be from highmem region
that are not addressable using 32 bit addresses and is backed by LPAE.
So, a 32 bit DMA cannot access these buffers.

Both these issues lead to random crashes and errors with UBIFS and JFFS2
flash file systems which this patch series tries to address using bounce
buffer

[1] https://patchwork.kernel.org/patch/9579553/


-- 
Regards
Vignesh
