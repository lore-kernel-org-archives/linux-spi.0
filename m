From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: [Patch 0/1] spi: Fix pxa2xx_spi.c chip select
	sequence error
Date: Sun, 17 Feb 2008 23:35:29 -0500
Message-ID: <47B90B11.6000601@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	merrij3-IL7dBOYR4Vg@public.gmane.org, Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
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

My next message of this subject contains a patch for the issue 
initially raised by the thread: "PXA270 SSPSFRM gates chip select ?" 

This patch is created to apply to the development kernel: 2.6.25-rc1.
This kernel has a newly re-organized regs-ssp.h file, and since I
needed to add a new bit definition to that file, it is included in the
patch. However, as noted in the comments to the patch, kernels 2.6.20
(when the bug was introduced) through 2.6.24 have the ssp bit
definitions in pxa-regs.h, so the extra bit needs to be added there
for the earlier versions.

David: 

Is there a defined procedure for distributing patches the can be
applied to different kernel versions, when they won't apply directly?

---

Also note that I am still developing on 2.6.20, and so I have only
tested this code on that version.  Furthermore, I don't use chip
select, so really I just compiled and ran the changes to show that
they do no harm.

David:

Can I assume that you or someone up the chain will go through the
motions of applying this patch to 2.6.25 and showing that it compiles?
I really don't expect any trouble with that.

Scott:

Can you apply the patch to your 2.6.21 tree, and see if it fixes your
original problem?  Note that you will have to add the bit definition 
line to include/asm-arm/arch-pxa/pxa-regs.h, by hand, or alter the 
file names in the patch from regs-ssp.h to pxa-regs.h

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
