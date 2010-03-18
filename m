From: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Thu, 18 Mar 2010 09:46:41 -0700
Message-ID: <20100318164641.GA22298@canoga.com>
References: <20100317204915.GB6358@canoga.com>
 <4BA14970.3050603@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BA14970.3050603-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 17, 2010 at 05:28:16PM -0400, Ned Forrester wrote:

[...]

> If I recall correctly, the work queue does NOT run in interrupt context
> (are allowed to sleep), and therefore mutexs are permitted (for locking
> with other non-interrupt activity).  The interrupt handler definitely
> runs in interrupt context.  If the locking protects data that is shared
> between interrupt context and non-interrupt context, then it will have
> to be done with a spinlock.  pxa2xx_spi.c (the driver I am familiar
> with) does not use any mutexes, because the protected data structure is
> used in the interrupt handlers.
> 

Thanks for the explanation. It fixed a few issues I was having.

Regarding mutexes and spi reads and transfers. Is it possible for
multiple SPI reads to be 'overwriting' each other thus resulting in
wrong reads? Which is why mutexes should be used to lock SPI bus? I
understand there is a patch waiting to be included to the mainline that
has functions to lock the bus before doing a transfer.

e.g. You issue a read and while that read is happening, a second spi
read call from another function uses the bus and thus results in wrong
data being returned to the first read.

> It has been a while since I have dealt with this stuff, so I have said
> something wrong, above, I'm sure I will be quickly corrected.
> 

Thanks again.



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
