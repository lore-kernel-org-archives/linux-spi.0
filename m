From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH linux-next v6 2/8] mtd: spi-nor: remove unused read_xfer/write_xfer hooks
Date: Wed, 9 Sep 2015 15:24:12 +0200
Message-ID: <fbc96099fe24c14a858d29ab6df62d1f2b9bdfeb.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
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
	<ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1441803609.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

struct spi_nor_xfer_cfg and read_xfer/write_xfer hooks were never used by
any driver. Do some cleanup by removing them.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 include/linux/mtd/spi-nor.h | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 66a5f144728a..08e405cbb6af 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -98,33 +98,6 @@ enum spi_protocol {
 	SPI_PROTO_4_4_4,	/* Quad Command */
 };
 
-/**
- * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash transfer
- * @wren:		command for "Write Enable", or 0x00 for not required
- * @cmd:		command for operation
- * @cmd_pins:		number of pins to send @cmd (1, 2, 4)
- * @addr:		address for operation
- * @addr_pins:		number of pins to send @addr (1, 2, 4)
- * @addr_width:		number of address bytes
- *			(3,4, or 0 for address not required)
- * @mode:		mode data
- * @mode_pins:		number of pins to send @mode (1, 2, 4)
- * @mode_cycles:	number of mode cycles (0 for mode not required)
- * @dummy_cycles:	number of dummy cycles (0 for dummy not required)
- */
-struct spi_nor_xfer_cfg {
-	u8		wren;
-	u8		cmd;
-	u8		cmd_pins;
-	u32		addr;
-	u8		addr_pins;
-	u8		addr_width;
-	u8		mode;
-	u8		mode_pins;
-	u8		mode_cycles;
-	u8		dummy_cycles;
-};
-
 #define SPI_NOR_MAX_CMD_SIZE	8
 enum spi_nor_ops {
 	SPI_NOR_OPS_READ = 0,
@@ -152,7 +125,6 @@ enum spi_nor_option_flags {
  * @flash_read:		the mode of the read
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
- * @cfg:		used by the read_xfer/write_xfer
  * @erase_proto:	the SPI protocol used by erase operations
  * @read_proto:		the SPI protocol used by read operations
  * @write_proto:	the SPI protocol used by write operations
@@ -162,8 +134,6 @@ enum spi_nor_option_flags {
  *			read/write/erase/lock/unlock operations
  * @unprepare:		[OPTIONAL] do some post work after the
  *			read/write/erase/lock/unlock operations
- * @read_xfer:		[OPTIONAL] the read fundamental primitive
- * @write_xfer:		[OPTIONAL] the writefundamental primitive
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
@@ -191,15 +161,10 @@ struct spi_nor {
 	enum read_mode		flash_read;
 	bool			sst_write_second;
 	u32			flags;
-	struct spi_nor_xfer_cfg	cfg;
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
 
 	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
 	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
-	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
-			 u8 *buf, size_t len);
-	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
-			  u8 *buf, size_t len);
 	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 			int write_enable);
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
