From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 11/17] spi/topcliff-pch: Use kcalloc() in pch_spi_handle_dma()
Date: Fri, 13 Jan 2017 18:20:52 +0100
Message-ID: <5c46b68f-192e-2982-6a0e-2017da26f83d@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 15:25:22 +0100

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index fcb991034c3d..0488b7c7cc19 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1008,7 +1008,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	/* RX */
-	dma->sg_rx_p = kzalloc(sizeof(struct scatterlist)*num, GFP_ATOMIC);
+	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_ATOMIC);
 	sg_init_table(dma->sg_rx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_rx_p;
@@ -1068,7 +1068,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		head = 0;
 	}
 
-	dma->sg_tx_p = kzalloc(sizeof(struct scatterlist)*num, GFP_ATOMIC);
+	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_ATOMIC);
 	sg_init_table(dma->sg_tx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_tx_p;
-- 
2.11.0
