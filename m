From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi suspend/resume
Date: Wed, 11 Mar 2009 09:53:36 -0400
Message-ID: <49B7C260.40906@whoi.edu>
References: <1236771011.17708.37.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1236771011.17708.37.camel@brutus>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Daniel Ribeiro wrote:
> Hello linux spi experts.
> 
> I'm trying to get suspend/resume working on my pxa27x board, but resume
> freezes waiting for SPI I/O.
> 
> After correcting suspend/resume ordering (i need MCI and UDC to resume
> after SPI, PMIC and USB transceiver on the SPI bus), it still freezes at
> the first SPI transfer.
> 
> I added some debug code to pxa2xx_spi.c as follows:

[snip]

> From my limited knowledge on this, it looks like there is no SSP
> peripheral clock after resume,  SSTO is not decremented after 200us.
> 
> Any pointer on how to fix this? Or other tests i should do?

I did not look your report carefully, but I wonder what kernel you are
using.  A patch for failure to re-enable the clock was merged in
pxa2xx_spi.c on 2008-05-13, which would have been released in kernel
version 2.6.26, I think.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
