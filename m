From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] spi: rockchip: Keep master alive when CS asserted
Date: Mon, 26 Jun 2017 11:10:06 +0800
Message-ID: <1498446606-5529-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The cros_ec requires CS line to be active after last message. But the CS
would be toggled when powering off/on rockchip spi, which breaks ec xfer.

Keep spi alive after CS asserted to prevent that.

Suggested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

 drivers/spi/spi-rockchip.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index acf31f3..df016a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -264,7 +264,7 @@ static inline u32 rx_max(struct rockchip_spi *rs)
 
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	u32 ser;
+	u32 ser, new_ser;
 	struct spi_master *master = spi->master;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
@@ -288,13 +288,25 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
 	 */
 	if (!enable)
-		ser |= 1 << spi->chip_select;
+		new_ser = ser | BIT(spi->chip_select);
 	else
-		ser &= ~(1 << spi->chip_select);
+		new_ser = ser & ~BIT(spi->chip_select);
 
-	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+	if (new_ser == ser)
+		goto out;
 
-	pm_runtime_put_sync(rs->dev);
+	writel_relaxed(new_ser, rs->regs + ROCKCHIP_SPI_SER);
+
+	/*
+	 * The rockchip spi would stop driving CS when power down.
+	 * So we need to keep it alive after CS asserted
+	 */
+	if (!enable)
+		return;
+	pm_runtime_put(rs->dev);
+
+out:
+	pm_runtime_put(rs->dev);
 }
 
 static int rockchip_spi_prepare_message(struct spi_master *master,
-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
