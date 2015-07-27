From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 1/5] mtd: spi-nor: notify (Q)SPI controller about protocol change
Date: Mon, 27 Jul 2015 10:59:40 +0200
Message-ID: <36d261a6b16cb77a6faa0eb287164db15cc36acf.1437986785.git.cyrille.pitchen@atmel.com>
References: <cover.1437986785.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1437986785.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Once the Quad SPI mode has been enabled on a Micron flash memory, this
device expects ALL the following commands to use the SPI 4-4-4 protocol.
The (Q)SPI controller needs to be notified about the protocol change so it
can adapt and keep on dialoging with the Micron memory.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
 include/linux/mtd/spi-nor.h   | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d78831b4422b..d373a5fdf48b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -163,6 +163,22 @@ static inline int write_disable(struct spi_nor *nor)
 	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
 }
 
+/*
+ * Let the spi-nor framework notify lower layers, especially the driver of the
+ * (Q)SPI controller, about the new protocol to be used. Indeed, once the
+ * spi-nor framework has sent manufacturer specific commands to a memory to
+ * enable its Quad SPI mode, it should immediately after tell the QSPI
+ * controller to use the very same Quad SPI protocol as expected by the memory.
+ */
+static inline int spi_nor_set_protocol(struct spi_nor *nor,
+				       enum spi_protocol proto)
+{
+	if (nor->set_protocol)
+		return nor->set_protocol(nor, proto);
+
+	return 0;
+}
+
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -943,6 +959,11 @@ static int micron_quad_enable(struct spi_nor *nor)
 		return ret;
 	}
 
+	/* switch protocol to Quad CMD 4-4-4 */
+	ret = spi_nor_set_protocol(nor, SPI_PROTO_4_4_4);
+	if (ret)
+		return ret;
+
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e5409524bb0a..1bf6f11310ef 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -87,6 +87,16 @@ enum read_mode {
 	SPI_NOR_QUAD,
 };
 
+enum spi_protocol {
+	SPI_PROTO_1_1_1,	/* SPI */
+	SPI_PROTO_1_1_2,	/* Dual Output */
+	SPI_PROTO_1_1_4,	/* Quad Output */
+	SPI_PROTO_1_2_2,	/* Dual IO */
+	SPI_PROTO_1_4_4,	/* Quad IO */
+	SPI_PROTO_2_2_2,	/* Dual Command */
+	SPI_PROTO_4_4_4,	/* Quad Command */
+};
+
 /**
  * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash transfer
  * @wren:		command for "Write Enable", or 0x00 for not required
@@ -149,6 +159,7 @@ enum spi_nor_option_flags {
  *			read/write/erase/lock/unlock operations
  * @read_xfer:		[OPTIONAL] the read fundamental primitive
  * @write_xfer:		[OPTIONAL] the writefundamental primitive
+ * @set_protocol:	[OPTIONAL] notify about protocol change
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
@@ -185,6 +196,8 @@ struct spi_nor {
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 			int write_enable);
 
+	int (*set_protocol)(struct spi_nor *nor, enum spi_protocol proto);
+
 	int (*read)(struct spi_nor *nor, loff_t from,
 			size_t len, size_t *retlen, u_char *read_buf);
 	void (*write)(struct spi_nor *nor, loff_t to,
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
