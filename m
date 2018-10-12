From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 03/18] spi: spi-mem: Prepare things for DTR mode support
Date: Fri, 12 Oct 2018 10:48:10 +0200
Message-ID: <20181012084825.23697-4-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
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

Add dtr fields to the spi_mem_op struct and make sure all DTR
operations are rejected for now.

We intentionally do not expose a new flag at the spi_device level,
since spi memories seem to be the only users of this feature.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi-mem.c       |  3 +++
 include/linux/spi/spi-mem.h | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2379efcaf1c6..3da57219b539 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -154,6 +154,9 @@ static bool spi_mem_default_supports_op(struct spi_mem *mem,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 69ee30456864..cad116005034 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -19,6 +19,13 @@
 		.opcode = __opcode,				\
 	}
 
+#define SPI_MEM_OP_DTR_CMD(__opcode, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.opcode = __opcode,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
@@ -26,6 +33,14 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DTR_ADDR(__nbytes, __val, __buswidth)	\
+	{							\
+		.nbytes = __nbytes,				\
+		.val = __val,					\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
@@ -34,6 +49,13 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DTR_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
@@ -44,6 +66,15 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DTR_DATA_IN(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
@@ -52,6 +83,15 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DTR_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DATA	{ }
 
 /**
@@ -68,10 +108,12 @@ enum spi_mem_data_dir {
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.buswidth: number of IO lines used to transmit the command
+ * @cmd.dtr: set true to transfer opcode in double transfer rate mode
  * @cmd.opcode: operation opcode
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: set true to transfer address bytes in double transfer rate mode
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
@@ -79,34 +121,40 @@ enum spi_mem_data_dir {
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
+ * @dummy.dtr: set true to transfer dummy bytes in double transfer rate mode
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
+ * @data.dtr: set true to transfer data bytes in double transfer rate mode
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
  */
 struct spi_mem_op {
 	struct {
 		u8 buswidth;
+		bool dtr;
 		u8 opcode;
 	} cmd;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		bool dtr;
 		u64 val;
 	} addr;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		bool dtr;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
+		bool dtr;
 		union {
 			void *in;
 			const void *out;
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
