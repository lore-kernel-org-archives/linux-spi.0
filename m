From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v5 08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
Date: Wed, 18 Mar 2020 02:15:59 +0200
Message-ID: <20200318001603.9650-9-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Interrupts are not necessary for DMA functionality, since the completion
event is provided by the DMA driver.

But if the driver fails to request the IRQ defined in the device tree,
it will call dspi_poll which would make the driver hang waiting for data
to become available in the RX FIFO.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 81e22b6eadc7..fcc6f20b6631 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -965,13 +965,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
-			wait_for_completion(&dspi->xfer_done);
-			reinit_completion(&dspi->xfer_done);
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (dspi->irq) {
+				wait_for_completion(&dspi->xfer_done);
+				reinit_completion(&dspi->xfer_done);
+			} else {
+				do {
+					status = dspi_poll(dspi);
+				} while (status == -EINPROGRESS);
+			}
 		}
 
 		spi_transfer_delay_exec(transfer);
-- 
2.17.1
