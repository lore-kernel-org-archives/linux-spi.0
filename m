From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: SPI controller bugfixes needed (full duplex
	+ DMA, data	corruption)
Date: Tue, 18 Nov 2008 08:52:15 +0100
Message-ID: <20081118075215.GD9553@pengutronix.de>
References: <200811151422.32748.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org, AndreaPaterniani@pogo, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200811151422.32748.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

On Sat, Nov 15, 2008 at 02:22:32PM -0800, David Brownell wrote:
> Hi,
> 
> We recently turned up a bug in the pxa2xx SPI driver, which
> turns out to also be present in the spi_imx.c and au1550_spi.c
> drivers too.
> 
> Briefly, full duplex transfers are allowed to share the
> same buffer (or partially overlap it), which means that
> the dma mapping operations must be done in a safe order:
> 
>  - first map the TX buffer, so cache data gets written
>    to memory where the DMA will pick it up;
> 
>  - then map the RX buffer, so that cache entries (with
>    soon-to-be-stale data) get removed.
> 
> Doing it the other order, as is done with spi_imx and
> with au1550_spi, causes data corruption by discarding
> data from the cache *before* writing it to memory.
> 
> If you can do it, it'd be good to see this fixed before
> the 2.6.28 kernel ships.

Hm, this is a non trivial fix. I don't have a MX1 based hardware with
something on the SPI bus handy, so this would be a shot in the dark for
me. I hope Andrea jumps in, otherwise we'll have to wait till the driver
works on MX2.

Sascha

-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
