From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: add support for SPI over
	SuperH SCI pins
Date: Tue, 22 Jan 2008 15:03:11 +0900
Message-ID: <20080122060311.GA5322@linux-sh.org>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<20080122031114.GA2062@linux-sh.org>
	<200801212022.23139.david-b@pacbell.net>
	<200801212126.32727.david-b@pacbell.net>
	<20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<200801211429.29906.david-b@pacbell.net>
	<20080122031114.GA2062@linux-sh.org>
	<200801212022.23139.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200801212126.32727.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
	<200801212022.23139.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Mon, Jan 21, 2008 at 08:22:22PM -0800, David Brownell wrote:
> On Monday 21 January 2008, Paul Mundt wrote:
> 
> > > > +#define spidelay(x) ndelay(x)
> > > > +
> > > > +#define	EXPAND_BITBANG_TXRX
> > > > +#include <linux/spi/spi_bitbang.h>
> > > > +
> > 
> > This is rather unorthodox..
> 
> return -ENOPATCH;)
> 
> I've seen similar idioms used for years.  It's not dissimilar
> to "#ifdef __KERNEL__" except for the code audiences:  two
> different drivers, vs two different address spaces.
> 
> Similar approaches have been used to expand bit manipulation
> algorithms in other contexts ... like some X11 servers I once
> had to cope with.  In fact that was infamous for breaking CPP
> on new platforms; that was before C grew inlines!  But the
> rationale is still the same:  make sure the compiler has every
> opportunity to optimize each variant of those inner loops,
> since they're performance-critical.
> 
> And it works.  I append the code generated on one ARM which
> inlines the bitops ... the inner loop isn't as fast as one
> could code by hand, but if you consider it's four GPIO ops
> then it's not bad.  And it's twice as fast as going through
> a subroutine call for each bitop.  That's easily visible on
> block I/O paths that unfortunately can't use hardware SPI
> on that system.

On Mon, Jan 21, 2008 at 09:26:32PM -0800, David Brownell wrote:
> Minor clarification:  twice as fast for loads involving lots
> of medium-size buffers (1K+).  Down from one minute(!) to put
> new kernels to the only place that they can boot from ... it's
> the usual case where a 5x speedup at one place is very visible,
> but doesn't add up to 5x overall; other issues start to show
> up more (like unchanged per-byte overheads).
> 

The -ENOPATCH thing was intentional, I was more fishing for an
explanation of why this magical sequence existed than lobbying for its
replacement. drivers/spi/ isn't in danger of looking like crypto/ in the
name of code generation just yet, at least. ;-)

Thanks for the clarification.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
