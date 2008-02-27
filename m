From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Tue, 26 Feb 2008 20:46:29 -0800
Message-ID: <200802262046.29906.david-b@pacbell.net>
References: <47C42D50.7020204@rubico.se>
	<386072610802262023t6bd22875kfeb58c797be66024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hp-VrBV9hrLPhE@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>
To: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <386072610802262023t6bd22875kfeb58c797be66024-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tuesday 26 February 2008, Bryan Wu wrote:
> On Tue, Feb 26, 2008 at 11:16 PM, Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org> wrote:

> --
> /* NOTES:
>  *
>  * ...
>  *
>  * - MMC depends on a different chipselect management policy than the
>  *   SPI interface currently supports for shared bus segments:  it needs
>  *   to issue multiple spi_message requests with the chipselect active,
>  *   using the results of one message to decide the next one to issue.
>  *
>  *   Pending updates to the programming interface, this driver expects
>  *   that it not share the bus with other drivers (precluding conflicts).
>  *
>  * - We tell the controller to keep the chipselect active from the
>  *   beginning of an mmc_host_ops.request until the end.  So beware
>  *   of SPI controller drivers that mis-handle the cs_change flag!
>  *
>  *   However, many cards seem OK with chipselect flapping up/down
>  *   during that time ... at least on unshared bus segments.
>  */
> ---
> 
> So we can investigate with the SPI framework update.
> 
> >  There is one messaging scheme that i cant figure out how to create
> >  correctly using spi messages and transfers that is important for the
> >  MMC/SD SPI protocol.

I'm not following something here.  Is there another MMC-over-SPI
driver being developed?  Why not use the current one?


> >  Example of writing a single 512 byte block to SD/MMC, CS need to be
> >  asserted during whole sequence, no other traffic can be allowed.
> >
> >  Send command:           6 Bytes
> >  Poll for cmd response:  1 Byte( appears after 1-3 bytes read)
> >  Send data+token:        512+1 Bytes
> >  Poll for data response: 1 Byte (within a few bytes)
> >     --- card is now busy for a while and it is ok to deselct chip ---
> >  Poll for not busy:      coult take 30-10000 bytes at 20 Mhz to finnish
> >
> >  Last step can be done blockwise, 64 bytes a time by DMA for example..
> >  'not busy' is just a matter of transison from busy tokens to idle tokens.

Right, and there are plenty of other similar examples.  The current
drivers/mmc/host/mmc_spi.c code handles that, if the underlying SPI
controller driver handles the chipselecct as expected.


> >  Note that 'send data+token' can only be done if a specific cmd response
> >  was found. Same for data response, if not correct response another path
> >  in code will be taken(ask for card status). All this needs to be done
> >  "atomically" on the bus. Can this be achieved with the current state of
> >  the spi driver?

As noted above.  There are two issues:  (a) keeping other drivers off
the bus, and (b) making sure chipselect doesn't go inactive at the wrong
place.

The *current* assumption is that the bus will be unshared, so (a) isn't
an issue ... and that the SPI master controller driver will implement
the chipselect hinting mechanism (spi_transfer.cs_change set on the
last transfer).


We do need better solutions for (a) though.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
