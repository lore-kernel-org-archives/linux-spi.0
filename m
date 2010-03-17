From: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Spinlock vs mutexes for spi network driver
Date: Wed, 17 Mar 2010 13:49:15 -0700
Message-ID: <20100317204915.GB6358@canoga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


I have modified 'drivers/net/ethoc.c' for spi communication and it is
able to transmit/receive packets. However, I am confused about using
spinlocks vs mutexes for locking access to the spi device.

e.g. For the transmit function I use a work_queue to schedule the
transmits. In the handler function, I use a mutex to lock the device.
Could I be using a spinlock here instead? Should I use a spinlock to
disable the irq while I'm in the middle of transmitting data?

The ethoc device sends out an interrupt everytime a packet is
successfully transmitted and received. So it has to be acked otherwise
the interrupt line stays high and no transmit or receive can happen
(which why I'm not use if I should use the spin_lock_irq variant in this
case).

Some other spi net drivers such as ks8851.c have mutexes around all spi
device accesses, which I guess is to prevent simultaneous uses of the
device. Is this a good idea? Doesn't the spi_transfer calls schedule
device accesses already?

Thanks for any comment on this.

Amit

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
