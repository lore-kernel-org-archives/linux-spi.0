From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 2/7] spi: spi-mem: Add SPI_MEM_NO_DATA to the
 spi_mem_data_dir enum
Date: Tue, 30 Oct 2018 14:36:33 +0100
Message-ID: <20181030133638.3322-3-boris.brezillon@bootlin.com>
References: <20181030133638.3322-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181030133638.3322-1-boris.brezillon@bootlin.com>
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

When defining spi_mem_op templates we don't necessarily know the size
that will be passed when the template is actually used, and basing the
supports_op() check on op->data.nbytes to know whether there will be
data transferred for a specific operation is this not possible.

Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum so that we can base
our checks on op->data.dir instead of op->data.nbytes.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v2:
- New patch
---
 drivers/spi/spi-mem.c       | 2 +-
 include/linux/spi/spi-mem.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80801d2..967f581bca4f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -142,7 +142,7 @@ static bool spi_mem_default_supports_op(struct spi_mem *mem,
 	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
 		return false;
 
-	if (op->data.nbytes &&
+	if (op->data.dir != SPI_MEM_NO_DATA &&
 	    spi_check_buswidth_req(mem, op->data.buswidth,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 867839cc69a7..250b6f5c47c2 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -57,10 +57,12 @@
 /**
  * enum spi_mem_data_dir - describes the direction of a SPI memory data
  *			   transfer from the controller perspective
+ * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
  * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
+	SPI_MEM_NO_DATA,
 	SPI_MEM_DATA_IN,
 	SPI_MEM_DATA_OUT,
 };
-- 
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
