From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2 4/6] spi/bcm63xx: replace custom io accessors with standard ones
Date: Sat, 12 Sep 2015 18:07:01 +0200
Message-ID: <1442074023-29840-5-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442074023-29840-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Replace all bcm_read* with (io)read. Due to this block following
system endianness, make sure we match that.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
v1 -> v2:
 * Use the right guard and io*be.

 drivers/spi/spi-bcm63xx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index c1364a8..461891f 100644
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
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	return ioread16be(bs->regs + bcm63xx_spireg(offset));
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
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	iowrite16be(value, bs->regs + bcm63xx_spireg(offset));
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
