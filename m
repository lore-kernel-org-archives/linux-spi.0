From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pxa2xx_spi: spi_bfin5xx: limit reaches -1
	rather than 0
Date: Sun, 08 Feb 2009 16:53:40 +0100
Message-ID: <498F0004.1030709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

vi drivers/spi/pxa2xx_spi.c +919 
vi drivers/spi/spi_bfin5xx.c +645

        if (flush(drv_data) == 0) {
                dev_err(&drv_data->pdev->dev, "pump_transfers: flush failed\n");
                message->status = -EIO;
                giveback(drv_data);
                return;
        }

But with a postfix decrement limit reaches -1 rather than 0.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c  |    2 +-
 drivers/spi/spi_bfin5xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index d0fc4ca..3164741 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -185,7 +185,7 @@ static int flush(struct driver_data *drv_data)
 		while (read_SSSR(reg) & SSSR_RNE) {
 			read_SSDR(reg);
 		}
-	} while ((read_SSSR(reg) & SSSR_BSY) && limit--);
+	} while ((read_SSSR(reg) & SSSR_BSY) && --limit);
 	write_SSSR(SSSR_ROR, reg);
 
 	return limit;
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 7fea3cf..ea94567 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -162,7 +162,7 @@ static int flush(struct driver_data *drv_data)
 	unsigned long limit = loops_per_jiffy << 1;
 
 	/* wait for stop and clear stat */
-	while (!(read_STAT(drv_data) & BIT_STAT_SPIF) && limit--)
+	while (!(read_STAT(drv_data) & BIT_STAT_SPIF) && --limit)
 		cpu_relax();
 
 	write_STAT(drv_data, BIT_STAT_CLR);

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
