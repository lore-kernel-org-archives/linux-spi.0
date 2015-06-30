From: Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 1/2] spi/s3c24xx: remove unnecessary memset of s3c24xx_spi
Date: Tue, 30 Jun 2015 21:03:58 +0300
Message-ID: <1435687438.27701.12.camel@ceres>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, klimov.linux@gmail.com,
	addy.ke@rock-chips.com, linux-rockchip@lists.infradead.org
To: linux-spi@vger.kernel.org, broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Memory for this struct is allocated by spi_alloc_master() using
kzalloc() so it doesn't need to be set to 0 one more time.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
 drivers/spi/spi-s3c24xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index f747ca2..f36bc32 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -501,7 +501,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	}
 
 	hw = spi_master_get_devdata(master);
-	memset(hw, 0, sizeof(struct s3c24xx_spi));
 
 	hw->master = master;
 	hw->pdata = pdata = dev_get_platdata(&pdev->dev);
-- 
1.9.1
