From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 1/2] spi: rockchip: Set GPIO_SS flag to enable Slave Select with GPIO CS
Date: Wed, 28 Jun 2017 12:38:42 +0800
Message-ID: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The rockchip spi still requires slave selection when using GPIO CS.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index bab9b13..52ea160 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -749,6 +749,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(rs->dma_tx.ch)) {
-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
