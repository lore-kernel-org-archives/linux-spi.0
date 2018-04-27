From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] spi: mpc52xx: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 16:32:17 +0530
Message-ID: <aef1b612f61b530012459def8ac958f88674e1c8.1524826858.git.arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/spi/spi-mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index e8b59ce..0e55784 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -447,7 +447,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
 		for (i = 0; i < ms->gpio_cs_count; i++) {
 			gpio_cs = of_get_gpio(op->dev.of_node, i);
-			if (gpio_cs < 0) {
+			if (!gpio_is_valid(gpio_cs)) {
 				dev_err(&op->dev,
 					"could not parse the gpio field in oftree\n");
 				rc = -ENODEV;
-- 
1.9.1
