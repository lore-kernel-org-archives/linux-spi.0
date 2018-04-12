From: wangbo <wdjjwb@163.com>
Subject: [PATCH] spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"
Date: Thu, 12 Apr 2018 16:58:08 +0800
Message-ID: <1523523488-22034-1-git-send-email-wdjjwb@163.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        wang.bo116@zte.com.cn
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Now i.MX SPI controller can work in Slave mode.
Update MODULE_DESCRIPTION to "SPI Controller driver".

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f57592..a056ee8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1701,7 +1701,7 @@ static struct platform_driver spi_imx_driver = {
 };
 module_platform_driver(spi_imx_driver);
 
-MODULE_DESCRIPTION("SPI Master Controller driver");
+MODULE_DESCRIPTION("SPI Controller driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.7.4
