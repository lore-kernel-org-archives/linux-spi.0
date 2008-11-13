From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: SPI TX andRX buffer overlap
Date: Thu, 13 Nov 2008 15:02:07 -0500
Message-ID: <491C87BF.6030905@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David,

In DMA mode, pxa2xx_spi.c fails to detect the case where the tx and rx
buffers overlap, and thus it performs dma_map_single incorrectly for
that case.  I am working on a patch for that, but I have a question
about overlapped buffers.

I know that it is legitimate for the tx and rx buffers to be the same;
spidev passes identical tx and rx addresses, for example.  I plan to fix
pxa2xx_spi so that it handles buffers having the same start address
(completely overlapped), in addition to the currently handled case of
completely non-overlapped buffers.  For shared buffers, I plan to call
dma_map_single() and dma_unmap_single() once for the buffer with a
parameter of DMA_BIDIRECTIONAL (let me know if that is not correct).

That said, I would like to know whether I can/should reject the case of
overlapped buffers that do not have the same start address.  As I try to
program for that case, the code is getting ugly.  It would be cleaner to
detect overlapped but unequal buffers and refuse DMA in that case.
Comments?

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
