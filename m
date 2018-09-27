From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] spidev: Enable the Liebherr's BK4 board to work with spidev driver
Date: Fri, 28 Sep 2018 00:31:52 +0200
Message-ID: <20180927223152.24990-1-lukma@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With this commit the DSPI driver on the BK4 board can be used for SPI
transmission managed from user space (via /dev/spidev0.0).

Example usage/testing:
insmod ./spi-fsl-dspi.ko
./spidev_test -D /dev/spidev0.0 -s 3000000 -v -H -b 8 -p "\xCC\x11\x22\x74"

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index cda10719d1d1..07f4d05563ea 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -669,6 +669,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
+	{ .compatible = "lwn,bk4" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.11.0
