From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Tue, 12 Feb 2008 14:48:22 +1100
Message-ID: <33e9dd1c0802111948u2256d0adj8caa478073795d78@mail.gmail.com>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
	<200802111851.10155.david-b@pacbell.net> <47B11178.6090904@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47B11178.6090904-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
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

On Feb 12, 2008 2:24 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
>
> I thought it was generally considered good practice...

Yes, it probably is good practice. Unfortunately the tasklet seemed to
be causing performance issues which made the driver essentially
unusable for my application. I'm working with a serial chip which
requires large numbers of small SPI transfers (several register reads
etc. via SPI on each interrupt). If each of these transfers takes a
millisecond it becomes impossible to service even a single fairly slow
serial connection. I have to service 8 relatively fast serial ports so
I can't put up with 99% SPI unavailability.

I'm using an earlier kernel (2.6.16) which I've back-ported the latest
SPI code so it's possible that tasklets work better in more recent
kernels. Anyone know if that might be true?

> I assume that "removing the tasklet" means calling pump_transfers()
> directly from the interrupt service routines, rather than having the
> ISRs schedule a tasklet to make that call.  Right?

Not exactly. pump_transfers() is called from pump_messages() and a few
other places, all of which run in a workqueue. So it's not called from
interrupt context but from a workqueue.

> I believe tasklets will never run later than the next timer
> tick, which I believe is 1ms on most moder processors (but which can be
> changed).  Thus 1ms should be the maximum latency; I would expect better
> than 1ms most of the time.

I seem to be seeing 1ms consistently on a Compulab cm-x270 - or at
least I did until I made this change.

Cheers,
Zik

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
