From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/8] spi: sh-msiof: Add sleep before master transfer for test
Date: Wed, 6 Sep 2017 09:05:00 +0200
Message-ID: <20170906070507.26223-2-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-renesas-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

This patch is for debug of transfer between master and slave.
Since the slave needs to complete a preparation in data transfer
before the master working, the sleep wait is put before
the data transfer of the master.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/spi/Kconfig        | 20 ++++++++++++++++++++
 drivers/spi/spi-sh-msiof.c | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2cf780..0139ecf8f42e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -600,6 +600,26 @@ config SPI_SH_MSIOF
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
+config SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG
+	bool "Transfer Synchronization Debug support for MSIOF"
+	depends on SPI_SH_MSIOF
+	default n
+	help
+	  In data transfer, the slave needs to have completed
+	  a transfer preparation before the master.
+	  As a test environment, it was to be able to put a sleep wait
+	  before the data transfer of the master.
+
+config SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG_MSLEEP
+	int "Master of sleep latency (msec time)"
+	default 1
+	depends on SPI_SH_MSIOF && SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG
+	help
+	  Select Sleep latency of the previous data transfer
+	  at the time of master mode.
+	  Examples:
+	    N => N msec
+
 config SPI_SH
 	tristate "SuperH SPI controller"
 	depends on SUPERH || COMPILE_TEST
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0eb1e9583485..2b4d3a520176 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -41,6 +41,10 @@ struct sh_msiof_chipdata {
 	u16 min_div;
 };
 
+#ifdef CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG
+#define TRANSFAR_SYNC_DELAY (CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG_MSLEEP)
+#endif /* CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG */
+
 struct sh_msiof_spi_priv {
 	struct spi_master *master;
 	void __iomem *mapbase;
@@ -910,6 +914,11 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 		if (tx_buf)
 			copy32(p->tx_dma_page, tx_buf, l / 4);
 
+#ifdef CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG
+		if (p->mode == SPI_MSIOF_MASTER)
+			msleep(TRANSFAR_SYNC_DELAY);
+#endif /* CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG */
+
 		ret = sh_msiof_dma_once(p, tx_buf, rx_buf, l);
 		if (ret == -EAGAIN) {
 			pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
@@ -983,6 +992,12 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	words = len / bytes_per_word;
 
 	while (words > 0) {
+
+#ifdef CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG
+		if (p->mode == SPI_MSIOF_MASTER)
+			msleep(TRANSFAR_SYNC_DELAY);
+#endif /* CONFIG_SPI_SH_MSIOF_TRANSFER_SYNC_DEBUG */
+
 		n = sh_msiof_spi_txrx_once(p, tx_fifo, rx_fifo, tx_buf, rx_buf,
 					   words, bits);
 		if (n < 0)
-- 
2.14.1
