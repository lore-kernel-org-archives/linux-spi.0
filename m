From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [patch 2.6.28-rc4] spi: pxa2xx_spi.c fix
 DMA	mapping sequence
Date: Sat, 15 Nov 2008 16:21:18 -0500
Message-ID: <491F3D4E.8080502@whoi.edu>
References: <491F3C1A.1030402@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <491F3C1A.1030402-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ned Forrester wrote:
> From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
> 
> Fixes a bug in pxa2xx_spi.c when operating in direct memory access
> (DMA) mode.  The transmit and receive buffers are allowed to be the
> same or to overlap, but pxa2xx_spi.c fails if this is attempted in DMA
> mode because it performs mapping of the rx and tx buffers in the wrong
> order. By mapping DMA_FROM_DEVICE before DMA_TO_DEVICE, it invalidates
> the cache before flushing it.  The patch corrects the order of
> mapping.  This bug exists in all versions of pxa2xx_spi.c

David,

Assuming that you accept this patch, may I attach your Ack: and forward
this to stable along with a version for kernels older than 2.6.27, or
would you prefer to forward this to stable directly and for me to also
post the the older patch to spi-devel-general for your attention?

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
