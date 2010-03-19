From: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Fri, 19 Mar 2010 02:35:59 -0700
Message-ID: <20100319093559.GA29381@debian>
References: <20100317204915.GB6358@canoga.com> <4BA14970.3050603@whoi.edu>
	<20100318164641.GA22298@canoga.com> <4BA262B1.5050001@whoi.edu>
	<20100318200940.GC16834@canoga.com> <4BA2A4F4.60207@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BA2A4F4.60207-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 18, 2010 at 06:11:00PM -0400, Ned Forrester wrote:

[...]

> 
> I'm not familiar with spi_read and spi_write.  I guess those may be part
> of the user space driver: spidev?  (I wrote a dedicated protocol driver
> for my device.)

Looking at spi.c, spi_read and spi_write both use spi_sync, so both are
blocking.

> 
> It could be a lot of places, from bug in your code to bug in the
> controller driver.  I'm not sure how much testing omap2_mcspi.c has
> received.  When I first started using pxa2xx_spi.c, less than a year
> after it appeared in the kernel, I found a variety of bugs.  I then
> spent about 6 months re-writing the driver to handle a high data-rate
> read-only master.  It was much harder for me than I expected.

You're right. In our case, a lot of the problems where from the FPGA
side of things. We implemented the open cores ethmac controller in our
FPGA. Then wrote a SPI to wishbone protocol communication controller. I
am sure there are bugs in there too.

> 
> > Could I be using SPI with dma to improve speed and maybe have access to
> > more resource in system memory?
> 
> Way too short a question, with way too many unspecified variables.  I
> really can't help you with that, because I know nothing about omap.  DMA
> is useful if you are transmitting/receiving lots of data.  If your
> device requires short exchanges (bytes, not Kbytes or Mbytes) with
> decision making in between, then DMA might not help.  Many of the
> controller drivers have DMA built-in, and it is not hard to enable it,
> but I don't know about omap2_mcspi.c.
> 

I guess I won't be needing DMA as our transfers and quite small. Thanks
for the explanation.

Thank you again for your help.

Amit


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
