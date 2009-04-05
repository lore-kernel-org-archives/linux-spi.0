From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: kernel-panic on pxa2xx_spi.c on pxa9xx cpu
 with	dma enable
Date: Sun, 05 Apr 2009 13:07:03 -0400
Message-ID: <49D8E537.1010307@whoi.edu>
References: <69f617130904042032o382f5084v4fe21884e2356c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Mok Keith <ek9852-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <69f617130904042032o382f5084v4fe21884e2356c77-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Mok Keith wrote:
> Hi all,
> 
> I have encounter a kernel panic, when I saw "pxa2xx-spi pxa2xx-spi.1:
> dma_transfer: fifo overrun".
> After dig into the code from the kernel panic log, I found that
> cur_chip equals to NULL in pump_transfers function.
> 
> It is very easy to duplicated on my system running pxa9xx cpu with dma
> enable (the spi working fine with pure I/O).
> However if some printk is added for debugging, the problem gone.
> 
> So I cannot find out why the tasklet_schedule for pump_transfers is
> called after giveback function is called without the cur_chip is set
> first.
> 
> Anyone has any idea ?

Some.  I have worked on this driver a lot, but it has been awhile, so I
might overlook some things.

First, the panic is probably caused by these declarations in
pump_transfers():

	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
	u32 dma_burst = drv_data->cur_chip->dma_burst_size;

and, of course, uses of "chip" after this assignement:

	chip = drv_data->cur_chip;

These assignments are performed without checking the validity of
cur_chip.  That should be OK in the "standard use" of pxa2xx_spi,
because  pump_transfers() is only supposed to be called between calls to
pump_messages(), where cur_chip is set, and calls to giveback() or
start_queue(), where cur_chip is cleared.

By "standard use", I mean use of the SPI bus with Linux as the master
(the pxa processor is generating the SPI clock), and normal SPI
transfers where every bit received matches a bit transmitted.  In this
mode, it is hard to imagine how there would be FIFO overrun errors in
DMA mode, because the clock will stop when the TX buffer is empty, and
there should be a matching RX buffer that is filled by the DMA hardware,
thus keeping the SSP receiver FIFO from filling.  The only way I can
imagine DMA allowing the receiver FIFO to fill, would be if silly values
of burst and threshold were used, but these are set by the driver, so
they should be OK.

Is your application using the SSP in some unusual way that allows the RX
FIFO to overrun?  I am not familiar with any PXA9xx chips.  What clock
speed are you using.  What timeout setting are you using?  Are you using
power management with suspend/resume?

I have seen FIFO overruns in my application, but I use a heavily
modified version of pxa2xx_spi.c that implements descriptor-fetch DMA,
enables external clocks, and uses read-without-transmit (RWOT) mode, to
collect data from an 11Mbit/sec external master.  Doing these things can
easily overrun the FIFO, but it only happens when I fail to keep filled
the chain of DMA descriptors pointing to empty buffers (and now I have
fixed that, too, so that I can read data continuously, forever).  The
DMA hardware itself never fails to keep up, so I don't see why you would
get overruns in DMA mode.

Are you sure that your transfers are actually operating in DMA mode?
The driver reverts to PIO mode for any transfer that exceeds 8191bytes
in length.  The driver is not yet coded to break long transfers into
shorter segments that are within the length that the DMA hardware can
handle, so it just uses PIO mode for long transfers; this is a known
deficiency that someone might fix in the future.

All that said, in my modified driver, I did change the above
declarations to simple declarations and later checked the validity of
cur_chip before making the assignments.  I don't recall exactly which
circumstance resulted in execution of pump_transfers() without a valid
cur_chip, but it happened with my very non-standard application.  I my
case, I elected to silently return, if cur_chip was not defined, but one
could issue a message, of course.

I would bet that the fundamental cause of your problem is the FIFO
overrun.  With some more information about your setup and use of
pxa2xx_spi, I might be able to provide more clues.  I would hesitate to
simply patch the above assignments without first understanding why
pump_transfers() is being executed out of sequence.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
