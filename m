From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 18:51:09 -0800
Message-ID: <200802111851.10155.david-b@pacbell.net>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802111454k5deeaa38o9d21cee610b79da7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> While we're on the subject of the pxa2xx_spi driver, I've found that
> it has incredibly slow throughput. The problem appears to be related to
> the use of a tasklet in pumping messages. The initial setup and
> transfer is quick but then the tasklet is started and a context switch
> causes terrible latency. It takes around a millisecond for the tasklet
> to get control at which point the chip select is released and the SPI
> bus is available for the next transfer. This means that running as
> hard as it can the bus is idle 99% of the time. I've experimented with
> removing the tasklet from the driver and it does improve the situation
> markedly.

Got patch?  :)

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
