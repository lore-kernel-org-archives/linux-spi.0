From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Tue, 12 Feb 2008 15:19:46 +1100
Message-ID: <33e9dd1c0802112019u3ae784a8yf45f2cac29f42325@mail.gmail.com>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
	<200802111851.10155.david-b@pacbell.net> <47B11178.6090904@whoi.edu>
	<33e9dd1c0802111948u2256d0adj8caa478073795d78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802111948u2256d0adj8caa478073795d78-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Feb 12, 2008 2:48 PM, Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org> wrote:
>
> pump_transfers() is called from pump_messages() and a few
> other places, all of which run in a workqueue. So it's not called from
> interrupt context but from a workqueue.

I just had a closer look at this and it's not true in all cases. It
can also be invoked from dma_transfer_complete() which  is reached in
interrupt context. This is probably the case which is improving my
performance so much.

So my change is bad in that it increases the maximum interrupt
latency. It's also the only way I know to get decent SPI utilisation
when you're doing large numbers of small transfers (as I am).

Is there a better way of doing this?

Cheers,
Zik

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
