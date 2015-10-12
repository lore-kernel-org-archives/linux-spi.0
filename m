From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V3 1/3] spi/bcm63xx: fix standard accessors and compile guard
Date: Mon, 12 Oct 2015 12:24:21 +0200
Message-ID: <1444645463-20915-2-git-send-email-jogo@openwrt.org>
References: <1444645463-20915-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444645463-20915-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the correct guard CONFIG_CPU_BIG_ENDIAN and the *be accessors to
follow native endianness on big endian systems.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
v2 -> v3:
 * Squash in revert of applied v1.
v1 -> v2:
 * Use the right guard and io*be.

 drivers/spi/spi-bcm63xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index ef05387..461891f 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -62,8 +62,8 @@ static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
 static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
-#ifdef CONFIG_BIG_ENDIAN
-	return ioread16(bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	return ioread16be(bs->regs + bcm63xx_spireg(offset));
 #else
 	return readw(bs->regs + bcm63xx_spireg(offset));
 #endif
@@ -78,8 +78,8 @@ static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
 static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 				  u16 value, unsigned int offset)
 {
-#ifdef CONFIG_BIG_ENDIAN
-	iowrite16(value, bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	iowrite16be(value, bs->regs + bcm63xx_spireg(offset));
 #else
 	writew(value, bs->regs + bcm63xx_spireg(offset));
 #endif
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
