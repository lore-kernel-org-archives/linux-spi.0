From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length	
	transfer
Date: Fri, 22 Feb 2008 14:52:06 -0500
Message-ID: <47BF27E6.3010502@whoi.edu>
References: <200802211026.17816.marc.pignat@hevs.ch>
	<20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200802221030.32263.marc.pignat@hevs.ch>
	<20080222.231510.56565462.anemo@mba.ocn.ne.jp>
	<47BEDBFB.5040305@whoi.edu>
	<20080222190613.0043B229B4D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.pignat-7TsPiqsLilE@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080222190613.0043B229B4D-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

David Brownell wrote:
>> This would be OK.  It would not be hard to fix pxa2xx_spi, for example,
>> to reject zero-length transfers in DMA mode, as long as it is acceptable
>> to reject the message in mid-message.
> 
> Such "illegal message" rejection is best done early; "fail-fast".
> Mid-message rejection isn't wrong, but it's a rude policy.
> 
> It'd be best to fix pxa2xx_spi to not start zero-length DMAs.

So again, same as my last reply, it would be best to handle a zero
length transfer silently, as if it were non-zero, but just skipping over
any invalid hardware operations due to the zero length.

>> 	If it were necessary to scan a
>> whole message for zero-length transfers and refuse to queue an offending
>> message, then that adds burden to all messages.
> 
> Sanity checking messages as they're submitted is easy; and it's
> also the natural point for setting up DMA mappings (and making
> those cachelines available for better use).

Hmmm.... Obviously I have much to learn about modern computers.  It had
not occurred to me, even after reading "Linux Device Drivers", Corbet,
et.al, that by DMA mapping, one frees the cache for other uses.  It
makes sense.  In my application I pass many large buffers to the master
driver, and I map them in the protocol driver.  I did that without good
reason, but now I see it was the proper choice.

Unfortunately, pxa2xx_spi does any DMA mapping not done by the protocol
driver in pump_transfers, as each transfer is submitted to the hardware.
 There is not currently any message checking done in transfer(), the
only error return from that is if the master driver is shutdown (queue
stopped).  The current scheme is to return the message with non-zero
spi_message.status if it has failed *after* execution has been
attempted.  I don't look forward to making major changes, if we really
want all DMA mapping and error checking to be in transfer(), though I
see no reason why it could not be done.

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
