From: Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 04/11] spi: spi-mem: allow specifying a command's extension
Date: Wed, 26 Feb 2020 15:06:56 +0530
Message-ID: <20200226093703.19765-5-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
the "command extension". There can be 3 types of extensions in xSPI:
repeat, invert, and hex. When the extension type is "repeat", the same
opcode is sent twice. When it is "invert", the second byte is the
inverse of the opcode. When it is "hex" an additional opcode byte based
is sent with the command whose value can be anything.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 23 +++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cb13e0878b95..3838ddc9aeec 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -462,6 +462,29 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext)
+{
+	switch (op->cmd.ext_type) {
+	case SPI_MEM_EXT_INVERT:
+		*ext = ~op->cmd.opcode;
+		break;
+
+	case SPI_MEM_EXT_REPEAT:
+		*ext = op->cmd.opcode;
+		break;
+
+	case SPI_MEM_EXT_HEX:
+		*ext = op->cmd.ext;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_mem_get_cmd_ext);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4669082b4e3b..06ccab17e4d0 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -67,11 +67,31 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+/**
+ * enum spi_mem_cmd_ext - describes the command opcode extension in DTR mode
+ * @SPI_MEM_EXT_NONE: no extension. This is the default, and is used in Legacy
+ *		      SPI mode
+ * @SPI_MEM_EXT_REPEAT: the extension is same as the opcode
+ * @SPI_MEM_EXT_INVERT: the extension is the bitwise inverse of the opcode
+ * @SPI_MEM_EXT_HEX: the extension is any hex value. The command and opcode
+ *		     combine to form a 16-bit opcode.
+ */
+enum spi_mem_cmd_ext {
+	SPI_MEM_EXT_NONE = 0,
+	SPI_MEM_EXT_REPEAT,
+	SPI_MEM_EXT_INVERT,
+	SPI_MEM_EXT_HEX,
+};
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.is_dtr: whether the command opcode should be sent in DTR mode or not
+ * @cmd.ext_type: type of the command opcode extension in DTR mode
+ * @cmd.ext: value of the command opcode extension in DTR mode. It is
+ *	     only set when 'ext_type' is 'SPI_MEM_EXT_HEX'. In all other
+ *	     cases, the extension can be directly derived from the opcode.
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -97,6 +117,8 @@ struct spi_mem_op {
 		u8 buswidth;
 		u8 opcode;
 		bool is_dtr;
+		enum spi_mem_cmd_ext ext_type;
+		u8 ext;
 	} cmd;
 
 	struct {
@@ -361,6 +383,8 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
+int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext);
+
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.25.0
