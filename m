From: Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 2/2] spi/rockchip: remove unnecessary memset of rockchip_spi
Date: Tue, 30 Jun 2015 21:04:07 +0300
Message-ID: <1435687447.27701.13.camel@ceres>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, klimov.linux@gmail.com,
	addy.ke@rock-chips.com, linux-rockchip@lists.infradead.org
To: linux-spi@vger.kernel.org, broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Memory for struct rockchip_spi is allocated by spi_alloc_master()
using kzalloc() so it doesn't need to be set to 0 one more time.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
 drivers/spi/spi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 68e7efe..79a8bc4 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -645,7 +645,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	rs = spi_master_get_devdata(master);
-	memset(rs, 0, sizeof(struct rockchip_spi));
 
 	/* Get basic io resource and map it */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.9.1
