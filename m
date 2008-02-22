From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length	
	transfer
Date: Fri, 22 Feb 2008 14:36:53 -0500
Message-ID: <47BF2455.8030904@whoi.edu>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
	<200802201855.02605.marc.pignat@hevs.ch>
	<20080221.105233.41199605.nemoto@toshiba-tops.co.jp>
	<200802211026.17816.marc.pignat@hevs.ch>
	<20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<47BED734.5030002@whoi.edu>
	<20080222190228.2B0CB28E363@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.pignat-7TsPiqsLilE@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080222190228.2B0CB28E363-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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
>> However, if the transfer is by DMA, note that the PXA255 and PXA270
>> Developer's Manuals have the following language regarding DMA lengths:
>>
>> 	LEN = 0 means zero bytes for descriptor-fetch transactions.
>> 	LEN = 0 is an invalid setting for no-descriptor-fetch
>> 	transactions. ...
>>
>> Because the pxa2xx_spi driver does not currently use DMA descriptors,
>> zero length DMAs are invalid.
> 
> In that case the pxa2xx_spi driver should add a special case to
> avoid starting such transfers in DMA mode.

So, what I think you said is that it would be better for pxa2xx_spi to
silently ignore a zero-length message, passing it back with the rest of
the message when all is complete, than to reject the message.  I see no
reason why that could not be done, though it may be tricky to set other
things like SSP modes and chip select and *not* start the DMA.  It would
have to be tested, so I'm not sure when I could try that.

>> I agree with Marc: any such delay will be undefined, in the general
>> case.  It might work for a specific driver implementation.
> 
> Is that what Marc said?  I couldn't tell.  In any case, I disagree;
> the semantics of that delay are clearly define.

Maybe I am missing something.  Aren't we talking about a transfer in a
message, with or without other transfers, who's only unique
characteristic is that that its length is zero?    What is clearly
defined about what should happen during that transfer?  I think (maybe
we are all confused) that Marc and I are talking about the delay, likely
short, caused by the processing or ignoring of that zero length transfer.

Or are you and Atsushi talking about using spi_transfer.delay_usecs
*with* a zero length transfer to effectively put a delay between the
assertion of CS and the start of the first clock?  If so, then I guess I
missed the original point.  Sorry.

--

By the way, reading spi.h again, it looks like spi_transfer.delay_usecs
is supposed to be implemented between the last bit movement of a
transfer and any change of CS at the end of a transfer.  Is that right?
 I think that pxa2xx_spi is dropping CS, if requested, immediately at
the end of transfer, and then putting spi_transfer.delay_usecs between
that transfer and the next.

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
