From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: [PATCH] spi: spidev: Add dhcom-board to compatibility list [Klartext]
Date: Thu, 16 May 2019 13:14:50 +0200
Message-ID: <20190516111450.6730-1-cniedermaier@dh-electronics.com>
Cc: linux-kernel@vger.kernel.org, cniedermaier@dh-electronics.com
To: broonie@kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Prepare to use devices on the external SPI interface
on a DH electronics Development Board.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b0c76e2626ce..61ec1dce557f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -670,6 +670,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
+	{ .compatible = "dh,dhcom-board" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.11.0
