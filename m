From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2 3/6] spi/bcm63xx: hardcode busnum to 0
Date: Sat, 12 Sep 2015 18:07:00 +0200
Message-ID: <1442074023-29840-4-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442074023-29840-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We always pass 0 as the spi bus number, so we might as well hard code
it.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
v1 -> v2
 * remove the platform data member as well.

 arch/mips/bcm63xx/dev-spi.c                          | 4 +---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h | 1 -
 drivers/spi/spi-bcm63xx.c                            | 3 ++-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 438df08..b475bc1 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -53,9 +53,7 @@ static struct resource spi_resources[] = {
 	},
 };
 
-static struct bcm63xx_spi_pdata spi_pdata = {
-	.bus_num		= 0,
-};
+static struct bcm63xx_spi_pdata spi_pdata;
 
 static struct platform_device bcm63xx_spi_device = {
 	.name		= "bcm63xx-spi",
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 40dab9d..07c6098 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -11,7 +11,6 @@ struct bcm63xx_spi_pdata {
 	unsigned int	fifo_size;
 	unsigned int	msg_type_shift;
 	unsigned int	msg_ctl_width;
-	int		bus_num;
 };
 
 enum bcm63xx_regs_spi {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index a997c64..c1364a8 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -32,6 +32,7 @@
 #define BCM63XX_SPI_MAX_PREPEND		15
 
 #define BCM63XX_SPI_MAX_CS		8
+#define BCM63XX_SPI_BUS_NUM		0
 
 struct bcm63xx_spi {
 	struct completion	done;
@@ -369,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = pdata->bus_num;
+	master->bus_num = BCM63XX_SPI_BUS_NUM;
 	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
