From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] spi: limit reaches -1, tested 0
Date: Sun, 08 Feb 2009 15:18:40 +0100
Message-ID: <498EE9C0.3010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
To: dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753772AbZBHOSy@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With a postfix decrement limit will reach -1 rather than 0,
so the warning will not be issued.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 269a55e..a4652f1 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -779,7 +779,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 			/* Read trailing bytes */
 			limit = loops_per_jiffy << 1;
-			while ((read(drv_data) == 0) && limit--);
+			while ((read(drv_data) == 0) && --limit);
 
 			if (limit == 0)
 				dev_err(&drv_data->pdev->dev,
