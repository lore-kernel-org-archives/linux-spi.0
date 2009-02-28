From: Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: Add support for
	non-blocking synchronous	transfers
Date: Sun, 1 Mar 2009 03:42:49 +0530
Message-ID: <20090228221247.GA3107@fedora.yogi>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
	<200902281233.50612.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200902281233.50612.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Feb 28, 2009 at 12:33:50PM -0800, David Brownell wrote:
> Note that $SUBJECT concept is nonsense.
> Synchronous calls are by definition blocking ones...
> 
> 

FWIW, it is exactly this that we want to change.

> On Saturday 28 February 2009, Balaji Rao wrote:
> > During the course of development of an accelerometer driver, we saw the
> > necessity to execute spi transfers synchronously within an interrupt handler.
> 
> This sounds like a bad design.  How can you know that no other
> transfers are going on ... or are queued in front of the transfer
> you're requesting?
> 
> You'd need to wait for all the other transfers to work their
> way through the transfer queue.  There are *much* better things
> to do in interrupt handlers.
> 

Please do look at the patches. We *don't* use a transfer queue.
Transfers requested through our proposed function should/will complete the
transfer when it returns without sleeping in between. (Which is the whole
point of this patch).

> 
> > When using a workqueue instead, we observed a huge number of overruns
> > with very high cpu utlization, which is unacceptable.
> 
> Sure, but at least part of that seems to be caused by some
> broken design assumptions.
> 

No, it's not. Read below.

> Why are you even trying to touch SPI devices from hardirq
> context?  That's never going to be OK; "can't-sleep" contexts
> don't mix with "must-sleep" calls.
> 
> 

Accelerometers can produce a huge amount of data and we need to quickly
read them to avoid overruns. Also, scheduling workers for this greatly
increases the number of context switches, unnecessarily.

> > This series adds a new interface for this and modifies no existing ones.
> 
> NAK on these two patches.
> 

Ok, it will be helpful if you please suggest an alternative keeping in
mind the huge amount of data produced by the accelerometer and the need
to read them quickly ?

Thanks,
Balaji

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
