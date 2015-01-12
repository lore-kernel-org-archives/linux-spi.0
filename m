From: Ken Wilson <ken.wilson@opengear.com>
Subject: [PATCHv2 1/2] spi: orion: Change spi-orion to use transfer_one() semantics for SPI transfers
Date: Mon, 12 Jan 2015 13:13:59 +1000
Message-ID: <1421032440-15335-2-git-send-email-ken.wilson@opengear.com>
References: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	broonie@kernel.org, ezequiel.garcia@free-electrons.com,
	gerg@uclinux.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Ken Wilson <ken.wilson@opengear.com>
To: thomas.petazzoni@free-electrons.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This commit changes spi-orion to provide setup, set_cs, and transfer_one
functions instead of transfer_one_message. This allows chip select support
for both native and GPIO chip selects to be added.

Signed-off-by: Ken Wilson <ken.wilson@opengear.com>
---
 drivers/spi/spi-orion.c | 73 ++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c76b7d7..e6ac9d5 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -215,9 +215,14 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	return 0;
 }
 
-static void orion_spi_set_cs(struct orion_spi *orion_spi, int enable)
+static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	if (enable)
+	struct orion_spi *orion_spi;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	/* Chip select logic is inverted from spi_set_cs */
+	if (!enable)
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
 	else
 		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
@@ -332,64 +337,31 @@ out:
 	return xfer->len - count;
 }
 
-static int orion_spi_transfer_one_message(struct spi_master *master,
-					   struct spi_message *m)
+static int orion_spi_transfer_one(struct spi_master *master,
+					struct spi_device *spi,
+					struct spi_transfer *t)
 {
-	struct orion_spi *orion_spi = spi_master_get_devdata(master);
-	struct spi_device *spi = m->spi;
-	struct spi_transfer *t = NULL;
-	int par_override = 0;
 	int status = 0;
-	int cs_active = 0;
-
-	/* Load defaults */
-	status = orion_spi_setup_transfer(spi, NULL);
 
+	status = orion_spi_setup_transfer(spi, t);
 	if (status < 0)
-		goto msg_done;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (par_override || t->speed_hz || t->bits_per_word) {
-			par_override = 1;
-			status = orion_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-			if (!t->speed_hz && !t->bits_per_word)
-				par_override = 0;
-		}
-
-		if (!cs_active) {
-			orion_spi_set_cs(orion_spi, 1);
-			cs_active = 1;
-		}
+		return status;
 
-		if (t->len)
-			m->actual_length += orion_spi_write_read(spi, t);
+	if (t->len)
+		orion_spi_write_read(spi, t);
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-
-		if (t->cs_change) {
-			orion_spi_set_cs(orion_spi, 0);
-			cs_active = 0;
-		}
-	}
-
-msg_done:
-	if (cs_active)
-		orion_spi_set_cs(orion_spi, 0);
-
-	m->status = status;
-	spi_finalize_current_message(master);
+	return status;
+}
 
-	return 0;
+static int orion_spi_setup(struct spi_device *spi)
+{
+	return orion_spi_setup_transfer(spi, NULL);
 }
 
 static int orion_spi_reset(struct orion_spi *orion_spi)
 {
 	/* Verify that the CS is deasserted */
-	orion_spi_set_cs(orion_spi, 0);
-
+	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
 	return 0;
 }
 
@@ -442,9 +414,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	/* we support only mode 0, and no options */
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
-
-	master->transfer_one_message = orion_spi_transfer_one_message;
+	master->set_cs = orion_spi_set_cs;
+	master->transfer_one = orion_spi_transfer_one;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
+	master->setup = orion_spi_setup;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->auto_runtime_pm = true;
 
-- 
2.0.0
