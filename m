From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/9] Blackfin SPI driver: Move GPIO
	config to setup and cleanup
Date: Thu, 11 Oct 2007 18:10:39 +0800
Message-ID: <1192097441-24962-8-git-send-email-bryan.wu@analog.com>
References: <1192097441-24962-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192097441-24962-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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
 drivers/spi/spi_bfin5xx.c |   52 +++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index ecfb7c5..c1516cb 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -136,7 +136,6 @@ struct chip_data {
 	u16 flag;
 
 	u8 chip_select_num;
-	u8 chip_select_requested;
 	u8 n_bytes;
 	u8 width;		/* 0 or 1 */
 	u8 enable_dma;
@@ -216,19 +215,7 @@ static int restore_state(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 	int ret = 0;
-	u16 ssel[3][MAX_SPI_SSEL] = {
-		{P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
-		P_SPI0_SSEL4, P_SPI0_SSEL5,
-		P_SPI0_SSEL6, P_SPI0_SSEL7},
-
-		{P_SPI1_SSEL1, P_SPI1_SSEL2, P_SPI1_SSEL3,
-		P_SPI1_SSEL4, P_SPI1_SSEL5,
-		P_SPI1_SSEL6, P_SPI1_SSEL7},
-
-		{P_SPI2_SSEL1, P_SPI2_SSEL2, P_SPI2_SSEL3,
-		P_SPI2_SSEL4, P_SPI2_SSEL5,
-		P_SPI2_SSEL6, P_SPI2_SSEL7},
-	};
+
 	/* Clear status and disable clock */
 	write_STAT(BIT_STAT_CLR);
 	bfin_spi_disable(drv_data);
@@ -239,17 +226,6 @@ static int restore_state(struct driver_data *drv_data)
 	write_BAUD(chip->baud);
 	cs_active(chip);
 
-	if (!chip->chip_select_requested) {
-		int i = chip->chip_select_num;
-
-		dev_dbg(&drv_data->pdev->dev, "chip select number is %d\n", i);
-		if ((i > 0) && (i <= MAX_SPI_SSEL))
-			ret = peripheral_request(
-				ssel[drv_data->master->bus_num][i-1], DRV_NAME);
-
-		chip->chip_select_requested = 1;
-	}
-
 	if (ret)
 		dev_dbg(&drv_data->pdev->dev,
 			": request chip select number %d failed\n",
@@ -981,6 +957,22 @@ static int transfer(struct spi_device *spi, struct spi_message *msg)
 	return 0;
 }
 
+#define MAX_SPI_SSEL	7
+
+static u16 ssel[3][MAX_SPI_SSEL] = {
+	{P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
+	P_SPI0_SSEL4, P_SPI0_SSEL5,
+	P_SPI0_SSEL6, P_SPI0_SSEL7},
+
+	{P_SPI1_SSEL1, P_SPI1_SSEL2, P_SPI1_SSEL3,
+	P_SPI1_SSEL4, P_SPI1_SSEL5,
+	P_SPI1_SSEL6, P_SPI1_SSEL7},
+
+	{P_SPI2_SSEL1, P_SPI2_SSEL2, P_SPI2_SSEL3,
+	P_SPI2_SSEL4, P_SPI2_SSEL5,
+	P_SPI2_SSEL6, P_SPI2_SSEL7},
+};
+
 /* first setup for new devices */
 static int setup(struct spi_device *spi)
 {
@@ -1109,6 +1101,12 @@ static int setup(struct spi_device *spi)
 
 	spi_set_ctldata(spi, chip);
 
+	dev_dbg(&spi->dev, "chip select number is %d\n", chip->chip_select_num);
+	if ((chip->chip_select_num > 0)
+		&& (chip->chip_select_num <= spi->master->num_chipselect))
+		peripheral_request(ssel[spi->master->bus_num]
+			[chip->chip_select_num-1], DRV_NAME);
+
 	return 0;
 }
 
@@ -1120,6 +1118,10 @@ static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	if ((chip->chip_select_num > 0)
+		&& (chip->chip_select_num <= spi->master->num_chipselect))
+		peripheral_free(ssel[spi->master->bus_num][chip->chip_select_num-1]);
+
 	kfree(chip);
 }
 
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
