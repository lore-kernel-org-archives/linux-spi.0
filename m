From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Linux as a SPI slave device - anything new?
Date: Fri, 13 Aug 2010 17:16:51 -0600
Message-ID: <AANLkTi=YSkcmPQUZL84siL5q-paepukQ4Tuvf=sr2_qM@mail.gmail.com>
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

On Mon, Jul 26, 2010 at 7:54 PM, John Williams
<john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org> wrote:
> Hi,
>
> I was wondering if anything has changed in the Linux SPI stack to
> allow the creation of SPI slave devices - that is have an Embedded
> Linux system look like a SPI slave to a master elsewhere in the
> system?

Nope, no change.  If spi slave support is needed, then you may as well
do a custom driver interface as the SPI api really isn't suitable.  I
suspect that any spi slave driver is going to be very implementation
specific anyway.  At least I haven't seen any common requirements
bubble up to the surface yet.

g.

>
> I asked about this a few years ago and there was no general solution -
> it's a hard problem because the slave must respond very quickly to a
> master request, and userspace latencies in there may make it
> impossible.
>
> Just wondering if that is still the case.
>
> Thanks,
>
> John
>
> ------------------------------------------------------------------------------
> The Palm PDK Hot Apps Program offers developers who use the
> Plug-In Development Kit to bring their C/C++ apps to Palm for a share
> of $1 Million in cash or HP Products. Visit us here for more details:
> http://ad.doubleclick.net/clk;226879339;13503038;l?
> http://clk.atdmt.com/CRS/go/247765532/direct/01/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
