From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Wed, 17 Mar 2010 17:28:16 -0400
Message-ID: <4BA14970.3050603@whoi.edu>
References: <20100317204915.GB6358@canoga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100317204915.GB6358-QCuvCd35e3/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/17/2010 04:49 PM, Amit Uttamchandani wrote:
> 
> I have modified 'drivers/net/ethoc.c' for spi communication and it is
> able to transmit/receive packets. However, I am confused about using
> spinlocks vs mutexes for locking access to the spi device.
> 
> e.g. For the transmit function I use a work_queue to schedule the
> transmits. In the handler function, I use a mutex to lock the device.
> Could I be using a spinlock here instead? Should I use a spinlock to
> disable the irq while I'm in the middle of transmitting data?
> 
> The ethoc device sends out an interrupt everytime a packet is
> successfully transmitted and received. So it has to be acked otherwise
> the interrupt line stays high and no transmit or receive can happen
> (which why I'm not use if I should use the spin_lock_irq variant in this
> case).
> 
> Some other spi net drivers such as ks8851.c have mutexes around all spi
> device accesses, which I guess is to prevent simultaneous uses of the
> device. Is this a good idea? Doesn't the spi_transfer calls schedule
> device accesses already?

Mutexes allow the process to sleep if the locked resource is held by
another process.  For that reason, they are not permitted in interrupt
context.  You can read all about both types of locking in "Linux Device
Drivers":

http://lwn.net/Kernel/LDD3/

That link is to the third edition. I see the fourth edition may be out.
 I expect that the fundamentals have not changed.

If I recall correctly, the work queue does NOT run in interrupt context
(are allowed to sleep), and therefore mutexs are permitted (for locking
with other non-interrupt activity).  The interrupt handler definitely
runs in interrupt context.  If the locking protects data that is shared
between interrupt context and non-interrupt context, then it will have
to be done with a spinlock.  pxa2xx_spi.c (the driver I am familiar
with) does not use any mutexes, because the protected data structure is
used in the interrupt handlers.

It has been a while since I have dealt with this stuff, so I have said
something wrong, above, I'm sure I will be quickly corrected.

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
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
