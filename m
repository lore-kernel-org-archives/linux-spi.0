From: Ben Whitten <ben.whitten@gmail.com>
Subject: [PATCH] spi: spidev: Add sx1301 to device tree compatibility list
Date: Thu, 16 Mar 2017 11:00:30 +0000
Message-ID: <1489662030-11567-1-git-send-email-ben.whitten@lairdtech.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add entry for the semtech sx1301 baseband processor implementing a LoRa
concentrator IP.
At this time this chip requires an spidev userspace driver.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
Signed-off-by: Steve deRosier <derosier@gmail.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099..9a2a79a 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -697,6 +697,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
+	{ .compatible = "semtech,sx1301" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.7.4
