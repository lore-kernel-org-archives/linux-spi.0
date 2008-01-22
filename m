From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: add support for SPI over
	SuperH SCI pins
Date: Mon, 21 Jan 2008 20:22:22 -0800
Message-ID: <200801212022.23139.david-b@pacbell.net>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<200801211429.29906.david-b@pacbell.net>
	<20080122031114.GA2062@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080122031114.GA2062-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
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

On Monday 21 January 2008, Paul Mundt wrote:

> > > +#define spidelay(x) ndelay(x)
> > > +
> > > +#define	EXPAND_BITBANG_TXRX
> > > +#include <linux/spi/spi_bitbang.h>
> > > +
> 
> This is rather unorthodox..

return -ENOPATCH;)

I've seen similar idioms used for years.  It's not dissimilar
to "#ifdef __KERNEL__" except for the code audiences:  two
different drivers, vs two different address spaces.

Similar approaches have been used to expand bit manipulation
algorithms in other contexts ... like some X11 servers I once
had to cope with.  In fact that was infamous for breaking CPP
on new platforms; that was before C grew inlines!  But the
rationale is still the same:  make sure the compiler has every
opportunity to optimize each variant of those inner loops,
since they're performance-critical.

And it works.  I append the code generated on one ARM which
inlines the bitops ... the inner loop isn't as fast as one
could code by hand, but if you consider it's four GPIO ops
then it's not bad.  And it's twice as fast as going through
a subroutine call for each bitop.  That's easily visible on
block I/O paths that unfortunately can't use hardware SPI
on that system.

- Dave


000001cc <XX_spi_txrx_word_mode0>:
 1cc:	e1a0c00d 	mov	ip, sp
 1d0:	e92dd810 	push	{r4, fp, ip, lr, pc}
 1d4:	e24cb004 	sub	fp, ip, #4	; 0x4
 1d8:	e3a04008 	mov	r4, #8	; 0x8
 1dc:	e1a0ec02 	lsl	lr, r2, #24

 1e0:	e35e0000 	cmp	lr, #0	; 0x0
 1e4:	e59f303c 	ldr	r3, [pc, #60]	; 228
 1e8:	e3e01401 	mvn	r1, #16777216	; 0x1000000
 1ec:	a3a00034 	movge	r0, #52	; 0x34
 1f0:	b3a00030 	movlt	r0, #48	; 0x30
 1f4:	e3a0c004 	mov	ip, #4	; 0x4
 1f8:	e3a02002 	mov	r2, #2	; 0x2
 1fc:	e7802003 	str	r2, [r0, r3]
 200:	e501cdcf 	str	ip, [r1, #-3535]
 204:	e5113dc3 	ldr	r3, [r1, #-3523]
 208:	e2442001 	sub	r2, r4, #1	; 0x1
 20c:	e2033001 	and	r3, r3, #1	; 0x1
 210:	e21240ff 	ands	r4, r2, #255	; 0xff
 214:	e501cdcb 	str	ip, [r1, #-3531]
 218:	e183e08e 	orr	lr, r3, lr, lsl #1
 21c:	1affffef 	bne	1e0

 220:	e1a0000e 	mov	r0, lr
 224:	e89da810 	ldm	sp, {r4, fp, sp, pc}

 228:	fefff200 	.word	0xfefff200

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
