From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
Date: Sun, 15 Mar 2020 00:43:36 +0200
Message-ID: <20200314224340.1544-9-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200314224340.1544-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

Interrupts are not necessary for DMA functionality, since the completion
event is provided by the DMA driver.

But if the driver fails to request the IRQ defined in the device tree,
it will call dspi_poll which would make the driver hang waiting for data
to become available in the RX FIFO.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8aef5690c5d..eab4929330e1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -974,13 +974,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
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
