From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: SPI controller bugfixes needed (full duplex +
	DMA, data corruption)
Date: Sat, 15 Nov 2008 14:22:32 -0800
Message-ID: <200811151422.32748.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Andrea Paterniani@pogo, a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org,
	Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

We recently turned up a bug in the pxa2xx SPI driver, which
turns out to also be present in the spi_imx.c and au1550_spi.c
drivers too.

Briefly, full duplex transfers are allowed to share the
same buffer (or partially overlap it), which means that
the dma mapping operations must be done in a safe order:

 - first map the TX buffer, so cache data gets written
   to memory where the DMA will pick it up;

 - then map the RX buffer, so that cache entries (with
   soon-to-be-stale data) get removed.

Doing it the other order, as is done with spi_imx and
with au1550_spi, causes data corruption by discarding
data from the cache *before* writing it to memory.

If you can do it, it'd be good to see this fixed before
the 2.6.28 kernel ships.

- Dave

p.s. Note that full duplex transfers became a bit more
     common after f9b90e39cbc5c4d6ef60022fd1f25d541df0aad1
     merged (in the 2.6.28-rc0 merge frenzy).

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
