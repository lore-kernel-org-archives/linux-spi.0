From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Fw: Re: PXA270 SSPSFRM gates chip select ?
Date: Tue, 12 Feb 2008 11:24:00 -0500
Message-ID: <47B1C820.2010202@whoi.edu>
References: <20080212110118.3162a1d2.merrij3@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080212110118.3162a1d2.merrij3-IL7dBOYR4Vg@public.gmane.org>
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
> Ned wrote:
> 
>> I will try to think about a patch tomorrow.  I volunteer to be involved 
>> in this so that it gets fixed without breaking the other things I need 
>> to do.  Hopefully Stephen will be available to review any patches.
> 
> Thank you for volunterring to work on this.  For my particular (embedded)
> application, I think that I can get around the problem with an initial
> (dummy) transfer to get things set up.  ... but I think a general
> repair for the Kernel mainline would be a good idea.
> 
> On an unrelated note, I received the message below from someone else
> on the SPI list.  The issue he raises seems valid based on what I have
> seen in my usage ... however, I suspect that a fix would be difficult.
> I forward it simply for your information/consideration ....
> 
> Thanks, Scott.
> 
> 
> While we're on the subject of the pxa2xx_spi driver, I've found that
> it's incredibly slow to access. The problem appears to be related to
> the use of a tasklet in pumping messages. The initial setup and
> transfer is quick but then the tasklet is started and a context switch
> causes terrible latency. It takes around a millisecond for the tasklet
> to get control at which point the chip select is released and the SPI
> bus is available for the next transfer. This means that running as
> hard as it can the bus is idle 99% of the time. I've experimented with
> removing the tasklet from the driver and it does improve the situation
> markedly.

Yes, I have seen this, and have communicated on the list about it.  It 
might be easy to fix, but detrimental to kernel interrupt latency.  I 
would like to hear what Stephen has to say about this, as I know that 
his application, servicing audio A/Ds and D/As (and for which he wrote 
the driver), is more typical than my application (a read-only fire hose, 
streaming 11Mbit/sec data).

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
