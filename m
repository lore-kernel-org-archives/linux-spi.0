From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSP DMA Corruption
Date: Fri, 07 Nov 2008 13:59:29 -0500
Message-ID: <49149011.5040906@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>	<47B0D9A4.6080104@whoi.edu>
	<20081107114312.2f34b389.merrij3@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081107114312.2f34b389.merrij3-IL7dBOYR4Vg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

J. Scott Merritt wrote:
> Long ago, I posted a message on linux-arm-kernel describing data corruption
> that I was seeing on PXA270 SSP transfers using DMA:
> http://marc.info/?l=linux-arm-kernel&m=117780219128682&w=2
> 
> I have recently upgraded to Kernel 2.6.27.4 and am now using the IOCTL
> interface provided by spidev ... and unfortunately am still seeing
> data corruption with DMA transfers.

pxa2xx_spi.c has been pretty well wrung out by various people.  I worked
with Stephen preparing fixes that I think were introduced in 2.6.20.
While my task is receive-only, and it looks like your task is
transmit-only, I did a lot of loopback testing at that time, without the
sort of trouble you report.  Since then Stephen seems to have moved on
to other interests.

> I have a user program that is sending single blocks (1-255 words) of
> fabricated, non-zero data to an outbound processor (at 300 kHz).  I
> find that after a small number of blocks (10-20), the outboard processor
> will receive a packet that begins with multiple zeros, rather than the
> intended data.
> 
> I have put printk statements into spidev that show that the correct,
> non-zero data is always present in the DMA bounce buffer before and
> after the transfer - even on the packets that fail to arrive.

I assume you are still talking about spi_char as the protocol driver.
Right?

You may be having trouble with the way the buffers are allocated.  I
think, but am not sure, that PXA wants the buffers aligned on 32-bit
boundaries.  I note that spi_char statically allocates the buffers in
the middle of the struct spichar_driver.  You might want to allocate the
buffers separately, and change struct spichar_driver to have only
pointers to the separately allocated buffers.  Then....

In my protocol driver, I allocate my buffers with a few more flags:

d_buf = (char *)kzalloc(count, GFP_KERNEL | __GFP_DMA | __GFP_COLD);

I think the important one is probably __GFP_DMA.  I'm not sure how
important that is on PXA, because I think you can DMA from any memory,
but it may enforce needed alignment.  At least alignment checks never
fail when I do this, but perhaps they would not anyway.

Also note that if pxa2xx_spi discovers that the allocated buffers are
not aligned on a 32-bit boundary or if dma_map_single fails, it will
silently perform the transfer in PIO mode.

You can also try doing the dma mapping in the protocol driver, and
passing the mapped address in struct spi_transfer->tx_buf.  David
Brownell pointed out to me once that this is more efficient, because it
allows the kernel to free the cache line associated with the buffer
sooner than if it is left to pxa2xx_spi.  If you do map in the protocol
driver, don't forget to unmap after the transfer is given back from
pxa2xx_spi.

> If I display the DMA flag in the platform data, then the transfers
> continue indefinitely without any problems.  More interestingly, while
> using DMA, if I simply insert a sched_yield (on an otherwise unoccupied
> processor), before each transfer from user land, the problem
> disappears !
> 
> In my original posting last year, I suspected a cache coherency problem.
> However, based on the latest symptoms, I'm wondering if the SSP
> transfer might be initiated before the DMA controller is ready/able
> to provide source data ....

Anything is possible, but I doubt that there is any such problem in
pxa2xx_spi.  Let us know what happens after changing the allocation of
the buffers.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
