From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
 delay, cs change, transfer length
Date: Thu, 04 Sep 2008 10:08:55 -0400
Message-ID: <48BFEBF7.1080902@whoi.edu>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David:

I think enough time has elapsed for any objections to surface.  Is there
still time to push this patch for 2.6.27?  The actual patch is contained
in my email of 8/19/08:

[spi-devel-general] [Patch 1/1] spi: Fix pxa2xx_spi.c transfer delay, cs
change, transfer length

Also, the patch should be directed at the stable maintainers for
addition to any kernel as far back as 2.6.20. I'm not sure how to do
direct that, but I expect that you do.

Thanks.

> My next message of this subject contains a patch for many of the issues
> raised by the threads:
> 
> [PATCH] atmel_spi: support zero length transfer, 2/22/08
> [PATCH] pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode,
> 8/18/08
> pxa2xx_spi with SFRM, 8/7/08
> 
> This patch is created to apply to the development kernel: 2.6.27-rc3.
> 
> David:
> 
> This patch is preliminary.  I have compiled it on 2.6.20, but it
> awaits testing by the folks reporting problems; I don't have any
> hardware to test it on.  Hopefully it is clean.  Your general comments
> will be appreciated, particularly on the revised handling of
> transfers over 8191 bytes long (or on my related post to you:
> 
> Limitations on transfer length [was: pxa2xx_spi	with SFRM], 8/15/08

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
