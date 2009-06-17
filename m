From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: ADC SPI kernel driver and latency
Date: Wed, 17 Jun 2009 10:20:02 -0400
Message-ID: <4A38FB92.2030105@whoi.edu>
References: <247792820906170521r4f3b525aq98f3d60fa8dd3bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: John Lists <johnlsts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <247792820906170521r4f3b525aq98f3d60fa8dd3bab-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/17/2009 08:21 AM, John Lists wrote:
> Hi
> 
> I would like to interface from an OMAP3530 running linux 2.6.29 with an ADC
> slave device via SPI but not sure if it is realistic.
> 
> The ADC is externally clocked and alerts the master (the OMAP) that a sample
> is ready for retrieval by pulling a DataReady line low.
> The ADC pulls the DataReady line low every 19 us (52kSamples/s) and then
> expects the Master to retrieve 96 bits from it with a 25MHz SCLK before the
> next sample becomes ready.
> 
> Is it possible/realistic to write a new kernel protocol driver that uses the
> mcspi controller driver and be sure that the sample will be retrieved every
> time before the 19us lapses?
> 
> Basically my question is, what is the best/easiest way to ensure that the
> OMAP retrieves all the data over SPI within 19us from when the DataReady
> line has been pulled low by the ADC?

I just saw that you posted to this ML also.  See my response on:

gumstix-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

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
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
