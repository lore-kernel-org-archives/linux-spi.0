From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: Add support for
	non-blocking synchronous transfers
Date: Sat, 28 Feb 2009 12:33:50 -0800
Message-ID: <200902281233.50612.david-b@pacbell.net>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090228081036.31964.80618.stgit-bnrf61MYqdMYW0ZX77RX+A@public.gmane.org>
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

Note that $SUBJECT concept is nonsense.
Synchronous calls are by definition blocking ones...


On Saturday 28 February 2009, Balaji Rao wrote:
> During the course of development of an accelerometer driver, we saw the
> necessity to execute spi transfers synchronously within an interrupt handler.

This sounds like a bad design.  How can you know that no other
transfers are going on ... or are queued in front of the transfer
you're requesting?

You'd need to wait for all the other transfers to work their
way through the transfer queue.  There are *much* better things
to do in interrupt handlers.


> When using a workqueue instead, we observed a huge number of overruns
> with very high cpu utlization, which is unacceptable.

Sure, but at least part of that seems to be caused by some
broken design assumptions.

Why are you even trying to touch SPI devices from hardirq
context?  That's never going to be OK; "can't-sleep" contexts
don't mix with "must-sleep" calls.


> This series adds a new interface for this and modifies no existing ones.

NAK on these two patches.


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
