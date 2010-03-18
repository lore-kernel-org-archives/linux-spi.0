From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Thu, 18 Mar 2010 19:14:32 -0400
Message-ID: <4BA2B3D8.7000506@whoi.edu>
References: <20100317204915.GB6358@canoga.com>
	<4BA14970.3050603@whoi.edu>	<20100318164641.GA22298@canoga.com>
	<4BA262B1.5050001@whoi.edu>	<20100318200940.GC16834@canoga.com>
	<4BA2A4F4.60207@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4BA2A4F4.60207-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/18/2010 06:11 PM, Ned Forrester wrote:
>
> It could be a lot of places, from bug in your code to bug in the
> controller driver.  I'm not sure how much testing omap2_mcspi.c has
> received.  When I first started using pxa2xx_spi.c, less than a year
> after it appeared in the kernel, I found a variety of bugs.  I then
> spent about 6 months re-writing the driver to handle a high data-rate
> read-only master.  It was much harder for me than I expected.

Oops! On re-reading what I wrote, I see that left some loose ends.

For the bugs that I found, I worked with the original author (Stephen
Street) to develop a patch, which he then submitted and which has long
since been incorporated in the mainline kernel.  I and many others have
fixed other bugs since then.

The major re-write for a high-speed master device (streaming data, the
only device on the bus) have never been submitted as patches.  This is
partly because, while it now works, it is ugly and has never been
cleaned up to be suitable for submission.  The other reason is that,
while it might be useful as a model to others, the major changes greatly
expand the size of the driver, and they would only be useful for single
devices that stream large amounts of data in or out.  This work was done
several years ago, and the driver would now need major renovation to
move it from 2.6.20 to 2.6.35.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
