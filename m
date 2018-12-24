From: cezary.gapinski@gmail.com
Subject: [PATCH v2 10/14] spi: stm32: add start dma transfer function
Date: Mon, 24 Dec 2018 23:00:36 +0100
Message-ID: <1545688840-23992-11-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add transfer_one_dma_start function to be more generic for other
stm32 SPI family drivers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index bc8513f..b19d02b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -748,6 +748,23 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
+ * stm32_spi_transfer_one_dma_start - Set SPI driver registers to start transfer
+ *				      using DMA
+ */
+static void stm32_spi_transfer_one_dma_start(struct stm32_spi *spi)
+{
+	/* Enable the interrupts relative to the end of transfer */
+	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
+						 STM32H7_SPI_IER_TXTFIE |
+						 STM32H7_SPI_IER_OVRIE |
+						 STM32H7_SPI_IER_MODFIE);
+
+	stm32_spi_enable(spi);
+
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+}
+
+/**
  * stm32_spi_transfer_one_dma - transfer a single spi_transfer using DMA
  *
  * It must returns 0 if the transfer is finished or 1 if the transfer is still
@@ -759,7 +776,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	struct dma_slave_config tx_dma_conf, rx_dma_conf;
 	struct dma_async_tx_descriptor *tx_dma_desc, *rx_dma_desc;
 	unsigned long flags;
-	u32 ier = 0;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -829,14 +845,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 				   STM32H7_SPI_CFG1_TXDMAEN);
 	}
 
-	/* Enable the interrupts relative to the end of transfer */
-	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
-	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
-	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
-
-	stm32_spi_enable(spi);
-
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+	stm32_spi_transfer_one_dma_start(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-- 
2.7.4
