From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: convert transfer word delay to spi_delay struct" to the spi tree
Date: Tue, 15 Oct 2019 12:12:27 +0100 (BST)
Message-ID: <20191015111227.F296127419E4@ypsilon.sirena.org.uk>
References: <20190926105147.7839-5-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-5-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: convert transfer word delay to spi_delay struct

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 84593a131c3af21d686d05c4b4432290a415d399 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:32 +0300
Subject: [PATCH] spi: sprd: convert transfer word delay to spi_delay struct

The Spreadtrum SPI driver is the only user of the `word_delay` field in
the `spi_transfer` struct.

This change converts the field to use the `spi_delay` struct. This also
enforces the users to specify the delay unit to be `SPI_DELAY_UNIT_SCK`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-5-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c  | 15 ++++++++++++---
 include/linux/spi/spi.h |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8c9021b7f7a9..2ee1feb41681 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -669,11 +669,15 @@ static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
 	writel_relaxed(clk_div, ss->base + SPRD_SPI_CLKD);
 }
 
-static void sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
+static int sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 {
+	struct spi_delay *d = &t->word_delay;
 	u16 word_delay, interval;
 	u32 val;
 
+	if (d->unit != SPI_DELAY_UNIT_SCK)
+		return -EINVAL;
+
 	val = readl_relaxed(ss->base + SPRD_SPI_CTL7);
 	val &= ~(SPRD_SPI_SCK_REV | SPRD_SPI_NG_TX | SPRD_SPI_NG_RX);
 	/* Set default chip selection, clock phase and clock polarity */
@@ -686,7 +690,7 @@ static void sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 	 * formula as below per datasheet:
 	 * interval time (source clock cycles) = interval * 4 + 10.
 	 */
-	word_delay = clamp_t(u16, t->word_delay, SPRD_SPI_MIN_DELAY_CYCLE,
+	word_delay = clamp_t(u16, d->value, SPRD_SPI_MIN_DELAY_CYCLE,
 			     SPRD_SPI_MAX_DELAY_CYCLE);
 	interval = DIV_ROUND_UP(word_delay - 10, 4);
 	ss->word_delay = interval * 4 + 10;
@@ -711,6 +715,8 @@ static void sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 		val &= ~SPRD_SPI_DATA_LINE2_EN;
 
 	writel_relaxed(val, ss->base + SPRD_SPI_CTL7);
+
+	return 0;
 }
 
 static int sprd_spi_setup_transfer(struct spi_device *sdev,
@@ -719,13 +725,16 @@ static int sprd_spi_setup_transfer(struct spi_device *sdev,
 	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u8 bits_per_word = t->bits_per_word;
 	u32 val, mode = 0;
+	int ret;
 
 	ss->len = t->len;
 	ss->tx_buf = t->tx_buf;
 	ss->rx_buf = t->rx_buf;
 
 	ss->hw_mode = sdev->mode;
-	sprd_spi_init_hw(ss, t);
+	ret = sprd_spi_init_hw(ss, t);
+	if (ret)
+		return ret;
 
 	/* Set tansfer speed and valid bits */
 	sprd_spi_set_speed(ss, t->speed_hz);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7670be934643..6cb67ad53ffa 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -783,7 +783,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *	the next transfer or completing this @spi_message.
  * @word_delay_usecs: microseconds to inter word delay after each word size
  *	(set by bits_per_word) transmission.
- * @word_delay: clock cycles to inter word delay after each word size
+ * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
  *      transfer this transfer. Set to 0 if the spi bus driver does
@@ -900,8 +900,8 @@ struct spi_transfer {
 	u8		word_delay_usecs;
 	u16		delay_usecs;
 	struct spi_delay	cs_change_delay;
+	struct spi_delay	word_delay;
 	u32		speed_hz;
-	u16		word_delay;
 
 	u32		effective_speed_hz;
 
-- 
2.20.1
