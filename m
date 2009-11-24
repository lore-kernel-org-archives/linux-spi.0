From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] SPI/i.MX: fix broken error handling for gpio_request
Date: Tue, 24 Nov 2009 17:53:07 +0100
Message-ID: <807htfsw3w.fsf@merkur.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net
To: s.hauer@pengutronix.de
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933509AbZKXQxQ@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

i.MX35-provided chipselects are represented using negative numbers. If
gpio_request() fails and the previous chipselect was a negative number,
the while loop is endless (i is never decremented).

Also, the error loop would never call gpio_free on chipselect[0].

And finally, the error message was missing an endline.

This patch is against 2.6.32-rc8.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 spi_imx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -513,11 +513,12 @@ static int __init spi_imx_probe(struct p
 			continue;
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
 		if (ret) {
-			i--;
-			while (i > 0)
+			while (i > 0) {
+				i--;
 				if (spi_imx->chipselect[i] >= 0)
-					gpio_free(spi_imx->chipselect[i--]);
-			dev_err(&pdev->dev, "can't get cs gpios");
+					gpio_free(spi_imx->chipselect[i]);
+			}
+			dev_err(&pdev->dev, "can't get cs gpios\n");
 			goto out_master_put;
 		}
 	}
