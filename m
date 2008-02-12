From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Tue, 12 Feb 2008 16:24:03 +1100
Message-ID: <33e9dd1c0802112124y5ae8dd39ua9078f2b3878a018@mail.gmail.com>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
	<200802111851.10155.david-b@pacbell.net> <47B11178.6090904@whoi.edu>
	<33e9dd1c0802111948u2256d0adj8caa478073795d78@mail.gmail.com>
	<47B12406.9040208@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47B12406.9040208-/d+BM93fTQY@public.gmane.org>
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

On Feb 12, 2008 3:43 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
>
> I thought you might be doing lots of little transfers; that would
> explain your need.  Is each transfer in a separate message, because you
> have to interact with every transfer, or can you put several transfers
> in one message, to be executed without higher level interaction?

Yes, good idea. Unfortunately the transfers are of the form "how many
bytes are waiting" followed by "please send x bytes" so they need to
be separate transfers.

> Does your pxa2xx_spi.c contain the function
> "set_dma_burst_and_threshold()"? If it does, you have Stephen's
> 12/7/06 patch.

Yes thanks, I have that function.

> Actually, it is scheduled from each of the xx_error_stop() and
> xx_transfer_complete() routines, which all run in interrupt context.

Yep sorry - picked that one up in my followup email as I'm sure you've
already seen.

> You might want to check the kernel config parameters for your system and
> make sure that the timer ticks are at least 1000HZ.   I notice that mine
> is set by default (by Gumstix perhaps) to be a tickless system (dynamic
> ticks):
>
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
>
> I don't know if this helps; it is just the way mine is set.

I'll give it a try. Thanks.

Cheers,
Zik

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
