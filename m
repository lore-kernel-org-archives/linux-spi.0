From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI TX andRX buffer overlap
Date: Fri, 14 Nov 2008 15:41:46 -0800
Message-ID: <200811141541.46799.david-b@pacbell.net>
References: <491C87BF.6030905@whoi.edu>
	<200811141430.53146.david-b@pacbell.net>
	<491E033E.9010008@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <491E033E.9010008-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > Typically those DMA calls flush dcache to memory (data written to device)
> > or purge the cache (so entries get read afresh after the data gets read
> > from the device into memory), or both (bidirectional).
> > 
> > As always there's always something to make things complicated, and in
> > this case it's spelled IOMMU.  If one of those is in play, there can be
> > both cache operations *and& IOMMU mapping setup/teardown.  That's not
> > cheap ... but also not a factor on PXA, so far as I know.

Oh, and I forgot:  "automagic bounce buffering".  Bletch.

 
> I think you need to use DMA_BIDIRECTIONAL to make sure that the cache is
> flushed before DMA *and* that the cache is invalidated after the DMA, if
> the DMA will both read and write.  Otherwise only one of those may happen.

If invalidating a cache entry *after* matters, that's a symptom
of a cache line aliasing bug.  Remember, none of those cache lines
should be touched by the CPU after making the I/O request.  And
they would normally have been purged from the cache as part of
setting up the DMA mapping -- why waste scarce cache resources on
data that must not be accessed?

There are also dma_sync_*_for_{cpu,device}() calls that kick in
when you're not unmapping between DMA completion and buffer access.


> I will say, however, that 2 years ago, when testing with loopback of the
> SSP device, I forgot about all this, and "mistakenly" mapped only as
> DMA_FROM_DEVICE, and it worked bidirectionally.  I have no idea why the
> cache appears to have been flushed with that setup, but maybe it has to
> do with some aspect of PXA or the support for it.

Have a look at what ARM does in general.  As I recall, the unmaps
are always NOPs.  (Unless you're kicking in automagic bounce buffering,
in which case the unmap copies from the bounce buffer to the place you
wanted the data stored in the first place.)

 
> I agree that there is no IOMMU on PXA, and it is easy to forget that I'm
> working on something that will never be compiled for another device,
> unless someone uses the code as an example.  I still think bidirectional
> is required in order to be safe.

If you want to make things harder on yourself than necessary, that's
your choice.  :)

 
> >> That said, I would like to know whether I can/should reject the case of
> >> overlapped buffers that do not have the same start address.  As I try to
> >> program for that case, the code is getting ugly.  It would be cleaner to
> >> detect overlapped but unequal buffers and refuse DMA in that case.
> >> Comments?
> > 
> > You shouldn't need to impose arbitrary limitations like that.  In fact,
> > I'm surprised you need to detect the bidirectional case explicitly.
> > Maybe the explanation for that is in some unread email.  :(
> 
> So overlapping, staggered, buffers are acceptable in SPI.  I have
> programmed the full case and I am in the process of testing.
> 
> > Can't you just dma_map_single( ... DMA_TO_DEVICE) first to flush the
> > caches, then dma_map_single( ... DMA_FROM_DEVICE) second to purge any
> > entries -- flushed or not -- that must not remain in the cache?
> 
> That is what I am trying to fix.  The discussion topic is "PXA270 SSP
> DMA Corruption".  It is proven that spidev fails with pxa2xx_spi, and
> that changing the DMA mapping along the lines above fixes it.  I have
> just repeated the test in loopback mode, and mapping the buffer twice,
> once for each direction, and then unmapping twice, fails, not every
> time, but often.

OK, I'll catch up to that thread.  Doesn't seem to me like it
should make a difference if flush-then-invalidate takes one pass
or two...

You're sure the mappings are being done in the right order?

 
> Is calling dma_map_single() twice on the same block of memory supposed
> to be OK?  "Linux Device Drivers" does not discuss this, but it seems
> unlikely that it is acceptable.  Maybe you have to unmap in the reverse
> order of mapping; I will test that.

Mapping any number of times *should* be OK -- unless one mapping
reports an error.  Or you do them in the wrong order (removing
cache entries before writing their data out to memory).

Consider an IOMMU setup, where the mappings get established on a
per-page basis.  But you've got drivers mapping small buffers (say,
512 bytes) that happen to come from the same heap page.  Normally
that page sharing works fine.

But if some IOMMU is braindamaged enough to not support that,
then its driver needs to either recycle mappings or report an
error when trying to share the page.

- Dave


> -- 
> Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
> Oceanographic Systems Lab                                  508-289-2226
> Applied Ocean Physics and Engineering Dept.
> Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
> http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
> http://www.whoi.edu/hpb/Site.do?id=1532
> http://www.whoi.edu/page.do?pid=10079
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
