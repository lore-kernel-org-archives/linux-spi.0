From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: dw: use relaxed IO accessor
Date: Mon, 19 Sep 2016 17:00:41 +0800
Message-ID: <20160919090041.4024-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Using the __raw functions is discouraged.  Update the driver to use the
relaxed functions.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-dw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 61bc3cb..2cfdc4d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -143,22 +143,22 @@ struct dw_spi {
 
 static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
 {
-	return __raw_readl(dws->regs + offset);
+	return readl_relaxed(dws->regs + offset);
 }
 
 static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
 {
-	return __raw_readw(dws->regs + offset);
+	return readw_relaxed(dws->regs + offset);
 }
 
 static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 {
-	__raw_writel(val, dws->regs + offset);
+	writel_relaxed(val, dws->regs + offset);
 }
 
 static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
 {
-	__raw_writew(val, dws->regs + offset);
+	writew_relaxed(val, dws->regs + offset);
 }
 
 static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
