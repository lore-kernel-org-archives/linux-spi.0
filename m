From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 03/10] spi: Add an helper to flush the message queue
Date: Wed, 11 Apr 2018 00:44:32 +0200
Message-ID: <20180410224439.9260-4-boris.brezillon@bootlin.com>
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

This is needed by the spi-mem logic to force all messages that have been
queued before a memory operation to be sent before we start the memory
operation. We do that in order to guarantee that spi-mem operations do
not preempt regular SPI transfers.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
As for the spi_map/unmap_buf() I'd suggest to move the prototype
definition to an internal header file.
---
 drivers/spi/spi.c       | 16 ++++++++++++++++
 include/linux/spi/spi.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 308e4c2114d8..d7e046128b3f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1520,6 +1520,22 @@ static int spi_controller_initialize_queue(struct spi_controller *ctlr)
 	return ret;
 }
 
+/**
+ * spi_flush_queue - Send all pending messages in the queue from the callers'
+ *		     context
+ * @ctlr: controller to process queue for
+ *
+ * This should be used when one wants to ensure all pending messages have been
+ * sent before doing something. Is used by the spi-mem code to make sure SPI
+ * memory operations do not preempt regular SPI transfers that have been queued
+ * before the spi-mem operation.
+ */
+void spi_flush_queue(struct spi_controller *ctlr)
+{
+	if (ctlr->transfer == spi_queued_transfer)
+		__spi_pump_messages(ctlr, false);
+}
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OF)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index de6fd95a61c5..3489fc9c0410 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -619,6 +619,8 @@ extern int spi_controller_resume(struct spi_controller *ctlr);
  * Helpers needed by the spi-mem logic. Should not be used outside of
  * spi-mem.c
  */
+void spi_flush_queue(struct spi_controller *ctrl);
+
 #ifdef CONFIG_HAS_DMA
 int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 		struct sg_table *sgt, void *buf, size_t len,
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
