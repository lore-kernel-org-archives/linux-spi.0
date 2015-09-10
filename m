From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 4/6] spi/bcm63xx: replace custom io accessors with standard ones
Date: Thu, 10 Sep 2015 16:11:42 +0200
Message-ID: <1441894304-22316-5-git-send-email-jogo@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Replace all bcm_read* with (io)read. Due to this block following
system endianness, make sure we match that.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index c1364a8..ef05387 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -56,25 +56,33 @@ struct bcm63xx_spi {
 static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
-	return bcm_readb(bs->regs + bcm63xx_spireg(offset));
+	return readb(bs->regs + bcm63xx_spireg(offset));
 }
 
 static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
-	return bcm_readw(bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_BIG_ENDIAN
+	return ioread16(bs->regs + bcm63xx_spireg(offset));
+#else
+	return readw(bs->regs + bcm63xx_spireg(offset));
+#endif
 }
 
 static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
 				  u8 value, unsigned int offset)
 {
-	bcm_writeb(value, bs->regs + bcm63xx_spireg(offset));
+	writeb(value, bs->regs + bcm63xx_spireg(offset));
 }
 
 static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 				  u16 value, unsigned int offset)
 {
-	bcm_writew(value, bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_BIG_ENDIAN
+	iowrite16(value, bs->regs + bcm63xx_spireg(offset));
+#else
+	writew(value, bs->regs + bcm63xx_spireg(offset));
+#endif
 }
 
 static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
