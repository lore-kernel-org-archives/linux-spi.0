From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 5/7] spi: rockchip: mark use_dma as bool
Date: Wed, 10 Oct 2018 11:00:36 +0200
Message-ID: <20181010090038.20834-6-kernel@esmil.dk>
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

The driver data has a u32 field use_dma which is
only ever used as a boolean, so change its type
to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 85358f96f78f..1d8bf45304a5 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -202,7 +202,7 @@ struct rockchip_spi {
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
-	u32 use_dma;
+	bool use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
@@ -631,9 +631,9 @@ static int rockchip_spi_transfer_one(
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = 1;
+		rs->use_dma = true;
 	else
-		rs->use_dma = 0;
+		rs->use_dma = false;
 
 	rockchip_spi_config(rs);
 
-- 
2.19.1
