From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Wed, 13 Feb 2008 07:48:22 +1100
Message-ID: <33e9dd1c0802121248q43883d6r481cb6f054de1050@mail.gmail.com>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
	<200802111851.10155.david-b@pacbell.net> <47B11178.6090904@whoi.edu>
	<33e9dd1c0802111948u2256d0adj8caa478073795d78@mail.gmail.com>
	<47B12406.9040208@whoi.edu>
	<33e9dd1c0802112124y5ae8dd39ua9078f2b3878a018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802112124y5ae8dd39ua9078f2b3878a018-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Followup on this problem: I did some experimentation using workqueues
differently in my serial-via-spi driver and it seems to have fixed the
problem with poor throughput in the pxa2xx_spi driver. I was
previously using the default workqueue in my serial driver but changed
it to use separate workqueues. To my surprise this completely fixed
the problem I was having with the pxa2xx_spi driver being slow to
respond to dma_transfer_complete(). Presumably the extra load on the
default shared workqueue was holding up the service tasklet in
pxa2xx_spi.

So thanks to all - the problem is resolved at last. For what it's
worth I'm still getting a 90us chip select period for only 6us of
actual SPI transfer for short requests but I think that's down to the
speed of the processor and the driver overhead.

Thanks everyone for all the suggestions you've offered in the last
couple of days!

Cheers,
Zik

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
