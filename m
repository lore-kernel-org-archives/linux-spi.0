From: Boojin Kim <boojin.kim@samsung.com>
Subject: [PATCH v2 3/4] spi: s3c64xx: add dma maxburst size initialization
Date: Fri, 22 Feb 2013 17:09:18 +0900
Message-ID: <001b01ce10d3$e9f78620$bde69260$%kim@samsung.com>
Cc: 'Vinod Koul' <vinod.koul@intel.com>, 'Dan Williams' <djbw@fb.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Mark Brown' <broonie@opensource.wolfsonmicro.com>,
	'Rob Herring' <rob.herring@calxeda.com>,
	'Sangbeom Kim' <sbkim73@samsung.com>
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	alsa-devel@alsa-project.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds dma maxburst size initialization.
The maxburst should be set by MODE_CFGn.DMA_TYPE,
because the pl330 dma driver supports burst mode.

Signed-off-by: Hyeonkook Kim <hk619.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e862ab8..5e6cafe 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -287,10 +287,20 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	struct s3c64xx_spi_driver_data *sdd;
 	struct samsung_dma_prep info;
 	struct samsung_dma_config config;
+	void __iomem *regs;
+	unsigned int mode_cfg;

 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
+
+		regs = sdd->regs;
+		mode_cfg = readl(regs + S3C64XX_SPI_MODE_CFG);
+		if (mode_cfg & S3C64XX_SPI_MODE_4BURST)
+			config.maxburst = 4;
+		else
+			config.maxburst = 1;
+
 		config.direction = sdd->rx_dma.direction;
 		config.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 		config.width = sdd->cur_bpw / 8;
@@ -298,6 +308,14 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
+
+		regs = sdd->regs;
+		mode_cfg = readl(regs + S3C64XX_SPI_MODE_CFG);
+		if (mode_cfg & S3C64XX_SPI_MODE_4BURST)
+			config.maxburst = 4;
+		else
+			config.maxburst = 1;
+
 		config.direction =  sdd->tx_dma.direction;
 		config.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
 		config.width = sdd->cur_bpw / 8;
--
1.7.5.4
