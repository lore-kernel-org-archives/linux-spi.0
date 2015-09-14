From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: replace custom io accessors with standard ones" to the spi tree
Date: Mon, 14 Sep 2015 19:54:27 +0100
Message-ID: <E1ZbYtX-0002JQ-V0@finisterre>
References: <1441894304-22316-5-git-send-email-jogo@openwrt.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-5-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: replace custom io accessors with standard ones

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 158fcc4e050a75b609bbef1007cf7bf2a01ca043 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Date: Thu, 10 Sep 2015 16:11:42 +0200
Subject: [PATCH] spi/bcm63xx: replace custom io accessors with standard ones

Replace all bcm_read* with (io)read. Due to this block following
system endianness, make sure we match that.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
