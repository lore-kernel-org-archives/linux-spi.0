From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 20:02:49 -0800
Message-ID: <200802112002.49870.david-b@pacbell.net>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<200802111851.10155.david-b@pacbell.net>
	<33e9dd1c0802111915q48cb80ecxb33461a9263f9295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802111915q48cb80ecxb33461a9263f9295-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday 11 February 2008, Zik Saleeba wrote:
> Incidentally I've also written a driver for the NXP sc16is752 dual
> UART (connects via SPI). Is anyone interested in that?

Rule of thumb:  We're always interested in having new Linux drivers.  :)
Even if nobody else uses it today, tomorrow may be a different story.

In this case, while the SPI list is probably the best place to get
a review of its SPI capability (first?), I'd suggest that LKML would
be the best place to get feedback on how it talks to the serial driver
framework.  Alan Cox has been doing a bunch of long-overdue cleanup
to that framework, so there may be updated "best practices" to know.

- Dave

p.s. Speaking of drivers for slightly atypical devices ... 2.6.25-rc1
     added drivers/net/enc28j60.c which is a 10baseT Ethernet driver,
     communicating via SPI.

     A SPI driver for the n9604 USB peripheral chip would be fun too!



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
