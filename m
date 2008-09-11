From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
	select gpio to simplify the common cases
Date: Thu, 11 Sep 2008 11:35:43 -0700
Message-ID: <200809111135.44364.david-b@pacbell.net>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<200809102308.31675.david-b@pacbell.net>
	<48C91DFD.5020308@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48C91DFD.5020308-/d+BM93fTQY@public.gmane.org>
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

On Thursday 11 September 2008, Ned Forrester wrote:

> I'm puzzled.  What is there about the pxa2xx_spi.c that would be
> simplified by doing anything with respect to SSPFRM?

The usage model ... callers must understand that option,
evaluate whether it's even usable on their board, and
then have an extra set of possibilities to debug.  And
it's not a model needed with other SPI controllers...

The code ... has to support that more complex model.

Developers ... have to answer questions about that
mechanism when they could be doing more useful things.


> If use of gpio_cs were enforced, an existing 
> application that uses the SSPFRM function of the PXA2xx chip would have
> to be carefully checked for proper use of cs_change (cs_change would
> have been previously ineffective). 

Needing to fix latent bugs is a weak argument.  They'd
need to be fixed when moving to other hardware in any
case.  Note that needing such fixage is another cost
to allowing this mechanism...


> On a related aspect:
> 
> By "broken" cs_change, are you referring to the lack of support for
> SPI_CS_HIGH?

No; spi_transfer.cs_change is what controls whether chipselect
should be deactivated (briefly) between transfers.  It's never
supposed to be deactivated except between messages ... unless
that flag is set.

The brokenness is that when using the SSP frame signal as
chipselect, it's *always* disabled between transfers.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
