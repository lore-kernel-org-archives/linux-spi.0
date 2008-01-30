From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/6] [Blackfin] SPI driver: remove
	useless return status check in restore_state function pointed
	by Michael.
Date: Wed, 30 Jan 2008 17:13:36 +0800
Message-ID: <1201684421-26124-2-git-send-email-bryan.wu@analog.com>
References: <1201684421-26124-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1201684421-26124-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 7ef39a6..8fd1365 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -223,10 +223,9 @@ static void cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
 #define MAX_SPI_SSEL	7
 
 /* stop controller and re-config current chip*/
-static int restore_state(struct driver_data *drv_data)
+static void restore_state(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
-	int ret = 0;
 
 	/* Clear status and disable clock */
 	write_STAT(drv_data, BIT_STAT_CLR);
@@ -239,13 +238,6 @@ static int restore_state(struct driver_data *drv_data)
 
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
@@ -978,10 +970,7 @@ static void pump_messages(struct work_struct *work)
 
 	/* Setup the SSP using the per chip configuration */
 	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
-	if (restore_state(drv_data)) {
-		spin_unlock_irqrestore(&drv_data->lock, flags);
-		return;
-	};
+	restore_state(drv_data);
 
 	list_del_init(&drv_data->cur_msg->queue);
 
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
