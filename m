From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v6 04/10] mtd: spi-nor: check return value from read/write
Date: 2 Dec 2015 10:38:20 -0000
Message-ID: <777e381ffb750354e51e347af36994c86ad91035.1449052427.git.hramrach@gmail.com>
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

SPI NOR hardware drivers now return useful value from their read/write
functions so check them.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 50 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b7c038c..5f91bfa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -910,7 +910,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = nor->read(nor, from, len, retlen, buf);
 
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_READ);
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
@@ -936,10 +939,14 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
-		nor->write(nor, to, 1, retlen, buf);
+		ret = nor->write(nor, to, 1, retlen, buf);
+		if (ret < 0)
+			goto sst_write_err;
+		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
+		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto time_out;
+			goto sst_write_err;
 	}
 	to += actual;
 
@@ -948,10 +955,14 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
 		/* write two bytes. */
-		nor->write(nor, to, 2, retlen, buf + actual);
+		ret = nor->write(nor, to, 2, retlen, buf + actual);
+		if (ret < 0)
+			goto sst_write_err;
+		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
+		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto time_out;
+			goto sst_write_err;
 		to += 2;
 		nor->sst_write_second = true;
 	}
@@ -960,21 +971,24 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	write_disable(nor);
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
-		goto time_out;
+		goto sst_write_err;
 
 	/* Write out trailing byte if it exists. */
 	if (actual != len) {
 		write_enable(nor);
 
 		nor->program_opcode = SPINOR_OP_BP;
-		nor->write(nor, to, 1, retlen, buf + actual);
-
+		ret = nor->write(nor, to, 1, retlen, buf + actual);
+		if (ret < 0)
+			goto sst_write_err;
+		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
+		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto time_out;
+			goto sst_write_err;
 		write_disable(nor);
 	}
-time_out:
+sst_write_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
 }
@@ -1003,14 +1017,18 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* do all the bytes fit onto one page? */
 	if (page_offset + len <= nor->page_size) {
-		nor->write(nor, to, len, retlen, buf);
+		ret = nor->write(nor, to, len, retlen, buf);
+		if (ret < 0)
+			goto write_err;
 	} else {
 		/* the size of data remaining on the first page */
 		page_size = nor->page_size - page_offset;
-		nor->write(nor, to, page_size, retlen, buf);
+		ret = nor->write(nor, to, page_size, retlen, buf);
+		if (ret < 0)
+			goto write_err;
 
 		/* write everything in nor->page_size chunks */
-		for (i = page_size; i < len; i += page_size) {
+		for (i = ret; i < len; ) {
 			page_size = len - i;
 			if (page_size > nor->page_size)
 				page_size = nor->page_size;
@@ -1021,7 +1039,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 			write_enable(nor);
 
-			nor->write(nor, to + i, page_size, retlen, buf + i);
+			ret = nor->write(nor, to + i, page_size, retlen,
+					 buf + i);
+			if (ret < 0)
+				goto write_err;
+			i += ret;
 		}
 	}
 
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
