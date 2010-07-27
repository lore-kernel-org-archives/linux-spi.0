From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Linux as a SPI slave device - anything new?
Date: Mon, 26 Jul 2010 23:00:37 -0400
Message-ID: <4C4E4BD5.2090804@whoi.edu>
References: <AANLkTimbDo0U7fB60xZ31UfqnAYnEm+HskLfXGyRKamz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dpervushin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: John Williams <john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimbDo0U7fB60xZ31UfqnAYnEm+HskLfXGyRKamz-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/26/2010 09:54 PM, John Williams wrote:
> Hi,
> 
> I was wondering if anything has changed in the Linux SPI stack to
> allow the creation of SPI slave devices - that is have an Embedded
> Linux system look like a SPI slave to a master elsewhere in the
> system?
> 
> I asked about this a few years ago and there was no general solution -
> it's a hard problem because the slave must respond very quickly to a
> master request, and userspace latencies in there may make it
> impossible.
> 
> Just wondering if that is still the case.

As far as I know, nothing has changed, nor is it ever likely to do so,
because of the problem you summarized above.  Restricted slave operation
is still possible, where the next request by the external master can be
predicted, where the master inserts the required delay before clocking a
response, or where the clock is very slow.  But general slave operation
can never be achieved (IMHO); even an interrupt driven kernel
implementation is not generally fast enough on any existing processor
(100s of usec on most processors that would be considered for embedded
use).  If, in the future, processing becomes orders of magnitude faster,
while SPI devices remain slow, then perhaps it will be possible.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
