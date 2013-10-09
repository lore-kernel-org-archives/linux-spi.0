From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv3 2/3] drivers: mtd: devices: Add quad read support.
Date: Wed, 9 Oct 2013 20:54:43 +0530
Message-ID: <1381332284-21822-3-git-send-email-sourav.poddar@ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 Sourav Poddar <sourav.poddar@ti.com>, linux-mtd@lists.infradead.org,
 balbi@ti.com
To: <broonie@kernel.org>, <dwmw2@infradead.org>, <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
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

Some flash also support quad read mode.
Adding support for adding quad mode in m25p80
for spansion and macronix flash.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v2->v3:
Add macronix flash support
 drivers/mtd/devices/m25p80.c |  184 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 26b14f9..dc9bcbf 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -41,6 +41,7 @@
 #define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
 #define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
 #define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
+#define	OPCODE_QUAD_READ        0x6b    /* QUAD READ */
 #define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
 #define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
 #define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -48,6 +49,7 @@
 #define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
 #define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
 #define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
+#define	OPCODE_RDCR		0x35    /* Read configuration register */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
@@ -76,6 +78,10 @@
 #define	SR_BP2			0x10	/* Block protect 2 */
 #define	SR_SRWD			0x80	/* SR write protect */
 
+/* Configuration Register bits. */
+#define SPAN_QUAD_CR_EN		0x2	/* Spansion Quad I/O */
+#define MACR_QUAD_SR_EN		0x40	/* Macronix Quad I/O */
+
 /* Define max times to check status register before we give up. */
 #define	MAX_READY_WAIT_JIFFIES	(40 * HZ)	/* M25P16 specs 40s max chip erase */
 #define	MAX_CMD_SIZE		5
@@ -95,6 +101,7 @@ struct m25p {
 	u8			program_opcode;
 	u8			*command;
 	bool			fast_read;
+	bool			quad_read;
 };
 
 static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
@@ -163,6 +170,25 @@ static inline int write_disable(struct m25p *flash)
 	return spi_write_then_read(flash->spi, &code, 1, NULL, 0);
 }
 
