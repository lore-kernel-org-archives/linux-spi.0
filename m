From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 6/7] spi: rockchip: directly use direction constants
Date: Wed, 10 Oct 2018 11:00:37 +0200
Message-ID: <20181010090038.20834-7-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The dma direction for the tx and rx dma channels never
change, so just use the constants directly rather
than storing them in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1d8bf45304a5..1044849a352d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -164,7 +164,6 @@ enum rockchip_ssi_type {
 
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
-	enum dma_transfer_direction direction;
 	dma_addr_t addr;
 };
 
@@ -454,7 +453,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = rs->dma_rx.direction;
+		rxconf.direction = DMA_DEV_TO_MEM;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
 		rxconf.src_maxburst = 1;
@@ -463,7 +462,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
-				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
 
@@ -473,7 +472,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = rs->dma_tx.direction;
+		txconf.direction = DMA_MEM_TO_DEV;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
 		txconf.dst_maxburst = rs->fifo_len / 2;
@@ -482,7 +481,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
 				rs->tx_sg.sgl, rs->tx_sg.nents,
-				rs->dma_tx.direction, DMA_PREP_INTERRUPT);
+				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
 				dmaengine_terminate_sync(rs->dma_rx.ch);
@@ -778,8 +777,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-		rs->dma_rx.direction = DMA_DEV_TO_MEM;
 
 		master->can_dma = rockchip_spi_can_dma;
 		master->dma_tx = rs->dma_tx.ch;
-- 
2.19.1
