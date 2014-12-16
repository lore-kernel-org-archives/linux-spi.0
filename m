From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH] spi: qup: Add SPI_CPOL configuration support
Date: Tue, 16 Dec 2014 12:21:55 +0200
Message-ID: <1418725315-25621-1-git-send-email-iivanov@mm-sol.com>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Device support SPI_CPOL, but driver have missed to add
support for this configuration.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/spi/spi-qup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 390ed71..1c3329c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -337,7 +337,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct spi_qup *controller = spi_master_get_devdata(spi->master);
-	u32 config, iomode, mode;
+	u32 config, iomode, mode, control;
 	int ret, n_words, w_size;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
@@ -392,6 +392,15 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 
 	writel_relaxed(iomode, controller->base + QUP_IO_M_MODES);
 
+	control = readl_relaxed(controller->base + SPI_IO_CONTROL);
+
+	if (spi->mode & SPI_CPOL)
+		control |= SPI_IO_C_CLK_IDLE_HIGH;
+	else
+		control &= ~SPI_IO_C_CLK_IDLE_HIGH;
+
+	writel_relaxed(control, controller->base + SPI_IO_CONTROL);
+
 	config = readl_relaxed(controller->base + SPI_CONFIG);
 
 	if (spi->mode & SPI_LOOP)
-- 
1.9.1
