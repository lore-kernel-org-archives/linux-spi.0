From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2 2/6] spi/bcm63xx: always use a fixed number of CS
Date: Sat, 12 Sep 2015 18:06:59 +0200
Message-ID: <1442074023-29840-3-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442074023-29840-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We always pass 8 for the number of chip selects, so we can as well
hardcode it to this number.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
v1 -> v2
 * remove the platform_data member as well.

 arch/mips/bcm63xx/dev-spi.c                          | 1 -
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h | 1 -
 drivers/spi/spi-bcm63xx.c                            | 4 +++-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index ad448e4..438df08 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -55,7 +55,6 @@ static struct resource spi_resources[] = {
 
 static struct bcm63xx_spi_pdata spi_pdata = {
 	.bus_num		= 0,
-	.num_chipselect		= 8,
 };
 
 static struct platform_device bcm63xx_spi_device = {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 2573765..40dab9d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -12,7 +12,6 @@ struct bcm63xx_spi_pdata {
 	unsigned int	msg_type_shift;
 	unsigned int	msg_ctl_width;
 	int		bus_num;
-	int		num_chipselect;
 };
 
 enum bcm63xx_regs_spi {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 2b908db..a997c64 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -31,6 +31,8 @@
 
 #define BCM63XX_SPI_MAX_PREPEND		15
 
+#define BCM63XX_SPI_MAX_CS		8
+
 struct bcm63xx_spi {
 	struct completion	done;
 
@@ -368,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->num_chipselect;
+	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
