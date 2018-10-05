From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}
Date: Fri,  5 Oct 2018 12:25:09 -0700
Message-ID: <20181005192508.18659-1-natechancellor@gmail.com>
References: <20181004024010.15986-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004024010.15986-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expect an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Convert the driver to
use dma_data_direction for these two functions.

There are two places that strictly require an enum of type
dma_transfer_direction: the direction member in struct dma_slave_config
and the direction parameter in dmaengine_prep_slave_sg. To avoid using
an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
to safely map between the two types because they are not 1 to 1 in
meaning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix escaped hash symbols for '#define' lines (\# -> #)

v2 -> v3:

* Instead of changing the dir parameter in the prepare and finish
  functions, convert the driver to use dma_data_direction for everywhere
  that makes sense. Add a helper function to convert between the two
  types as there is still a couple of locations that need a transfer
  enum (and no such function exists). Alternatively, the function could
  just convert from transfer -> data and be used in dma_{,un}map_sg and
  the rest of the driver be left alone. Hopefully I understood what Mika
  wanted!

 drivers/spi/spi-ep93xx.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..667da7964d63 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
 	return -EINPROGRESS;
 }
 
+static enum dma_transfer_direction
+ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return DMA_MEM_TO_DEV;
+	case DMA_FROM_DEVICE:
+		return DMA_DEV_TO_MEM;
+	default:
+		return DMA_TRANS_NONE;
+	}
+}
+
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  */
 static struct dma_async_tx_descriptor *
 ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+		       enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = dir;
+	conf.direction = ep93xx_dma_data_to_trans_dir(dir);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
@@ -343,7 +356,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
-	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
+	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents,
+				      ep93xx_dma_data_to_trans_dir(dir),
+				      DMA_CTRL_ACK);
 	if (!txd) {
 		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
@@ -360,13 +375,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * unmapped.
  */
 static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+				  enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		sgt = &espi->rx_sgt;
 	} else {
@@ -381,8 +396,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 {
 	struct spi_master *master = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 
 	spi_finalize_current_transfer(master);
 }
@@ -392,15 +407,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}
-- 
2.19.0
