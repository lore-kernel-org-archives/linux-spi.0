From: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Subject: Re: PXA270 SSP DMA Corruption
Date: Wed, 12 Nov 2008 20:24:38 -0500
Message-ID: <20081112202438.61c28cf4.merrij3@rpi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<47B0D9A4.6080104@whoi.edu>
	<20081107184819.54baa679.merrij3@rpi.edu>
	<491B6249.7070407@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <491B6249.7070407-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 12 Nov 2008 18:10:01 -0500
Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:

> J. Scott Merritt wrote:
> > Long ago, I posted a message on linux-arm-kernel describing data
> > corruption that I was seeing on PXA270 SSP transfers using DMA:
> > http://marc.info/?l=linux-arm-kernel&m=117780219128682&w=2
> > 
> > I have recently upgraded to Kernel 2.6.27.4 and am now using the IOCTL
> > interface provided by spidev ... and unfortunately am still seeing
> > data corruption with DMA transfers.
> > 
> > I have managed to reproduce the problem using the internal loopback
> > facility of the PXA270 SSP hardware so it should be possible to
> > test this problem in other environments.  On my system, the program
> > below reports an error within 30-50 attempts.  From the data reported,
> > it would appear the the DMA controller (or memory cache) is transferring
> > the contents of the previous buffer rather than the current buffer.
> > 
> > I have also included the platform data that initializes the SSP
> > device drivers.  Perhaps I have misconfigured or misued this in some
> > way ???  Note that simply disabling DMA in the platform data allows
> > the test to run indefinitely without errors.
> 
> [snip code]
> 
> Sorry for the delayed reply.
> 
> I have looked over your code, and tried to familiarize myself with
> spidev.  I cannot easily test your code because I am still using 2.6.20,
> and spidev is was not introduced until 2.6.22.  I don't see any obvious
> problems with either your test code or spidev.  Certainly, spidev is of
> similar complexity to pxa2xx_spi, so I would say that they are similarly
> likely to have issues.  I don't know how much use spidev has gotten, but
> it is probably more than pxa2xx_spi, because it works across platforms.
> 
> There are a couple of things to consider:
> 
> 1. spidev ought to allocate "buffer" using the __GFP_DMA flag.  I think
> you already showed that this is not causing your problem.  I think that
> on ARM, all memory can be used for DMA; that is not true on all
> architectures and some apparently will silently allocate bounce buffers
> for non-dma-accessible memory.
> 
> 2. spidev uses the same buffer for tx and rx.  That is supposed to be
> allowed, but I don't think pxa2xx_spi handles this case correctly.
> pxa2xx_spi handles NULL buffers (for uni-directional transfers), and it
> uses dma_map_single to map the rx buffers as DMA_FROM_DEVICE, and the tx
> buffer as DMA_TO_DEVICE, without checking whether the rx and tx buffers
> are the same.  Thus if they are the same, the memory is mapped twice.
> "Linux Device Drivers", Corbet, et al. does not address this
> possibility, but I bet it is not a good thing to do.
> 
> If you are willing, it looks simple to modify spidev to use two buffers,
> and test whether that works better.  I agree that spidev should work
> either way, but this would be a quick test.  If that works, I will
> submit a patch for pxa2xx_spi to fix the case of same buffers.
> 
> Alternatively, you might prefer to try fixing map_dma_buffers() and
> unmap_dma_buffers() in pxa2xx_spi.c to test this theory.  If it works,
> that would be the proper fix, anyway.  Basically it needs to trap the
> case of same address (or even overlapping ranges) and do one
> dma_map_single using the DMA_BIDIRECTIONAL flag.  Unmapping has to use
> the same flag.  I think I would choose to make it fail on overlapped but
> unequal ranges, and perform correctly for the cases of separate or equal.
> 
[snip performance suggestions]

Ned,  Thank for your thorough and thoughtful review.

It looks like your concerns regarding the duplicate mapping of the
overlapping buffers were correct.  I tried both suggestions - namely,
using two buffers in spidev, as well as cutting back to a single buffer
mapped with DMA_BIDIRECTIONAL in pxa2xx_spi.c.  Each of these changes
(by themselves) seemed to eliminate the data corruption in my simple
test program !

However, I have some lingering concerns regarding the latter solution.
>From what little I have read, it appears the DMA-BIDIRECTIONAL is intended
for situations where the transfer direction is not know ... it is not
immediately clear (to me) that it also handles our case, which might be
better described as DMA_SIMULTANEOUS.  It is possible that using
DMA_BIDIRECTIONAL is sufficient, but without a much deeper understanding
of the buffering and caching that is going on between the two independent
DMA channel it is difficult for me to speculate.

Many thanks, Scott.













-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
