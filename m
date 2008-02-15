From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: 2006/1/28 patches to pxa2xx-spi in 2.6.25
	tree
Date: Thu, 14 Feb 2008 20:09:55 -0500
Message-ID: <47B4E663.7050001@whoi.edu>
References: <47B4B67B.3010601@whoi.edu>
	<E913911567467945BBEB9277E27868B0880975@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: Eric Miao <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E913911567467945BBEB9277E27868B0880975-3TKN+kxLw8+HXkj8w7BxOhL4W9x8LtSr@public.gmane.org>
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

Eric Miao wrote:
> Let me clarify:
> 
> Yes, I apologize I break the potential rules here for two reasons:
> 
> 1. I was not aware of the existence of spi-devel-general mailinglist
> at that time (I know this now :)
> 
> 2. This patch is one of the series of patches refactoring PXA/ARM SSP
> code, and the other patches are tightly PXA/ARM related, and David
> reviewed part of the patch if not all.

I guess change is the price of progress.

> And indeed yes, I will fire another patch correcting the doc, maybe
> after another round of SSP code clean-up.

Thanks.

> Any other concerns/issues about the driver, please make me CC'ed, so
> I'll try fix them if Stephen isn't available.

The only outstanding issue that I am aware of is a minor problem with 
the sequence of setting chip select that was discussed on 
spi-devel-general this week.  Stephen has not chimed in on that issue, 
so I will submit a patch for that myself, either tomorrow or early next 
week.  I will do this patch so that it won't break a heavily modified 
version of pxa2xx_spi.c that I am working on, which deals with chained 
transfers using DMA descriptors (don't expect to ever see it submitted 
for inclusion in the kernel, but I am trying to stay in sync, anyway).

I have examined the patches you submitted, so far, and I think they do 
not interfere with my version.  Someday I will be able to test, but I 
work from the distribution provided with the Gumstix computers, and they 
are currently at 2.6.21 (and I am still at 2.6.20), so it may be a year 
or more before I see 2.6.25.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
