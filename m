From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer for
 data transfer
Date: Fri, 29 Dec 2017 15:46:29 +0530
Message-ID: <08be8b42-732a-bf28-40c4-f46bf9d71c80@ti.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514317385.26695.39.camel@impinj.com>
 <1a7dc424-1ce0-6c64-fc52-bb88ec7db8fa@wedev4u.fr>
 <1514487276.26695.94.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org" <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "richard-/L3Ra7n9ekc@public.gmane.org" <richard-/L3Ra7n9ekc@public.gmane.org>,
        "marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514487276.26695.94.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On Friday 29 December 2017 12:24 AM, Trent Piepho wrote:
> On Thu, 2017-12-28 at 11:39 +0100, Cyrille Pitchen wrote:
>> Le 26/12/2017 à 20:43, Trent Piepho a écrit :
>> > On Sun, 2017-12-24 at 05:36 +0100, Cyrille Pitchen wrote:
>> > > 
>> > > Then the patch adds two hardware capabilities for SPI flash controllers,
>> > > SNOR_HWCAPS_WR_BOUNCE and SNOR_HWCAPS_RD_BOUNCE.
>> > 
>> > Are there any drivers for which a bounce buffer is NOT needed when the
>> > tx/rx buffer is not in DMA safe memory?  Maybe it would make more sense
>> > to invert the sense of these flags, so that they indicate the driver
>> > does not need DMA safe buffers, if that is the uncommon/non-existent
>> > case, so that fewer drivers need to be modified to to be fixed?
>> > 
>> 
>> It doesn't sound safe for a first step. I don't know if some of the
>> spi-flash controllers are embedded inside systems with small memory and
>> don't care about DMA transfers. Maybe they don't plan to use anything else
>> but PIO transfers. Then why taking the risk to exhaust the memory on systems
>> that would not use the bounce buffer anyway?
> 
> This would certainly be the case when the driver does not even support
> DMA in the first place.
> 
> This also makes me wonder, how inefficient does this become when it
> uses a bounce buffer for small transfer that would not use DMA anyway?
>  In the spi_flash_read() interface for spi masters, there is a master
> method spi_flash_can_dma() callback used by the spi core to tell if
> each transfer can be DMAed.
> 
> Should something like that be used here, to ask the master if it would
> use dma on the buffer?
> 
> This might also prevent allocation of the bounce buffer if the only DMA
> unsafe transfers are tiny control ops with stack variables that
> wouldn't use DMA, e.g. the stuff spi_nor_read_sfdp_dma_unsafe() does.
> 
> 
>> About the memory loss when forcing the SNOR_HWCAPS_*_BOUNCE in m25p80.c, I
>> justify it because the m25p80 has to be compliant with the SPI sub-system
>> requirements but currently is not. However I've taken care not to allocate
>> the bounce buffer as long as we use only DMA-safe buffers.
> 
> Another possibility to reduce memory usage: make the buffer smaller
> when first allocated by being just enough for the needed space.  Grow
> it (by powers of two?) until it reaches the max allowed size.  No
> reason to use a 256 kB buffer if DMA unsafe operations never get that
> big.
> 
> 
>> Here at the MTD side, the main (only ?) source of DMA-unsafe buffers is
>> the UBIFS (JFFS2 too ?) layer. Then I've assumed that systems using such a
>> file-system should already have enough system memory.
> 
> I saw a note in one of the existing DMA fixes that JFFS2 was the source
> of the unsafe buffers, so probably there too.
> 
> 
>> 
>> Vignesh has suggested to call virt_addr_valid() instead.
>> I think Boris has also told me about this function.
>> So it might be the right solution. What do you think about their proposal?
> 
> Not sure what exactly the differences are between these methods.  The
> fact that each of the many existing DMA fixes uses slightly different
> code to detect what is unsafe speaks to the difficulty of this problem!

My understanding based on Documentation/DMA-API-HOWTO.txt and
Documentation/arm/memory.txt is that
virt_addr_valid() will guarantee that address is in range of
PAGE_OFFSET to high_memory-1 (Kernel direct-mapped RAM region) which is
address range of buffers that are DMA'able.


>  virt_addr_valid() is already used by spi-ti-qspi.  spi core uses for
> the buffer map helper, but that code path is for buffers which are NOT
> vmalloc or highmem, but are still not virt_addr_valid() for some other
> reason.
> 

	if (vmalloced_buf || kmap_buf) {
		/* Handle vmalloc'd or kmap'd buffers */
		...
        } else if (virt_addr_valid(buf)) {
		/* Handle kmalloc'd and such buffers */
                ...
	} else {
		/* Error if none of the above */
		return -EINVAL;
	}



-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
