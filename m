From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c
 chip	select sequence error
Date: Mon, 18 Feb 2008 18:03:53 -0500
Message-ID: <47BA0ED9.5040501@whoi.edu>
References: <47B90B11.6000601@whoi.edu>
	<20080218172128.6fd1522c.merrij3@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080218172128.6fd1522c.merrij3-IL7dBOYR4Vg@public.gmane.org>
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

J. Scott Merritt wrote:
> On Sun, 17 Feb 2008 23:35:29 -0500
> Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> 
>> Scott:
>>
>> Can you apply the patch to your 2.6.21 tree, and see if it fixes your
>> original problem?  Note that you will have to add the bit definition 
>> line to include/asm-arm/arch-pxa/pxa-regs.h, by hand, or alter the 
>> file names in the patch from regs-ssp.h to pxa-regs.h
> 
> 
> I am pleased to report that the supplied Patch DOES indeed appear to
> correct the corruption (translation) that I was seeing in the first
> SPI data transferred after a reboot :)

Thanks for testing.

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
