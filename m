From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/16] Blackfin SPI Driver: ensure
	cache coherency before doing DMA
Date: Thu, 20 Nov 2008 14:05:06 -0800
Message-ID: <200811201405.06811.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<200811201347.46355.david-b@pacbell.net>
	<8bd0f97a0811201357g1ffeb7d3pfad6e178fb20050e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0811201357g1ffeb7d3pfad6e178fb20050e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> On Thu, Nov 20, 2008 at 16:47, David Brownell wrote:

> > Basically, dma_map_single(), dma_unmap_single() ... and
> > remember that the caller may have done the mappings for
> > you already.
> 
> these arent required to provide coherent memory right ?  if that's the
> case, i can take a look at getting things updated.

Right.  If caller provides dma-coherent memory to you, they
must also have provided the DMA addresses the controller
driver should be using ... so you won't need dma mapping
calls on those paths.


> > It'd be nice if one of patches snuck in a comment on that
> > point:  "Full duplex only works for non-DMA transfers."
> > Same rationale:  you may know this hardware inside out,
> > but the next person won't.
> 
> well, hopefully if they dont know they wont be touching the driver ;).
>  i'll add a comment in this code chunk.  thanks for the feedback.

The way it usually works is someone observes a problem and
then starts experimenting on relevant code.  So they learn
a bit while debugging ... and code authors/maintainers need
to keep that learning curve from being too steep.  ;)

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
