From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/10] Blackfin SPI driver: use new GPIO
	API and add error handling
Date: Fri, 12 Oct 2007 11:04:56 +0800
Message-ID: <1192158304-8277-3-git-send-email-bryan.wu@analog.com>
References: <1192158304-8277-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192158304-8277-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c                 |   29 +++++++++++++++++++++++------
 include/asm-blackfin/mach-bf533/portmux.h |    2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 2992ada..8041b89 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1165,6 +1165,22 @@ static inline int destroy_queue(struct driver_data *drv_data)
 	return 0;
 }
 
+static int setup_pin_mux(int action)
+{
+
+	u16 pin_req[] = {P_SPI0_SCK, P_SPI0_MISO, P_SPI0_MOSI, 0};
+
+	if (action) {
+		if (peripheral_request_list(pin_req, DRV_NAME)) {
+			return -EFAULT;
+		}
+	} else {
+		peripheral_free_list(pin_req);
+	}
+
+	return 0;
+}
+
 static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1182,12 +1198,9 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (peripheral_request(P_SPI0_SCK, DRV_NAME) ||
-		 peripheral_request(P_SPI0_MISO, DRV_NAME) ||
-		 peripheral_request(P_SPI0_MOSI, DRV_NAME) ) {
-
+	if (setup_pin_mux(1)) {
 		dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
-		goto out_error_queue_alloc;
+		goto out_error;
 	}
 
 	drv_data = spi_master_get_devdata(master);
@@ -1223,9 +1236,11 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "controller probe successfully\n");
 	return status;
 
-      out_error_queue_alloc:
+out_error_queue_alloc:
 	destroy_queue(drv_data);
+out_error:
 	spi_master_put(master);
+
 	return status;
 }
 
@@ -1255,6 +1270,8 @@ static int __devexit bfin5xx_spi_remove(struct platform_device *pdev)
 	/* Disconnect from the SPI framework */
 	spi_unregister_master(drv_data->master);
 
+	setup_pin_mux(0);
+
 	/* Prevent double remove */
 	platform_set_drvdata(pdev, NULL);
 
diff --git a/include/asm-blackfin/mach-bf533/portmux.h b/include/asm-blackfin/mach-bf533/portmux.h
index b88d7a0..137f488 100644
--- a/include/asm-blackfin/mach-bf533/portmux.h
+++ b/include/asm-blackfin/mach-bf533/portmux.h
@@ -42,7 +42,7 @@
 #define P_SPORT0_DRPRI	(P_DONTCARE)
 
 #define P_SPI0_MOSI	(P_DONTCARE)
-#define P_SPI0_MIS0	(P_DONTCARE)
+#define P_SPI0_MISO	(P_DONTCARE)
 #define P_SPI0_SCK	(P_DONTCARE)
 #define P_SPI0_SSEL7	(P_DEFINED | P_IDENT(GPIO_PF7))
 #define P_SPI0_SSEL6	(P_DEFINED | P_IDENT(GPIO_PF6))
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