+/* Read the configuration register, returning its value in the location
+ * Return the configuration register value.
+ * Returns negative if error occurred.
+*/
+static int read_cr(struct m25p *flash)
+{
+	u8 code = OPCODE_RDCR;
+	int ret;
+	u8 val;
+
+	ret = spi_write_then_read(flash->spi, &code, 1, &val, 1);
+	if (ret < 0) {
+		dev_err(&flash->spi->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
 /*
  * Enable/disable 4-byte addressing mode.
  */
@@ -336,6 +362,122 @@ static int m25p80_erase(struct mtd_info *mtd, struct erase_info *instr)
 	return 0;
 }
 
+/* Write status register and configuration register with 2 bytes
+* The first byte will be written to the status register, while the second byte
+* will be written to the configuration register.
+* Returns negative if error occurred.
+*/
+static int write_sr_cr(struct m25p *flash, u16 val)
+{
+	flash->command[0] = OPCODE_WRSR;
+	flash->command[1] = val & 0xff;
+	flash->command[2] = (val >> 8);
+
+	return spi_write(flash->spi, flash->command, 3);
+}
+
+static int macronix_quad_enable(struct m25p *flash)
+{
+	int ret, val;
+	u8 cmd[2];
+	cmd[0] = OPCODE_WRSR;
+
+	val = read_sr(flash);
+	cmd[1] = val | MACR_QUAD_SR_EN;
+	write_enable(flash);
+
+	spi_write(flash->spi, &cmd, 2);
+
+	if (wait_till_ready(flash))
+		return 1;
+
+	ret = read_sr(flash);
+	if (!(ret > 0 && (ret & MACR_QUAD_SR_EN))) {
+		dev_err(&flash->spi->dev,
+			"Macronix Quad bit not set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spansion_quad_enable(struct m25p *flash)
+{
+	int ret;
+	int quad_en = SPAN_QUAD_CR_EN << 8;
+
+	write_enable(flash);
+
+	ret = write_sr_cr(flash, quad_en);
+	if (ret < 0) {
+		dev_err(&flash->spi->dev,
+			"error while writing configuration register");
+		return -EINVAL;
+	}
+
+	/* read back and check it */
+	ret = read_cr(flash);
+	if (!(ret > 0 && (ret & SPAN_QUAD_CR_EN))) {
+		dev_err(&flash->spi->dev,
+			"Spansion Quad bit not set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int m25p80_quad_read(struct mtd_info *mtd, loff_t from, size_t len,
+	size_t *retlen, u_char *buf)
+{
+	struct m25p *flash = mtd_to_m25p(mtd);
+	struct spi_transfer t[2];
+	struct spi_message m;
+	uint8_t opcode;
+
+	pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
+			__func__, (u32)from, len);
+
+	spi_message_init(&m);
+	memset(t, 0, (sizeof(t)));
+
+	t[0].tx_buf = flash->command;
+	t[0].len = m25p_cmdsz(flash) + (flash->quad_read ? 1 : 0);
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	t[1].len = len;
+	t[1].rx_nbits = SPI_NBITS_QUAD;
+	spi_message_add_tail(&t[1], &m);
+
+	mutex_lock(&flash->lock);
+
+	/* Wait till previous write/erase is done. */
+	if (wait_till_ready(flash)) {
+		/* REVISIT status return?? */
+		mutex_unlock(&flash->lock);
+		return 1;
+	}
+
+	/* FIXME switch to OPCODE_QUAD_READ.  It's required for higher
+	 * clocks; and at this writing, every chip this driver handles
+	 * supports that opcode.
+	*/
+
+	/* Set up the write data buffer. */
+	opcode = flash->read_opcode;
+	flash->command[0] = opcode;
+	m25p_addr2cmd(flash, from, flash->command);
+
+	spi_sync(flash->spi, &m);
+
+	*retlen = m.actual_length - m25p_cmdsz(flash) -
+			(flash->quad_read ? 1 : 0);
+
+	mutex_unlock(&flash->lock);
+
+	return 0;
+}
+
 /*
  * Read an address range from the flash chip.  The address range
  * may be any size provided it is within the physical boundaries.
@@ -928,6 +1070,7 @@ static int m25p_probe(struct spi_device *spi)
 	unsigned			i;
 	struct mtd_part_parser_data	ppdata;
 	struct device_node __maybe_unused *np = spi->dev.of_node;
+	int ret;
 
 #ifdef CONFIG_MTD_OF_PARTS
 	if (!of_device_is_available(np))
@@ -979,15 +1122,9 @@ static int m25p_probe(struct spi_device *spi)
 		}
 	}
 
-	flash = kzalloc(sizeof *flash, GFP_KERNEL);
+	flash = devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
 	if (!flash)
 		return -ENOMEM;
-	flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 : 0),
-					GFP_KERNEL);
-	if (!flash->command) {
-		kfree(flash);
-		return -ENOMEM;
-	}
 
 	flash->spi = spi;
 	mutex_init(&flash->lock);
@@ -1015,7 +1152,6 @@ static int m25p_probe(struct spi_device *spi)
 	flash->mtd.flags = MTD_CAP_NORFLASH;
 	flash->mtd.size = info->sector_size * info->n_sectors;
 	flash->mtd._erase = m25p80_erase;
-	flash->mtd._read = m25p80_read;
 
 	/* flash protection support for STmicro chips */
 	if (JEDEC_MFR(info->jedec_id) == CFI_MFR_ST) {
@@ -1067,6 +1203,38 @@ static int m25p_probe(struct spi_device *spi)
 
 	flash->program_opcode = OPCODE_PP;
 
+	flash->quad_read = false;
+	if (spi->mode && SPI_RX_QUAD)
+		flash->quad_read = true;
+
+	flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 :
+				(flash->quad_read ? 1 : 0)), GFP_KERNEL);
+	if (!flash->command) {
+		kfree(flash);
+		return -ENOMEM;
+	}
+
+	if (flash->quad_read) {
+		if (of_property_read_bool(np, "macronix,quad_enable")) {
+			ret = macronix_quad_enable(flash);
+			if (ret) {
+				dev_err(&spi->dev,
+					"error enabling quad");
+				return -EINVAL;
+			}
+		} else if (of_property_read_bool(np, "spansion,quad_enable")) {
+			ret = spansion_quad_enable(flash);
+			if (ret) {
+				dev_err(&spi->dev,
+					"error enabling quad");
+				return -EINVAL;
+			}
+		} else
+			dev_dbg(&spi->dev, "quad enable not supported");
+		flash->mtd._read = m25p80_quad_read;
+	} else
+		flash->mtd._read = m25p80_read;
+
 	if (info->addr_width)
 		flash->addr_width = info->addr_width;
 	else if (flash->mtd.size > 0x1000000) {
-- 
1.7.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
