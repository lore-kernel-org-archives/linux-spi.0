From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI TX andRX buffer overlap
Date: Fri, 14 Nov 2008 18:01:18 -0500
Message-ID: <491E033E.9010008@whoi.edu>
References: <491C87BF.6030905@whoi.edu>
	<200811141430.53146.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811141430.53146.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> On Thursday 13 November 2008, Ned Forrester wrote:
>> David,
>>
>> In DMA mode, pxa2xx_spi.c fails to detect the case where the tx and rx
>> buffers overlap, and thus it performs dma_map_single incorrectly for
>> that case.  I am working on a patch for that, but I have a question
>> about overlapped buffers.
>>
>> I know that it is legitimate for the tx and rx buffers to be the same;
>> spidev passes identical tx and rx addresses, for example.  I plan to fix
>> pxa2xx_spi so that it handles buffers having the same start address
>> (completely overlapped), in addition to the currently handled case of
>> completely non-overlapped buffers.  For shared buffers, I plan to call
>> dma_map_single() and dma_unmap_single() once for the buffer with a
>> parameter of DMA_BIDIRECTIONAL (let me know if that is not correct).
> 
> That seems OK ... albeit probably overkill.
> 
> Typically those DMA calls flush dcache to memory (data written to device)
> or purge the cache (so entries get read afresh after the data gets read
> from the device into memory), or both (bidirectional).
> 
> As always there's always something to make things complicated, and in
> this case it's spelled IOMMU.  If one of those is in play, there can be
> both cache operations *and& IOMMU mapping setup/teardown.  That's not
> cheap ... but also not a factor on PXA, so far as I know.

I think you need to use DMA_BIDIRECTIONAL to make sure that the cache is
flushed before DMA *and* that the cache is invalidated after the DMA, if
the DMA will both read and write.  Otherwise only one of those may happen.

I will say, however, that 2 years ago, when testing with loopback of the
SSP device, I forgot about all this, and "mistakenly" mapped only as
DMA_FROM_DEVICE, and it worked bidirectionally.  I have no idea why the
cache appears to have been flushed with that setup, but maybe it has to
do with some aspect of PXA or the support for it.

I agree that there is no IOMMU on PXA, and it is easy to forget that I'm
working on something that will never be compiled for another device,
unless someone uses the code as an example.  I still think bidirectional
is required in order to be safe.

>> That said, I would like to know whether I can/should reject the case of
>> overlapped buffers that do not have the same start address.  As I try to
>> program for that case, the code is getting ugly.  It would be cleaner to
>> detect overlapped but unequal buffers and refuse DMA in that case.
>> Comments?
> 
> You shouldn't need to impose arbitrary limitations like that.  In fact,
> I'm surprised you need to detect the bidirectional case explicitly.
> Maybe the explanation for that is in some unread email.  :(

So overlapping, staggered, buffers are acceptable in SPI.  I have
programmed the full case and I am in the process of testing.

> Can't you just dma_map_single( ... DMA_TO_DEVICE) first to flush the
> caches, then dma_map_single( ... DMA_FROM_DEVICE) second to purge any
> entries -- flushed or not -- that must not remain in the cache?

That is what I am trying to fix.  The discussion topic is "PXA270 SSP
DMA Corruption".  It is proven that spidev fails with pxa2xx_spi, and
that changing the DMA mapping along the lines above fixes it.  I have
just repeated the test in loopback mode, and mapping the buffer twice,
once for each direction, and then unmapping twice, fails, not every
time, but often.

Is calling dma_map_single() twice on the same block of memory supposed
to be OK?  "Linux Device Drivers" does not discuss this, but it seems
unlikely that it is acceptable.  Maybe you have to unmap in the reverse
order of mapping; I will test that.

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
