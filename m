From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/14] Blackfin SPI driver: Add SPI
	master controller platform device 1
Date: Tue, 30 Oct 2007 17:17:58 +0800
Message-ID: <1193735885-8202-8-git-send-email-bryan.wu@analog.com>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193735885-8202-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   52 ++++++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3f3630c..3bd8359 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -209,17 +209,26 @@ static void cs_deactive(struct chip_data *chip)
 	write_FLAG(flag);
 }
 
-#define MAX_SPI0_SSEL	7
+#define MAX_SPI_SSEL	7
 
 /* stop controller and re-config current chip*/
 static int restore_state(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 	int ret = 0;
-	u16 ssel[MAX_SPI0_SSEL] = {P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
-					P_SPI0_SSEL4, P_SPI0_SSEL5,
-					P_SPI0_SSEL6, P_SPI0_SSEL7,};
-
+	u16 ssel[3][MAX_SPI_SSEL] = {
+		{P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
+		P_SPI0_SSEL4, P_SPI0_SSEL5,
+		P_SPI0_SSEL6, P_SPI0_SSEL7},
+
+		{P_SPI1_SSEL1, P_SPI1_SSEL2, P_SPI1_SSEL3,
+		P_SPI1_SSEL4, P_SPI1_SSEL5,
+		P_SPI1_SSEL6, P_SPI1_SSEL7},
+
+		{P_SPI2_SSEL1, P_SPI2_SSEL2, P_SPI2_SSEL3,
+		P_SPI2_SSEL4, P_SPI2_SSEL5,
+		P_SPI2_SSEL6, P_SPI2_SSEL7},
+	};
 	/* Clear status and disable clock */
 	write_STAT(BIT_STAT_CLR);
 	bfin_spi_disable(drv_data);
@@ -234,9 +243,9 @@ static int restore_state(struct driver_data *drv_data)
 		int i = chip->chip_select_num;
 
 		dev_dbg(&drv_data->pdev->dev, "chip select number is %d\n", i);
-
-		if ((i > 0) && (i <= MAX_SPI0_SSEL))
-			ret = peripheral_request(ssel[i-1], DRV_NAME);
+		if ((i > 0) && (i <= MAX_SPI_SSEL))
+			ret = peripheral_request(
+				ssel[drv_data->master->bus_num][i-1], DRV_NAME);
 
 		chip->chip_select_requested = 1;
 	}
@@ -329,7 +338,6 @@ static void u8_reader(struct driver_data *drv_data)
 	write_TDBR(0xFFFF);
 
 	dummy_read();
-
 	while (drv_data->rx < drv_data->rx_end - 1) {
 		while (!(read_STAT() & BIT_STAT_RXS))
 			continue;
@@ -640,7 +648,6 @@ static void pump_transfers(unsigned long data)
 	message = drv_data->cur_msg;
 	transfer = drv_data->cur_transfer;
 	chip = drv_data->cur_chip;
-
 	/*
 	 * if msg is error or done, report it back using complete() callback
 	 */
@@ -1202,17 +1209,20 @@ static inline int destroy_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static int setup_pin_mux(int action)
+static int setup_pin_mux(int action, int bus_num)
 {
 
-	u16 pin_req[] = {P_SPI0_SCK, P_SPI0_MISO, P_SPI0_MOSI, 0};
+	u16 pin_req[3][4] = {
+		{P_SPI0_SCK, P_SPI0_MISO, P_SPI0_MOSI, 0},
+		{P_SPI1_SCK, P_SPI1_MISO, P_SPI1_MOSI, 0},
+		{P_SPI2_SCK, P_SPI2_MISO, P_SPI2_MOSI, 0},
+	};
 
 	if (action) {
-		if (peripheral_request_list(pin_req, DRV_NAME)) {
+		if (peripheral_request_list(pin_req[bus_num], DRV_NAME))
 			return -EFAULT;
-		}
 	} else {
-		peripheral_free_list(pin_req);
+		peripheral_free_list(pin_req[bus_num]);
 	}
 
 	return 0;
@@ -1236,11 +1246,6 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (setup_pin_mux(1)) {
-		dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
-		goto out_error;
-	}
-
 	drv_data = spi_master_get_devdata(master);
 	drv_data->master = master;
 	drv_data->master_info = platform_info;
@@ -1295,6 +1300,11 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		goto out_error_queue_alloc;
 	}
 
+	if (setup_pin_mux(1, master->bus_num)) {
+		dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
+		goto out_error;
+	}
+
 	dev_info(dev, "%s, Version %s, regs_base @ 0x%08x\n",
 		DRV_DESC, DRV_VERSION, spi_regs_base);
 	return status;
@@ -1337,7 +1347,7 @@ static int __devexit bfin5xx_spi_remove(struct platform_device *pdev)
 	/* Disconnect from the SPI framework */
 	spi_unregister_master(drv_data->master);
 
-	setup_pin_mux(0);
+	setup_pin_mux(0, drv_data->master->bus_num);
 
 	/* Prevent double remove */
 	platform_set_drvdata(pdev, NULL);
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
