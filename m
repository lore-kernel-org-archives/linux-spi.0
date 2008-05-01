From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
	Microelectronics lis3l02dq accelerometer via SPI
Date: Thu, 1 May 2008 11:48:25 -0700
Message-ID: <200805011148.26077.david-b@pacbell.net>
References: <481210CC.9080702@cam.ac.uk>
	<200804301804.24924.david-b@pacbell.net>
	<4819FD27.7070600@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4819FD27.7070600-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

By the way, your last patch seems to have badly mangled by
some mail software:  I see no tabs anywhere... could you
resend?


On Thursday 01 May 2008, Jonathan Cameron wrote:

> >> +struct LIS3L02DQ_state {
> >> +	struct spi_device*     us;
> >> +	unsigned char          tx_buff[2*6];
> >> +	unsigned char          rx_buff[2*6];
> >>     
> >
> > I know I've been guilty of that idiom in the past, but
> > it's best to avoid it.  Instead of allocating DMA
> > buffers like that, just kmalloc() them separately.
> >
> > (If you were using a pure PIO driver it wouldn't matter.
> > But with DMA, on systems without cache-coherent main
> > memory -- e.g. on most non-x86 systems! -- this can make
> > for data corruption problems.)
> >   
> I'm afraid I don't fully understand this (not having much familiarity 
> with dma), is this fixed by the patch? (which will follow - basically
> allocates tx_buff and rx_buff dynamically)

It should be fixed, yes.  The issue is "cache line sharing".

The buffers shown above share cache lines with data that the
Linux driver may be using during the DMA.  So while the DMA
mapping calls invalidate/flush those lines before DMA starts,
the CPU could reload them shortly afterwards.

Imagine the DMA writes that rx_buff with some data.  Question:
when the CPU reads that rx_buf, what value will it get?  Probably
the value in the cache.  Maybe that value gets written back and
clobbers the "right" rx_buf data.  Or maybe that cacheline
never gets dirtied, and is discarded, so the "right" rx_buf
values come back.  You can't really know ...

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
