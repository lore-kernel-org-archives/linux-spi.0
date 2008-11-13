From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSP DMA Corruption
Date: Wed, 12 Nov 2008 20:59:12 -0500
Message-ID: <491B89F0.7070805@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>	<47B0D9A4.6080104@whoi.edu>	<20081107184819.54baa679.merrij3@rpi.edu>	<491B6249.7070407@whoi.edu>
	<20081112202438.61c28cf4.merrij3@rpi.edu>
	<491B8783.9050800@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <491B8783.9050800-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ned Forrester wrote:
> J. Scott Merritt wrote:
>> On Wed, 12 Nov 2008 18:10:01 -0500
>> Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
>>
>>> 2. spidev uses the same buffer for tx and rx.  That is supposed to be
>>> allowed, but I don't think pxa2xx_spi handles this case correctly.
>>> pxa2xx_spi handles NULL buffers (for uni-directional transfers), and it
>>> uses dma_map_single to map the rx buffers as DMA_FROM_DEVICE, and the tx
>>> buffer as DMA_TO_DEVICE, without checking whether the rx and tx buffers
>>> are the same.  Thus if they are the same, the memory is mapped twice.
>>> "Linux Device Drivers", Corbet, et al. does not address this
>>> possibility, but I bet it is not a good thing to do.
>>>
>>> If you are willing, it looks simple to modify spidev to use two buffers,
>>> and test whether that works better.  I agree that spidev should work
>>> either way, but this would be a quick test.  If that works, I will
>>> submit a patch for pxa2xx_spi to fix the case of same buffers.
>>>
>>> Alternatively, you might prefer to try fixing map_dma_buffers() and
>>> unmap_dma_buffers() in pxa2xx_spi.c to test this theory.  If it works,
>>> that would be the proper fix, anyway.  Basically it needs to trap the
>>> case of same address (or even overlapping ranges) and do one
>>> dma_map_single using the DMA_BIDIRECTIONAL flag.  Unmapping has to use
>>> the same flag.  I think I would choose to make it fail on overlapped but
>>> unequal ranges, and perform correctly for the cases of separate or equal.
>>>
>> [snip performance suggestions]
>>
>> Ned,  Thank for your thorough and thoughtful review.
>>
>> It looks like your concerns regarding the duplicate mapping of the
>> overlapping buffers were correct.  I tried both suggestions - namely,
>> using two buffers in spidev, as well as cutting back to a single buffer
>> mapped with DMA_BIDIRECTIONAL in pxa2xx_spi.c.  Each of these changes
>> (by themselves) seemed to eliminate the data corruption in my simple
>> test program !
> 
> That's good.  I will write a patch for pxa2xx_spi, unless you would
> rather do it.
> 
>> However, I have some lingering concerns regarding the latter solution.
>> >From what little I have read, it appears the DMA-BIDIRECTIONAL is intended
>> for situations where the transfer direction is not know ... it is not
>> immediately clear (to me) that it also handles our case, which might be
>> better described as DMA_SIMULTANEOUS.  It is possible that using
>> DMA_BIDIRECTIONAL is sufficient, but without a much deeper understanding
>> of the buffering and caching that is going on between the two independent
>> DMA channel it is difficult for me to speculate.
> 
> According to "Linux Device Drivers":
> 
> "If data can move in either direction, use DMA_BIDIRECTIONAL."
> 
> and
> 
> "Incidentally, bounce buffers are one reason why it is important to get
> the direction right. DMA_BIDIRECTIONAL bounce buffers are copied both
> before and after the operation, which is often an unnecessary waste of
> CPU cycles."
> 
>>From the general discussion in the book, it is clear that dma mapping
> takes care of issues like flushing cache (for DMA_TO_DEVICE),
> invalidating cache (for DMA_FROM_DEVICE), setting up any I/O memory
> mapping and scatter/gather, etc.  Once stream mapped (which
> dma_map_single() does), the CPU is not allowed to touch the memory, and
> once unmapped, the device cannot touch the memory.  I think it is clear
> that DMA_BIDIRECTIONAL is for exactly the case where the device will do
> some DMA in each direction before giving the memory back to the CPU.

I should have added that the logic of SPI is that for every byte written
DMA tx), there is a byte read (DMA rx).  Because the clocks that read
are generated by the clocks that transmit, the tx word has to be in the
FIFO before the rx word is returned to the FIFO.  Thus the tx and rx DMA
channels will never access the same word at the same time, if the tx and
rx buffers start at the same address.

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
