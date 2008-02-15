From: "Eric Miao" <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 2006/1/28 patches to pxa2xx-spi in 2.6.25
	tree
Date: Thu, 14 Feb 2008 16:42:56 -0800
Message-ID: <E913911567467945BBEB9277E27868B0880975@msiexch01.marvell.com>
References: <47B4B67B.3010601@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>,
	"David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

Let me clarify:

Yes, I apologize I break the potential rules here for two reasons:

1. I was not aware of the existence of spi-devel-general mailinglist
at that time (I know this now :)

2. This patch is one of the series of patches refactoring PXA/ARM SSP
code, and the other patches are tightly PXA/ARM related, and David
reviewed part of the patch if not all.

And indeed yes, I will fire another patch correcting the doc, maybe
after another round of SSP code clean-up.

Any other concerns/issues about the driver, please make me CC'ed, so
I'll try fix them if Stephen isn't available.

Thanks
- eric

> -----Original Message-----
> From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org]
> Sent: Friday, February 15, 2008 5:46 AM
> To: David Brownell; stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Eric Miao
> Subject: 2006/1/28 patches to pxa2xx-spi in 2.6.25 tree
> 
> David:
> 
> I wonder if you have seen the two patches submitted by Eric Miao that
> appeared in the 2.6.25 git tree on 1/26/08 for drivers/spi/pxa2xx-spi.c
> and related files.  They do not appear to have been passed through
> spi-devel-general, which is why I did not see them before. They were
> signed off by Russell King and not by you.  These patches make
> significant changes in way pxa2xx_spi plugs into the kernel, and appear
> to require changes in the platform setup that will likely affect all
> users.  They also make drivers/spi/pxa2xx-spi.c dependent on
> arch/arm/mach-pxa/ssp.c.
> 
> Are these changes compatible with the grand scheme of things?  I don't
> have much visibility of the direction in which the kernel or the spi
> core is heading, so I can't tell.
> 
> Eric:
> 
> It seems there should have been a related patch to
> Documentation/spi/pxa2xx to change the examples for platform setup,
> along the lines of what your patch calls for in
> arch/arm/mach-pxa/lubbock.c, and to add information about struct ssp_device.
> 
> --
> Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
> Oceanographic Systems Lab                                  508-289-2226
> Applied Ocean Physics and Engineering Dept.
> Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
> http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
> http://www.whoi.edu/hpb/Site.do?id=1532
> http://www.whoi.edu/page.do?pid=10079

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
