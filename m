From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 4/7] spi: bcm53xx: Implement the spi_mem interface
Date: Thu, 26 Apr 2018 18:18:17 +0200
Message-ID: <20180426161820.2852-5-boris.brezillon@bootlin.com>
References: <20180426161820.2852-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180426161820.2852-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The spi_mem interface is meant to replace the spi_flash_read() one.
Implement the ->exec_op() method so that we can smoothly get rid of the
old interface.

Note that the current ->flash_read() implementation looks a bit fragile
since it does not take the ->read_opcode passed by the spi-nor layer
into account, which means if might not work with all kind of NORs.

Anyway, I left the logic unchanged and added a few extra checks to make
sure we're receiving something that looks like a NOR read operation.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v4:
- none

Changes in v3:
- include spi-mem.h from spi-bcm53xx.c instead of spi-bcm2835.c

Changes in v2:
- include spi-mem.h
- treat op->addr.val differently since it's now an u64
---
 drivers/spi/spi-bcm53xx.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index d02ceb7a29d1..5044e4e4a263 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/bcma/bcma.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 
 #include "spi-bcm53xx.h"
 
@@ -257,6 +258,38 @@ static int bcm53xxspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+static int bcm53xxspi_exec_mem_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	struct bcm53xxspi *b53spi = spi_master_get_devdata(mem->spi->master);
+	u32 from;
+
+	/*
+	 * FIXME: There's nothing in this driver programming the opcode and
+	 * buswidth to be used when a read is done on the mmio window, but it
+	 * seems to be used to access a SPI NOR device, so restrict access
+	 * access to SPINOR_OP_READ commands.
+	 */
+	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
+	    op->addr.nbytes != 3 || op->cmd.opcode != 0x3)
+		return -ENOTSUPP;
+
+	/* Return -ENOTSUPP so that the core can fall back to normal reads. */
+	from = op->addr.val;
+	if (from + op->data.nbytes > BCM53XXSPI_FLASH_WINDOW)
+		return -ENOTSUPP;
+
+	bcm53xxspi_enable_bspi(b53spi);
+	memcpy_fromio(op->data.buf.in, b53spi->mmio_base + from,
+		      op->data.nbytes);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops bcm53xxspi_mem_ops = {
+	.exec_op = bcm53xxspi_exec_mem_op,
+};
+
 static int bcm53xxspi_flash_read(struct spi_device *spi,
 				 struct spi_flash_read_message *msg)
 {
@@ -311,8 +344,10 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 
 	master->dev.of_node = dev->of_node;
 	master->transfer_one = bcm53xxspi_transfer_one;
-	if (b53spi->mmio_base)
+	if (b53spi->mmio_base) {
+		master->mem_ops = &bcm53xxspi_mem_ops;
 		master->spi_flash_read = bcm53xxspi_flash_read;
+	}
 
 	bcma_set_drvdata(core, b53spi);
 
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
