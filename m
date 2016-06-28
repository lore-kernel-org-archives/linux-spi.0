From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2 1/5] spi: s3c64xx: group the CS signalling writes in a
 single function
Date: Tue, 28 Jun 2016 11:41:11 +0900
Message-ID: <1467081676-8442-2-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Shyti <andi.shyti@samsung.com>, linux-spi@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

To enable/disable the CS line, the driver performs a writel in
the S3C64XX_SPI_SLAVE_SEL registers. Group the register's
configuration in a single function.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a76a50..972367d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -310,6 +310,28 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	dma_async_issue_pending(dma->ch);
 }
 
+static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct s3c64xx_spi_driver_data *sdd =
+					spi_master_get_devdata(spi->master);
+
+	if (enable) {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
+			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		} else {
+			u32 ssel = readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+
+			ssel |= (S3C64XX_SPI_SLAVE_AUTO |
+						S3C64XX_SPI_SLAVE_NSC_CNT_2);
+			writel(ssel, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		}
+	} else {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT,
+		sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	}
+}
+
 static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
@@ -706,12 +728,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	enable_datapath(sdd, spi, xfer, use_dma);
 
 	/* Start the signals */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-	else
-		writel(readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL)
-			| S3C64XX_SPI_SLAVE_AUTO | S3C64XX_SPI_SLAVE_NSC_CNT_2,
-			sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, true);
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
@@ -861,16 +878,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
+
 	return 0;
 
 setup_exit:
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
 
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
-- 
2.8.1
