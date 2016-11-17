From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH 3/4] spi: spi-fsl-dspi: Fix continuous selection format
Date: Thu, 17 Nov 2016 17:46:50 +0530
Message-ID: <c1e51fc92dbcc9c31dcdcdfab3eed40d7745308a.1479384571.git.maitysanchayan@gmail.com>
References: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
 <cover.1479384571.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sanchayan Maity <maitysanchayan@gmail.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stefan@agner.ch,
 linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1479384571.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1479384571.git.maitysanchayan@gmail.com>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Current DMA implementation was not handling the continuous selection
format viz. SPI chip select would be deasserted even between sequential
serial transfers. Use the cs_change variable and correctly set or
reset the CONT bit accordingly for case where peripherals require
the chip select to be asserted between sequential transfers.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index aee8c88..164e2e1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -258,9 +258,16 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	}
 
 	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
-	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
-					SPI_PUSHR_PCS(dspi->cs) |
-					SPI_PUSHR_CTAS(0);
+	if (dspi->cs_change) {
+		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
+						SPI_PUSHR_PCS(dspi->cs) |
+						SPI_PUSHR_CTAS(0);
+	} else {
+		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
+						SPI_PUSHR_PCS(dspi->cs) |
+						SPI_PUSHR_CTAS(0) |
+						SPI_PUSHR_CONT;
+	}
 	dspi->tx += tx_word + 1;
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
-- 
2.10.2
