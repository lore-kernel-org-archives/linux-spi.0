From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: xtensa-xtfpga: fix register endianness
Date: Tue, 22 Sep 2015 14:32:03 +0300
Message-ID: <1442921523-1265-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

XTFPGA SPI controller has native endian registers.
Fix register acessors so that they work in big-endian configurations.

Signed-off-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-xtensa-xtfpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 2e32ea2..be6155c 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -34,13 +34,13 @@ struct xtfpga_spi {
 static inline void xtfpga_spi_write32(const struct xtfpga_spi *spi,
 				      unsigned addr, u32 val)
 {
-	iowrite32(val, spi->regs + addr);
+	__raw_writel(val, spi->regs + addr);
 }
 
 static inline unsigned int xtfpga_spi_read32(const struct xtfpga_spi *spi,
 					     unsigned addr)
 {
-	return ioread32(spi->regs + addr);
+	return __raw_readl(spi->regs + addr);
 }
 
 static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
