From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: npcm-pspi: modify reset support" to the spi tree
Date: Fri, 17 Jan 2020 15:44:23 +0000 (GMT)
Message-ID: <applied-20200115162301.235926-5-tmaimon77@gmail.com>
References: <20200115162301.235926-5-tmaimon77@gmail.com>
Cc: avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
To: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200115162301.235926-5-tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: npcm-pspi: modify reset support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From b5df0b2ee2ee6b5bdeb55d76c17f695a1aa5388f Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 15 Jan 2020 18:23:01 +0200
Subject: [PATCH] spi: npcm-pspi: modify reset support

Modify NPCM perphiral SPI reset support from
direct register access to reset controller support.

Signed-off-by: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Link: https://lore.kernel.org/r/20200115162301.235926-5-tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-npcm-pspi.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index d224aa63dbce..7e9e747b5626 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -12,6 +12,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/reset.h>
 
 #include <asm/unaligned.h>
 
@@ -20,7 +21,7 @@
 
 struct npcm_pspi {
 	struct completion xfer_done;
-	struct regmap *rst_regmap;
+	struct reset_control *reset;
 	struct spi_master *master;
 	unsigned int tx_bytes;
 	unsigned int rx_bytes;
@@ -59,12 +60,6 @@ struct npcm_pspi {
 #define NPCM_PSPI_MIN_CLK_DIVIDER	4
 #define NPCM_PSPI_DEFAULT_CLK		25000000
 
-/* reset register */
-#define NPCM7XX_IPSRST2_OFFSET	0x24
-
-#define NPCM7XX_PSPI1_RESET	BIT(22)
-#define NPCM7XX_PSPI2_RESET	BIT(23)
-
 static inline unsigned int bytes_per_word(unsigned int bits)
 {
 	return bits <= 8 ? 1 : 2;
@@ -292,9 +287,9 @@ static int npcm_pspi_unprepare_transfer_hardware(struct spi_master *master)
 
 static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
 {
-	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET,
-		     NPCM7XX_PSPI1_RESET << priv->id);
-	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET, 0x0);
+	reset_control_assert(priv->reset);
+	udelay(5);
+	reset_control_deassert(priv->reset);
 }
 
 static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
@@ -358,10 +353,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	if (num_cs < 0)
 		return num_cs;
 
-	pdev->id = of_alias_get_id(np, "spi");
-	if (pdev->id < 0)
-		pdev->id = 0;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
 	if (!master)
 		return -ENOMEM;
@@ -371,7 +362,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	priv = spi_master_get_devdata(master);
 	priv->master = master;
 	priv->is_save_param = false;
-	priv->id = pdev->id;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
@@ -396,11 +386,10 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 		goto out_disable_clk;
 	}
 
-	priv->rst_regmap =
-		syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
-	if (IS_ERR(priv->rst_regmap)) {
-		dev_err(&pdev->dev, "failed to find nuvoton,npcm750-rst\n");
-		return PTR_ERR(priv->rst_regmap);
+	priv->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		goto out_disable_clk;
 	}
 
 	/* reset SPI-HW block */
@@ -421,7 +410,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	master->min_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MAX_CLK_DIVIDER);
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
+	master->bus_num = -1;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->transfer_one = npcm_pspi_transfer_one;
 	master->prepare_transfer_hardware =
@@ -454,7 +443,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk;
 
-	pr_info("NPCM Peripheral SPI %d probed\n", pdev->id);
+	pr_info("NPCM Peripheral SPI %d probed\n", master->bus_num);
 
 	return 0;
 
-- 
2.20.1
