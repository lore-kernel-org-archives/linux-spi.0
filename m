From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 23:43:50 -0500
Message-ID: <47B12406.9040208@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>	
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>	
	<200802111851.10155.david-b@pacbell.net>
	<47B11178.6090904@whoi.edu>
	<33e9dd1c0802111948u2256d0adj8caa478073795d78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802111948u2256d0adj8caa478073795d78-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> On Feb 12, 2008 2:24 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
>> I thought it was generally considered good practice...
> 
> Yes, it probably is good practice. Unfortunately the tasklet seemed to
> be causing performance issues which made the driver essentially
> unusable for my application. I'm working with a serial chip which
> requires large numbers of small SPI transfers (several register reads
> etc. via SPI on each interrupt). If each of these transfers takes a
> millisecond it becomes impossible to service even a single fairly slow
> serial connection. I have to service 8 relatively fast serial ports so
> I can't put up with 99% SPI unavailability.

I thought you might be doing lots of little transfers; that would 
explain your need.  Is each transfer in a separate message, because you 
have to interact with every transfer, or can you put several transfers 
in one message, to be executed without higher level interaction?   The 
latter would be faster because each transfer would be pumped in 
interrupt context, rather than from a work queue.

> I'm using an earlier kernel (2.6.16) which I've back-ported the latest
> SPI code so it's possible that tasklets work better in more recent
> kernels. Anyone know if that might be true?

Well I do know that the version of pxa2xx_spi.c in 2.6.16 is very old. 
How much did you backport?  Did you get Stephen's 12/7/06 patches? 
Reading your test above, I would guess you did, but wonder what you had 
to change to get the "latest" to compile in 2.6.16.  Does your 
pxa2xx_spi.c contain the function "set_dma_burst_and_threshold()"? If it 
does, you have Stephen's 12/7/06 patch.

>> I assume that "removing the tasklet" means calling pump_transfers()
>> directly from the interrupt service routines, rather than having the
>> ISRs schedule a tasklet to make that call.  Right?
> 
> Not exactly. pump_transfers() is called from pump_messages() and a few
> other places, all of which run in a workqueue. So it's not called from
> interrupt context but from a workqueue.

Actually, it is scheduled from each of the xx_error_stop() and 
xx_transfer_complete() routines, which all run in interrupt context.  It 
is also scheduled from pump_messages, which is the only place it is 
scheduled from a work_queue.  So it is scheduled from a work_queue only 
for each new message, but from interrupt context for each transfer 
within a message, and at the end of each each message to call giveback().

>> I believe tasklets will never run later than the next timer
>> tick, which I believe is 1ms on most modern processors (but which can be
>> changed).  Thus 1ms should be the maximum latency; I would expect better
>> than 1ms most of the time.
> 
> I seem to be seeing 1ms consistently on a Compulab cm-x270 - or at
> least I did until I made this change.

You might want to check the kernel config parameters for your system and 
make sure that the timer ticks are at least 1000HZ.   I notice that mine 
is set by default (by Gumstix perhaps) to be a tickless system (dynamic 
ticks):

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

I don't know if this helps; it is just the way mine is set.

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
