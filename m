From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc5] spi_bitbang: short transfer
	status fix
Date: Tue, 11 Mar 2008 08:27:49 -0800
Message-ID: <200803110927.49850.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

SPI controller drivers return number of bytes actually transfered from
bitbang->txrx_bufs() method.  This updates handling of short transfers
(where the transfer size is less than requested):

 - Even zero byte short transfers should report errors;
 - Include short transfers in the total of transferred bytes;
 - Use EREMOTEIO (like USB) not EMSGSIZE to report short transfers

Short transfers don't normally mean invalid message sizes, but if the
underlying controller driver needs to use EMSGSIZE it can still do so.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
[db: fix two more minor issues]
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bitbang.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- g26.orig/drivers/spi/spi_bitbang.c	2008-03-10 19:44:19.000000000 -0700
+++ g26/drivers/spi/spi_bitbang.c	2008-03-11 09:24:03.000000000 -0700
@@ -343,12 +343,14 @@ static void bitbang_work(struct work_str
 					t->rx_dma = t->tx_dma = 0;
 				status = bitbang->txrx_bufs(spi, t);
 			}
+			if (status > 0)
+				m->actual_length += status;
 			if (status != t->len) {
-				if (status > 0)
-					status = -EMSGSIZE;
+				/* always report some kind of error */
+				if (status >= 0)
+					status = -EREMOTEIO;
 				break;
 			}
-			m->actual_length += status;
 			status = 0;
 
 			/* protocol tweaks before next transfer */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
