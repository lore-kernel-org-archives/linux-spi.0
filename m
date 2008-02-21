From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Wed, 20 Feb 2008 23:31:32 -0500
Message-ID: <47BCFEA4.1090105@whoi.edu>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802201932v6873415bm9202ad478f192b7f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Zik Saleeba wrote:
> I've been having some more problems with my SPI application on the
> PXA270. When I suspend the system it all goes into suspend mode
> correctly but when it comes back on resume any call to the pxa2xx_spi
> code just hangs.
>
> Has anyone experienced this? Has anyone used suspend/resume
> successfully with pxa2xx_spi?

I think it is more likely that no one has tried it.  What version of
the driver/kernel are you using?  I think David recently removed some
obsolete stuff related to suspend/resume, but I don't know if there is
any reason why it would or wouldn't work in any particular version of
the kernel.

I'm not sure what you mean by "it all goes into suspend mode correctly".
If it does not resume, it seems possible that the errors could be
related to either the suspend or the resume process, if the proper
state is not remembered or restored.

Does the whole system hang (deadlock in kernel) or is it only the spi
that is stuck?

I presume you have CONFIG_PM set in the kernel config?  It is not set in
my kernel, by default.  If not set, the suspend/resume functions are NULL.

The suspend/resume support in the driver is pretty simple.  It stops the
message queue, and waits for the message queue to drain (timeout if 5sec
if it fails to drain), then it stops the SSP hardware and clock.  On
resume, it restarts the clock and queue, and then any initial message
will cause the SSP to be restarted (at the bottom of pump_transfers) in
due course.

There may be a bug in the suspend routine.  If stop_queue() fails (queue
does not drain), pxa2xx_spi_suspend() returns with an error code, but no
message.  I don't know if the calling routine is responding to the error
code, but I bet not; what's it going to do, anyway.  If this happens,
the SSP will not be shut down, and the clock not stopped.  It seems like
these actions should occur, with or without a successful queue stop.

You could add a printk in suspend to see if it is completing properly.

David:
Should there be a message if there is an error on suspend, or are
suspending devices supposed to be silent and do the best they can?

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
