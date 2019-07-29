From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 2/3] spi: spi-mem: add callback function to spi-mem device
Date: Mon, 29 Jul 2019 17:25:03 +0300
Message-ID: <20190729142504.188336-3-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Tomer Maimon <tmaimon77@gmail.com>, linux-spi@vger.kernel.org
To: broonie@kernel.org, dwmw2@infradead.org, computersforpeace@gmail.com,
 marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
 tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
 frieder.schrempf@exceet.de, tglx@linutronix.de
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
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

Add callback function support to the spi-mem device
for passing an argument from the spi-mem layer
to the spi layer.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 include/linux/spi/spi-mem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 5f7d20bd2b09..b9841a9030be 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -13,6 +13,8 @@
 
 #include <linux/spi/spi.h>
 
+typedef size_t (*spi_mem_callback)(void *spi_mem_param);
+
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
 		.buswidth = __buswidth,				\
@@ -172,6 +174,9 @@ struct spi_mem_dirmap_desc {
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
+ * @callback: routine for passing an argument from the
+ *            spi-mem layer to the spi layer.
+ * @callback_param: general parameter to pass to the callback routine
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -183,6 +188,8 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
+	spi_mem_callback callback;
+	void *callback_param;
 };
 
 /**
-- 
2.18.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
