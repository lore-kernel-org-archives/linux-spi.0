From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [Gumstix-users] SPI output
Date: Fri, 14 Nov 2008 13:45:37 -0500
Message-ID: <491DC751.9020604@whoi.edu>
References: <1206133276.47e4221cacd79@webmail.vt.edu>	
	<20297759.post@talk.nabble.com> <490F3451.1070305@whoi.edu>	
	<20309739.post@talk.nabble.com> <490F6006.8030205@whoi.edu>	
	<20369138.post@talk.nabble.com> <491366E8.1040206@whoi.edu>	
	<20371635.post@talk.nabble.com> <4913C07C.5060803@whoi.edu>	
	<491B8318.7080208@whoi.edu>
	<4753a0e30811141009l7a6899dchaf3b5ebf2b1654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Pranav Sanghadia <pranav.sanghadia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4753a0e30811141009l7a6899dchaf3b5ebf2b1654-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Pranav Sanghadia wrote:
> Hi Ned,
> 
> Thanks, I was stuck with Gumstix boot issue. But now the Gumstix is working
> again.
> 
> I am taking a look at spidev documentation, looks like spidev is the way to
> go.

One other note.  For spidev to work with pxa2xx_spi in DMA mode, you
will have to wait for a patch to pxa2xx_spi that I am working on.  There
is a problem with DMA when using the same buffer for tx and rx, as
spidev does.  It should still work as-is in PIO mode.

> I am using buildroot latest version, do you know how to compile just one
> kernel module say spidev without compiling whole kernel code?

Not really.  Once you have compiled the whole kernel, if you then change
one module, only that module (and maybe a few other minor things) will
get re-compiled.

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
