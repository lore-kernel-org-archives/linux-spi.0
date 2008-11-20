From: "Massion, Gene" <magene-5892unH0nlnYtjvyW6yDsg@public.gmane.org>
Subject: Re: SPI or CSPI transfers using DMA
Date: Thu, 20 Nov 2008 15:46:26 -0800
Message-ID: <1FCC04E38B4F6C4094B67127333F86607CCC46@frost.shore.mbari.org>
References: <10811398.477881225431989704.JavaMail.nabble@isper.nabble.com>
	<200811201339.28627.david-b@pacbell.net> <4925ED9B.305@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>,
	"David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4925ED9B.305-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David & Ned

I did get Ned's earlier e-mail.  It was of some help although at this time we are looking at upgrading to a board with USB2.0 so we can write to disk faster.  We are currently evaluating an iMX31 board from Logic Product Development.

I'm a little hesitant to admit it but I'm working in Windows CE.  This is kind of an experiment since all the software types at MBARI are committed Linux followers.  Since I'm not really a software guy, no one really cares what I do.  It turns out that Freescale has developed a WinCE driver for the iMX31 that uses DMA as the default.  I'll be looking at how hard it is to include that driver in the LogicPD BSP in the near future.  

Thanks for your input and if you're interested, let me know and I'll let you know how my WinCE experiment turns out.

Cheers

Gene Massion
Monterey Bay Aquarium Research Institute
7700 Sandholdt Road
Moss Landing, California 95039
831 7751922 (tel)
831 7751646 (fax) 

-----Original Message-----
From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org] 
Sent: Thursday, November 20, 2008 3:07 PM
To: David Brownell
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Massion, Gene
Subject: Re: [spi-devel-general] SPI or CSPI transfers using DMA

David Brownell wrote:
> On Thursday 30 October 2008, magene-5892unH0nlnYtjvyW6yDsg@public.gmane.org wrote:
>> I've been developing an application on an Eurotech (formerly
>> Applied Data Systems) Bitsy Xb PXA270 board
>> I'd like to use DMA put the DMA engine on the PXA270 has 
>> a pretty steep learning curve.  Does anyone have a code example
>> that could help jumpstart me? 
> 
> Our resident expert from Woods Hole has a similar data
> streaming application, using PXA and DMA.  Maybe he can
> share a few words of wisdom ...         

I already did, on 10/31/08.  I have not heard back.  While I referenced
pxa2xx_spi.c as a useful example of setting up DMA, Gene should note
that we recently discovered that the RX and TX DMA memory mappings are
performed in the wrong order in that code.

Interesting... I did not note before that Gene is at MBARI, one of our
sister oceanographic research facilities.  :-)

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
