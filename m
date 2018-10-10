From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 4/7] spi: rockchip: remove unneeded dma_caps
Date: Wed, 10 Oct 2018 11:00:35 +0200
Message-ID: <20181010090038.20834-5-kernel@esmil.dk>
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

We no longer need the dma_caps since the dma driver
already clamps the burst length to the hardware limit,
so don't request and store dma_caps in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ede3002215cd..85358f96f78f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -207,7 +207,6 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
-	struct dma_slave_caps dma_caps;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
@@ -777,7 +776,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-		dma_get_slave_caps(rs->dma_rx.ch, &(rs->dma_caps));
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
 		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-- 
2.19.1
