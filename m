From: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Wed, 27 Feb 2008 13:15:08 -0500
Message-ID: <8bd0f97a0802271015t444e8993rb8413a11aa4446d7@mail.gmail.com>
References: <47C42D50.7020204@rubico.se>
	<386072610802262023t6bd22875kfeb58c797be66024@mail.gmail.com>
	<200802262046.29906.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	hp-VrBV9hrLPhE@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802262046.29906.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Tue, Feb 26, 2008 at 11:46 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Tuesday 26 February 2008, Bryan Wu wrote:
>  > On Tue, Feb 26, 2008 at 11:16 PM, Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org> wrote:
>
>  > --
>  > /* NOTES:
>  >  *
>  >  * ...
>
> >  *
>  >  * - MMC depends on a different chipselect management policy than the
>  >  *   SPI interface currently supports for shared bus segments:  it needs
>  >  *   to issue multiple spi_message requests with the chipselect active,
>  >  *   using the results of one message to decide the next one to issue.
>  >  *
>  >  *   Pending updates to the programming interface, this driver expects
>  >  *   that it not share the bus with other drivers (precluding conflicts).
>  >  *
>  >  * - We tell the controller to keep the chipselect active from the
>  >  *   beginning of an mmc_host_ops.request until the end.  So beware
>  >  *   of SPI controller drivers that mis-handle the cs_change flag!
>  >  *
>  >  *   However, many cards seem OK with chipselect flapping up/down
>  >  *   during that time ... at least on unshared bus segments.
>  >  */
>  > ---
>  >
>  > So we can investigate with the SPI framework update.
>  >
>  > >  There is one messaging scheme that i cant figure out how to create
>  > >  correctly using spi messages and transfers that is important for the
>  > >  MMC/SD SPI protocol.
>
>  I'm not following something here.  Is there another MMC-over-SPI
>  driver being developed?  Why not use the current one?

a MMC-over-SPI driver for the Blackfin was developed by Hans long
before there was a SPI framework in the kernel let alone the
MMC-over-SPI driver that is in there now.  i suggested he look at
integrating anything from his driver into the one that's in mainline
now and while that'll happen at some point, it looks like he can get
the issues he has with the old one sorted out sooner.
-mike

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
