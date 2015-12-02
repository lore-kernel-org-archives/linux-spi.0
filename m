From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v6 05/10] mtd: spi-nor: stop passing around retlen
Date: 2 Dec 2015 10:38:20 -0000
Message-ID: <8eb1ba678cf0caffd298046367a490186875b342.1449052427.git.hramrach@gmail.com>
References: <cover.1449052427.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
 Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 "Rafal Milecki" <zajec5@gmail.com>, Jagan Teki <jteki@openedev.com>,
 "Andrew F. Davis" <afd@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Gabor Juhos <juhosg@openwrt.org>, "Bean Huo  " <beanhuo@micron.com>,
 Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1449052427.git.hramrach@gmail.com>
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

Do not pass retlen to hardware driver read/write functions. Update it in
spi-nor generic driver instead.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/devices/m25p80.c      |  6 ++----
 drivers/mtd/spi-nor/fsl-quadspi.c | 16 ++++++----------
 drivers/mtd/spi-nor/spi-nor.c     | 21 +++++++++++++--------
 include/linux/mtd/spi-nor.h       |  4 ++--
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fc694fd..58ecfa4 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -74,7 +74,7 @@ static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 }
 
 static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
-			size_t *retlen, const u_char *buf)
+			    const u_char *buf)
 {
 	struct m25p *flash = nor->priv;
 	struct spi_device *spi = flash->spi;
@@ -106,7 +106,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	ret = m.actual_length - cmd_sz;
 	if (ret < 0)
 		return -EIO;
-	*retlen += ret;
 	return ret;
 }
 
@@ -127,7 +126,7 @@ static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
  * may be any size provided it is within the physical boundaries.
  */
 static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
-			size_t *retlen, u_char *buf)
+			   u_char *buf)
 {
 	struct m25p *flash = nor->priv;
 	struct spi_device *spi = flash->spi;
@@ -161,7 +160,6 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	ret = m.actual_length - m25p_cmdsz(nor) - dummy;
 	if (ret < 0)
 		return -EIO;
-	*retlen += ret;
 	return ret;
 }
 
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 9beb739..7491fbb 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -577,7 +577,7 @@ static inline void fsl_qspi_invalid(struct fsl_qspi *q)
 
 static ssize_t fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
 				u8 opcode, unsigned int to, u32 *txbuf,
-				unsigned count, size_t *retlen)
+				unsigned count)
 {
 	int ret, i, j;
 	u32 tmp;
@@ -604,11 +604,8 @@ static ssize_t fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
 	/* Trigger it */
 	ret = fsl_qspi_runcmd(q, opcode, to, count);
 
-	if (ret == 0) {
-		if (retlen)
-			*retlen += count;
+	if (ret == 0)
 		return count;
-	}
 
 	return ret;
 }
@@ -816,7 +813,7 @@ static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 
 	} else if (len > 0) {
 		ret = fsl_qspi_nor_write(q, nor, opcode, 0,
-					(u32 *)buf, len, NULL);
+					(u32 *)buf, len);
 		if (ret > 0)
 			return 0;
 	} else {
@@ -828,12 +825,11 @@ static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 }
 
 static ssize_t fsl_qspi_write(struct spi_nor *nor, loff_t to,
-		size_t len, size_t *retlen, const u_char *buf)
+			      size_t len, const u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
-
 	ssize_t ret = fsl_qspi_nor_write(q, nor, nor->program_opcode, to,
-				(u32 *)buf, len, retlen);
+					 (u32 *)buf, len);
 
 	/* invalid the data in the AHB buffer. */
 	fsl_qspi_invalid(q);
@@ -841,7 +837,7 @@ static ssize_t fsl_qspi_write(struct spi_nor *nor, loff_t to,
 }
 
 static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
-		size_t len, size_t *retlen, u_char *buf)
+			     size_t len, u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
 	u8 cmd = nor->read_opcode;
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5f91bfa..3d02803 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -907,12 +907,13 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (ret)
 		return ret;
 
-	ret = nor->read(nor, from, len, retlen, buf);
+	ret = nor->read(nor, from, len, buf);
 
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_READ);
 	if (ret < 0)
 		return ret;
 
+	*retlen += ret;
 	return 0;
 }
 
@@ -939,7 +940,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
-		ret = nor->write(nor, to, 1, retlen, buf);
+		ret = nor->write(nor, to, 1, buf);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -955,7 +956,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
 		/* write two bytes. */
-		ret = nor->write(nor, to, 2, retlen, buf + actual);
+		ret = nor->write(nor, to, 2, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
@@ -978,7 +979,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		write_enable(nor);
 
 		nor->program_opcode = SPINOR_OP_BP;
-		ret = nor->write(nor, to, 1, retlen, buf + actual);
+		ret = nor->write(nor, to, 1, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -987,8 +988,10 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto sst_write_err;
 		write_disable(nor);
+		actual += 1;
 	}
 sst_write_err:
+	*retlen += actual;
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
 }
@@ -1017,15 +1020,17 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* do all the bytes fit onto one page? */
 	if (page_offset + len <= nor->page_size) {
-		ret = nor->write(nor, to, len, retlen, buf);
+		ret = nor->write(nor, to, len, buf);
 		if (ret < 0)
 			goto write_err;
+		*retlen += ret;
 	} else {
 		/* the size of data remaining on the first page */
 		page_size = nor->page_size - page_offset;
-		ret = nor->write(nor, to, page_size, retlen, buf);
+		ret = nor->write(nor, to, page_size, buf);
 		if (ret < 0)
 			goto write_err;
+		*retlen += ret;
 
 		/* write everything in nor->page_size chunks */
 		for (i = ret; i < len; ) {
@@ -1039,10 +1044,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 			write_enable(nor);
 
-			ret = nor->write(nor, to + i, page_size, retlen,
-					 buf + i);
+			ret = nor->write(nor, to + i, page_size, buf + i);
 			if (ret < 0)
 				goto write_err;
+			*retlen += ret;
 			i += ret;
 		}
 	}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 6080701..c4b059b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -172,9 +172,9 @@ struct spi_nor {
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 
 	ssize_t (*read)(struct spi_nor *nor, loff_t from,
-			size_t len, size_t *retlen, u_char *read_buf);
+			size_t len, u_char *read_buf);
 	ssize_t (*write)(struct spi_nor *nor, loff_t to,
-			size_t len, size_t *retlen, const u_char *write_buf);
+			size_t len, const u_char *write_buf);
 	int (*erase)(struct spi_nor *nor, loff_t offs);
 
 	int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
