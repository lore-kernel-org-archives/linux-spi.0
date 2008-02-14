From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: 2006/1/28 patches to pxa2xx-spi in 2.6.25 tree
Date: Thu, 14 Feb 2008 16:45:31 -0500
Message-ID: <47B4B67B.3010601@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
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

I wonder if you have seen the two patches submitted by Eric Miao that 
appeared in the 2.6.25 git tree on 1/26/08 for drivers/spi/pxa2xx-spi.c 
and related files.  They do not appear to have been passed through 
spi-devel-general, which is why I did not see them before. They were 
signed off by Russell King and not by you.  These patches make 
significant changes in way pxa2xx_spi plugs into the kernel, and appear 
to require changes in the platform setup that will likely affect all 
users.  They also make drivers/spi/pxa2xx-spi.c dependent on 
arch/arm/mach-pxa/ssp.c.

Are these changes compatible with the grand scheme of things?  I don't 
have much visibility of the direction in which the kernel or the spi 
core is heading, so I can't tell.

Eric:

It seems there should have been a related patch to 
Documentation/spi/pxa2xx to change the examples for platform setup, 
along the lines of what your patch calls for in 
arch/arm/mach-pxa/lubbock.c, and to add information about struct ssp_device.

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
