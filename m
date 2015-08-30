From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 2/2 v2] spi: spi-ep93xx: fix PTR_ERR problem
Date: Sun, 30 Aug 2015 22:10:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1508302209040.2062@localhost6.localdomain6>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr> <1440957911-7687-3-git-send-email-Julia.Lawall@lip6.fr> <55E34C0E.5000702@bfs.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: walter harms <wharms@bfs.de>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <55E34C0E.5000702@bfs.de>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Move initialization of msg->status up over the call to dev_err, in both
calls to ep93xx_spi_dma_prepare, and change the reference in the call to
dev_err to msg->status, to both fix the wrong argument to PTR_ERR in the
second case and to make the dev_err line a little shorter.  This required
furthermore replacing %ld by %d, since msg->status is an integer.

The semantic match that finds the PTR_ERR problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
@@

if (IS_ERR(x) || ...) {
  ... when any
      when != IS_ERR(...)
(
   PTR_ERR(x)
|
*  PTR_ERR(y)
)
  ... when any
}
// </smpl>

Reorganizations at the suggestion of Walter Harms.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: Reorganize the code, to solve the problem in a way that makes the
resulting code simpler.

 drivers/spi/spi-ep93xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index bb00be8..73d0df6 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -559,16 +559,16 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
 
 	rxd = ep93xx_spi_dma_prepare(espi, DMA_DEV_TO_MEM);
 	if (IS_ERR(rxd)) {
-		dev_err(&espi->pdev->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		msg->status = PTR_ERR(rxd);
+		dev_err(&espi->pdev->dev, "DMA RX failed: %d\n", msg->status);
 		return;
 	}
 
 	txd = ep93xx_spi_dma_prepare(espi, DMA_MEM_TO_DEV);
 	if (IS_ERR(txd)) {
 		ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
-		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(rxd));
 		msg->status = PTR_ERR(txd);
+		dev_err(&espi->pdev->dev, "DMA TX failed: %d\n", msg->status);
 		return;
 	}
 
