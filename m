From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 18/18] mtd: spi-nor: Make sure the 8D-8D-8D can be
 selected on mx25uw51245g
Date: Fri, 12 Oct 2018 10:48:25 +0200
Message-ID: <20181012084825.23697-19-boris.brezillon@bootlin.com>
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

mx25uw51245g support 8D-8D-8D mode. Patch the macronix_opi_change_mode()
and macronix_opi_tweak_params() functions to support this mode.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d961e3a7b500..e8bd807b7520 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1709,6 +1709,10 @@ static int macronix_opi_change_mode(struct spi_nor *nor,
 		val |= CR2_REG0_MODE_OPI_STR;
 		break;
 
+	case SPI_NOR_MODE_OPI_FULL_DTR:
+		val |= CR2_REG0_MODE_OPI_DTR;
+		break;
+
 	default:
 		/*
 		 * If we reach that point, there's a serious problem in the
@@ -1732,7 +1736,11 @@ static void macronix_opi_adjust_op(struct spi_nor *nor, struct spi_mem_op *op)
 	case SPINOR_OP_READ_4B:
 	case SPINOR_OP_READ_FAST_4B:
 		op->dummy.nbytes = 20;
-		op->cmd.opcode = 0xec;
+		if (nor->mode == SPI_NOR_MODE_OPI_FULL_DTR)
+			op->cmd.opcode = 0xee;
+		else
+			op->cmd.opcode = 0xec;
+
 		break;
 
 	case SPINOR_OP_PP:
@@ -1781,8 +1789,11 @@ static void macronix_opi_adjust_op(struct spi_nor *nor, struct spi_mem_op *op)
 	if (op->addr.nbytes)
 		op->addr.buswidth = 8;
 
-	if (op->dummy.nbytes)
+	if (op->dummy.nbytes) {
 		op->dummy.buswidth = 8;
+		if (op->dummy.dtr)
+			op->dummy.nbytes *= 2;
+	}
 
 	if (op->data.buswidth)
 		op->data.buswidth = 8;
@@ -1805,6 +1816,14 @@ static void macronix_opi_tweak_params(struct spi_nor *nor,
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8],
 				0x12ed,
 				SNOR_PROTO_8_8_8 | SNOR_PROTO_INST_2BYTE);
+
+	params->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8D_8D_8D],
+				  0, 20, 0xee11,
+				  SNOR_PROTO_8D_8D_8D | SNOR_PROTO_INST_2BYTE);
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8D_8D_8D],
+				0x12ed,
+				SNOR_PROTO_8D_8D_8D | SNOR_PROTO_INST_2BYTE);
 }
 
 /* Used when the "_ext_id" is two bytes at most */
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
