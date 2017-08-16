From: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] spi: rockchip: configure CTRLR1 according to size and data frame
Date: Wed, 16 Aug 2017 10:12:02 +0800
Message-ID: <1502849522-10073-1-git-send-email-huibin.hong@rock-chips.com>
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

CTRLR1 is number of data frames, when rx only.
When data frame is 8 bit, CTRLR1 is len-1.
When data frame is 16 bit, CTRLR1 is (len/2)-1.

Signed-off-by: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/spi/spi-rockchip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b..6b1bac8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -568,7 +568,13 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
-	writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	if (rs->n_bytes == 1)
+		writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else if (rs->n_bytes == 2)
+		writel_relaxed((rs->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else
+		writel_relaxed((rs->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
