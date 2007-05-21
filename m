From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: PXA270 + ads7846 (TI TSC2046)
Date: Sun, 20 May 2007 20:08:58 -0700
Message-ID: <200705202008.58743.david-b@pacbell.net>
References: <200704240102.27508.david-b@pacbell.net>
	<1177692001.4362.61.camel@truckin.grid-net.com>
	<20070504155402.GA25198@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070504155402.GA25198@zarina>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 04 May 2007, Anton Vorontsov wrote:

> Why Motorola hardcoded in pxa2xx spi driver? Is that means that with
> Motorola bit set we can do all we can with National bit? If not (and
> from my observation it's not) is that means that we can't use pxa2xx
> spi driver for chips requiring National/Microwire?

Modulo the misconception there -- Microwire being a strict subset
of the pure SPI/Motorola mode -- one other issue came up recently.

It seems that the patch making drivers/input/touchscreen/ads7846.c
use SPI_MODE_1 was incorrect.  It should use SPI_MODE_0 ... since
it uses normal clock polarity (CPOL=0) and samples on the leading
edge of that clock (CPHA=0).

When I tested -- with omap_uwire and pxa2xx_spi -- I used SPI_MODE_0;
but it was later changed.  It seems that when it's used with the
omap_uwire driver, SPI_MODE_1 also works.  That might explain some
of the problems observed...

- Dave



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
