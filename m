From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24 1/6] spi_bfin: remove useless
	fault path
Date: Thu, 31 Jan 2008 12:15:37 -0800
Message-ID: <200801311215.37314.david-b@pacbell.net>
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

From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Remove useless return status check in restore_state function.
Issue was pointed out by Michael.

Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- g26.orig/drivers/spi/spi_bfin5xx.c	2008-01-31 11:51:51.000000000 -0800
+++ g26/drivers/spi/spi_bfin5xx.c	2008-01-31 11:51:58.000000000 -0800
@@ -223,10 +223,9 @@ static void cs_deactive(struct driver_da
 #define MAX_SPI_SSEL	7
 
 /* stop controller and re-config current chip*/
-static int restore_state(struct driver_data *drv_data)
+static void restore_state(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
-	int ret = 0;
 
 	/* Clear status and disable clock */
 	write_STAT(drv_data, BIT_STAT_CLR);
@@ -239,13 +238,6 @@ static int restore_state(struct driver_d
 
 	bfin_spi_enable(drv_data);
 	cs_active(drv_data, chip);
-
-	if (ret)
-		dev_dbg(&drv_data->pdev->dev,
-			": request chip select number %d failed\n",
-			chip->chip_select_num);
-
-	return ret;
 }
 
 /* used to kick off transfer in rx mode */
@@ -978,10 +970,7 @@ static void pump_messages(struct work_st
 
 	/* Setup the SSP using the per chip configuration */
 	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
-	if (restore_state(drv_data)) {
-		spin_unlock_irqrestore(&drv_data->lock, flags);
-		return;
-	};
+	restore_state(drv_data);
 
 	list_del_init(&drv_data->cur_msg->queue);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
