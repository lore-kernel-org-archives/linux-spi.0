From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI or CSPI transfers using DMA
Date: Thu, 20 Nov 2008 18:07:07 -0500
Message-ID: <4925ED9B.305@whoi.edu>
References: <10811398.477881225431989704.JavaMail.nabble@isper.nabble.com>
	<200811201339.28627.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, magene-5892unH0nlnYtjvyW6yDsg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811201339.28627.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

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
