From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 09/18] mtd: spi-nor: Add spi_nor_{read,
 write}_reg() helpers
Date: Fri, 12 Oct 2018 10:48:16 +0200
Message-ID: <20181012084825.23697-10-boris.brezillon@bootlin.com>
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

Add the spi_nor_{read,write}_reg() helpers (which are just thin
wrappers around ->{read,write}_reg()) in order to prepare things for
X-X-X modes support. The idea is to reject calls to
->{read,write}_reg() when the chip has entered such a mode, because
SPI NOR controller drivers are not ready for that.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7fad94588c55..42f299a0b76f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -148,6 +148,16 @@ static int spi_nor_nodata_op(struct spi_nor *nor, struct spi_mem_op *op)
 	return spi_nor_exec_op(nor, op, NULL, NULL, 0);
 }
 
+static int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *val, int len)
+{
+	return nor->read_reg(nor, opcode, val, len);
+}
+
+static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *val, int len)
+{
+	return nor->write_reg(nor, opcode, val, len);
+}
+
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
 					size_t len, u8 *buf)
 {
@@ -283,7 +293,7 @@ static int read_sr(struct spi_nor *nor)
 
 		ret = spi_nor_data_op(nor, &op, &val, 1);
 	} else {
-		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDSR, &val, 1);
 	}
 
 	if (ret < 0) {
@@ -313,7 +323,7 @@ static int read_fsr(struct spi_nor *nor)
 
 		ret = spi_nor_data_op(nor, &op, &val, 1);
 	} else {
-		ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
 	}
 
 	if (ret < 0) {
@@ -343,7 +353,7 @@ static int read_cr(struct spi_nor *nor)
 
 		ret = spi_nor_data_op(nor, &op, &val, 1);
 	} else {
-		ret = nor->read_reg(nor, SPINOR_OP_RDCR, &val, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDCR, &val, 1);
 	}
 
 	if (ret < 0) {
@@ -371,7 +381,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
 	}
 
 	nor->cmd_buf[0] = val;
-	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1);
+	return spi_nor_write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1);
 }
 
 
@@ -391,7 +401,7 @@ static int write_enable(struct spi_nor *nor)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+	return spi_nor_write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 }
 
 /*
@@ -409,7 +419,7 @@ static int write_disable(struct spi_nor *nor)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
+	return spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
 
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
@@ -515,7 +525,7 @@ static int set_4byte(struct spi_nor *nor, bool enable)
 		return spi_nor_data_op(nor, &op, nor->cmd_buf, 1);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
+	return spi_nor_write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
 }
 
 static int xread_sr(struct spi_nor *nor, u8 *sr)
@@ -530,7 +540,7 @@ static int xread_sr(struct spi_nor *nor, u8 *sr)
 		return spi_nor_data_op(nor, &op, sr, 1);
 	}
 
-	return nor->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+	return spi_nor_read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
 }
 
 static int s3an_sr_ready(struct spi_nor *nor)
@@ -560,7 +570,7 @@ static int clear_sr(struct spi_nor *nor)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+	return spi_nor_write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
 }
 
 static int spi_nor_sr_ready(struct spi_nor *nor)
@@ -594,7 +604,7 @@ static int clear_fsr(struct spi_nor *nor)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+	return spi_nor_write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
 }
 
 static int spi_nor_fsr_ready(struct spi_nor *nor)
@@ -692,7 +702,7 @@ static int erase_chip(struct spi_nor *nor)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
+	return spi_nor_write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
 }
 
 static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops)
@@ -774,7 +784,7 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 		addr >>= 8;
 	}
 
-	return nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
+	return spi_nor_write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
 }
 
 /**
@@ -1873,7 +1883,7 @@ static int read_id(struct spi_nor *nor, u8 *id)
 		return spi_nor_data_op(nor, &op, id, SPI_NOR_MAX_ID_LEN);
 	}
 
-	return nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+	return spi_nor_read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
 }
 
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
@@ -2102,7 +2112,7 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 
 		ret = spi_nor_data_op(nor, &op, sr_cr, 2);
 	} else {
-		ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
 	}
 
 	if (ret < 0) {
@@ -2258,7 +2268,7 @@ static int write_sr2(struct spi_nor *nor, u8 sr2)
 		return spi_nor_data_op(nor, &op, &sr2, 1);
 	}
 
-	return nor->write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
+	return spi_nor_write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
 }
 
 static int read_sr2(struct spi_nor *nor, u8 *sr2)
@@ -2273,7 +2283,7 @@ static int read_sr2(struct spi_nor *nor, u8 *sr2)
 		return spi_nor_data_op(nor, &op, sr2, 1);
 	}
 
-	return nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
+	return spi_nor_read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
 }
 
 /**
@@ -4024,8 +4034,8 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 		return spi_nor_nodata_op(nor, &op);
 	}
 
-	return nor->write_reg(nor, enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B,
-			      NULL, 0);
+	return spi_nor_write_reg(nor, enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B,
+				 NULL, 0);
 }
 
 static int micron_set_4byte(struct spi_nor *nor, bool enable)
@@ -4052,7 +4062,7 @@ static int write_ear(struct spi_nor *nor, u8 ear)
 	}
 
 	nor->cmd_buf[0] = ear;
-	return nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
+	return spi_nor_write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
 }
 
 static int winbond_set_4byte(struct spi_nor *nor, bool enable)
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
