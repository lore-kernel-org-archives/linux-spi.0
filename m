From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/16] Blackfin SPI Driver: ensure
	cache coherency before doing DMA
Date: Thu, 20 Nov 2008 13:47:45 -0800
Message-ID: <200811201347.46355.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<200811201224.15493.david-b@pacbell.net>
	<8bd0f97a0811201258j14dfcf46vce1655632bb12e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0811201258j14dfcf46vce1655632bb12e2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thursday 20 November 2008, Mike Frysinger wrote:
> On Thu, Nov 20, 2008 at 15:24, David Brownell wrote:
> > On Monday 17 November 2008, Bryan Wu wrote:
> >>                         /* set transfer mode, and enable SPI */
> >>                         dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
> >>
> >> +                       /* invalidate caches, if needed */
> >> +                       if (bfin_addr_dcachable((unsigned long) drv_data->rx))
> >> +                               invalidate_dcache_range((unsigned long) drv_data->rx,
> >> +                                                       (unsigned long) (drv_data->rx +
> >> +                                                       drv_data->len));
> >
> > Could you explain why you're not using dma_map_*() calls
> > or the rx_dma (and tx_dma) addresses the caller may pass?
> 
> i'm not familiar with said API.  i worked with what was there already.

I see.


> > As a rule, you should use the standard kernel interfaces
> > for such stuff instead of platform-specific calls like
> > those two.  There are a LOT more developers who can find
> > and fix bugs that way.
> 
> could you elaborate on the common calls that would replace these ?

See Documentation/DMA-(mapping,API}.txt ... the "mapping"
document's section on what memory may be used for DMA is
not otherwise replicated in the description of the "generic"
versions of those API calls.

Basically, dma_map_single(), dma_unmap_single() ... and
remember that the caller may have done the mappings for
you already.


> > Also, this patch affects the "not full duplex" branch of
> > this routine.  DMA here seems unusually convoluted ... but
> > if you didn't invalidate the cache (RX path) before
> > flushing it (TX path) and instead did it the other way
> > aroound, would you actually *need* separate branches?
> 
> it's convoluted because the hardware sucks.  it cant do full duplex
> with DMA.  full duplex only works in the non-DMA case.

Ah, ok.  Sucky hardware -- been there, done that, still doing.  ;)

It'd be nice if one of patches snuck in a comment on that
point:  "Full duplex only works for non-DMA transfers."
Same rationale:  you may know this hardware inside out,
but the next person won't.

- Dave



> -mike
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
