From: Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH 3/4] spi: davinci: change the lower limit of pre-scale divider to 1
Date: Wed, 10 Jun 2015 03:18:25 -0400
Message-ID: <1433920705-13068-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Murali Karicheri <m-karicheri2@ti.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI hardware spec for Keystone specifies a lower value of 0 for pre-scale
divider that is used for generating spi clock which translates to a
clock divider of 2. So fix the lower limit to allow using a higher SPI
clock.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 5e99106..987afeb 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -265,7 +265,7 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 
 	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
 
-	if (ret < 3 || ret > 256)
+	if (ret < 1 || ret > 256)
 		return -EINVAL;
 
 	return ret - 1;
-- 
1.9.1
