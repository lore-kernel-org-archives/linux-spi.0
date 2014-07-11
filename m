From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/4] spi/rockchip: call wait_for_idle() for the transfer to complete
Date: Fri, 11 Jul 2014 10:08:24 +0800
Message-ID: <1405044504-6917-1-git-send-email-addy.ke@rock-chips.com>
References: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405044389-6800-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>

Suggested-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 8c24708..09c690c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -214,6 +214,18 @@ static inline void flush_fifo(struct rockchip_spi *rs)
 		readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
 }
 
+static inline void wait_for_idle(struct rockchip_spi *rs)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5);
+
+	do {
+		if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
+			return;
+	} while (time_before(jiffies, timeout));
+
+	dev_warn(rs->dev, "spi controller is in busy state!\n");
+}
+
 static u32 get_fifo_len(struct rockchip_spi *rs)
 {
 	u32 fifo;
@@ -371,6 +383,10 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 		cpu_relax();
 	} while (remain);
 
+	/* If tx, wait until the FIFO data completely. */
+	if (rs->tx)
+		wait_for_idle(rs);
+
 	return 0;
 }
 
@@ -393,6 +409,9 @@ static void rockchip_spi_dma_txcb(void *data)
 	unsigned long flags;
 	struct rockchip_spi *rs = data;
 
+	/* Wait until the FIFO data completely. */
+	wait_for_idle(rs);
+
 	spin_lock_irqsave(&rs->lock, flags);
 
 	rs->state &= ~TXBUSY;
@@ -536,11 +555,6 @@ static int rockchip_spi_transfer_one(
 	rs->tx_sg = xfer->tx_sg;
 	rs->rx_sg = xfer->rx_sg;
 
-	/* Delay until the FIFO data completely */
-	if (xfer->tx_buf)
-		xfer->delay_usecs
-			= rs->fifo_len * rs->bpw * 1000000 / rs->speed;
-
 	if (rs->tx && rs->rx)
 		rs->tmode = CR0_XFM_TR;
 	else if (rs->tx)
-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
