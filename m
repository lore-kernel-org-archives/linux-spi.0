From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: fix standard accessors and compile guard" to the spi tree
Date: Mon, 12 Oct 2015 17:59:35 +0100
Message-ID: <E1ZlgRj-00052q-22@finisterre>
References: <1444645463-20915-2-git-send-email-jogo@openwrt.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444645463-20915-2-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: fix standard accessors and compile guard

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

>From 682b5280bf00c0618606ecb26cf4a9342d5e282e Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Date: Mon, 12 Oct 2015 12:24:21 +0200
Subject: [PATCH] spi/bcm63xx: fix standard accessors and compile guard

Use the correct guard CONFIG_CPU_BIG_ENDIAN and the *be accessors to
follow native endianness on big endian systems.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
