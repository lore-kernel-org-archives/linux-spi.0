From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 05/10] spi: Make support for regular transfers optional
 when ->mem_ops != NULL
Date: Wed, 11 Apr 2018 00:44:34 +0200
Message-ID: <20180410224439.9260-6-boris.brezillon@bootlin.com>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-1-boris.brezillon@bootlin.com>
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

Some SPI/QuadSPI controllers only expose a high-level SPI memory
interface, thus preventing any regular SPI transfers from being done.

In that case, SPI controller drivers can leave all ->transfer_xxx()
hooks empty and only implement the spi_mem_ops interface.

Adjust the core to allow such situations:
- extend spi_controller_check_ops() to accept situations where all
  ->transfer_xxx() pointers are NULL only if ->mem_ops != NULL
- make sure we do not initialize the SPI message queue if
  ctlr->transfer_one and ctlr->transfer_one_message are missing
- return -ENOTSUPP if someone tries to do a regular SPI transfer on
  a controller that does not support it

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d7e046128b3f..4961a5e91941 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -2069,12 +2070,19 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 static int spi_controller_check_ops(struct spi_controller *ctlr)
 {
 	/*
-	 * The controller must at least implement one of the ->transfer()
-	 * hooks.
+	 * The controller may implement only the high-level SPI-memory like
+	 * operations if it does not support regular SPI transfers, and this is
+	 * valid use case.
+	 * If ->mem_ops is NULL, we request that at least one of the
+	 * ->transfer_xxx() method be implemented.
 	 */
-	if (!ctlr->transfer && !ctlr->transfer_one &&
-	    !ctlr->transfer_one_message)
+	if (ctlr->mem_ops) {
+		if (!ctlr->mem_ops->exec_op)
+			return -EINVAL;
+	} else if (!ctlr->transfer && !ctlr->transfer_one &&
+		   !ctlr->transfer_one_message) {
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -2185,10 +2193,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 			spi_controller_is_slave(ctlr) ? "slave" : "master",
 			dev_name(&ctlr->dev));
 
-	/* If we're using a queued driver, start the queue */
-	if (ctlr->transfer)
+	/*
+	 * If we're using a queued driver, start the queue. Note that we don't
+	 * need the queueing logic if the driver is only supporting high-level
+	 * memory operations.
+	 */
+	if (ctlr->transfer) {
 		dev_info(dev, "controller is unqueued, this is deprecated\n");
-	else {
+	} else if (ctlr->transfer_one || ctlr->transfer_one_message) {
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
@@ -2918,6 +2930,13 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
 
+	/*
+	 * Some controllers do not support doing regular SPI transfers. Return
+	 * ENOTSUPP when this is the case.
+	 */
+	if (!ctlr->transfer)
+		return -ENOTSUPP;
+
 	message->spi = spi;
 
 	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_async);
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
