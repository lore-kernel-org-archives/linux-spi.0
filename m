From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 5/9] mtd: spi: Provide LUT entry to perform DUAL read
Date: Thu, 27 Sep 2018 00:07:35 +0200
Message-ID: <20180926220739.620-6-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This commit adds LUT sequence to perform DUAL read (as opposite to the
default QUAD for this controller).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 4f0c78ba6fcb..0c381cdfb39f 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -207,6 +207,7 @@
 #define SEQID_RDCR		9
 #define SEQID_EN4B		10
 #define SEQID_BRWR		11
+#define SEQID_DUAL_READ	12
 
 #define QUADSPI_MIN_IOMAP SZ_4M
 
@@ -482,6 +483,15 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	qspi_writel(q, LUT0(CMD, PAD1, SPINOR_OP_BRWR),
 			base + QUADSPI_LUT(lut_base));
 
+	/* Dual Read */
+	lut_base = SEQID_DUAL_READ * 4;
+
+	qspi_writel(q, LUT0(CMD, PAD1, SPINOR_OP_READ_1_1_2) |
+		    LUT1(ADDR, PAD1, addrlen), base + QUADSPI_LUT(lut_base));
+	qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
+		    LUT1(FSL_READ, PAD2, rxfifo),
+			base + QUADSPI_LUT(lut_base + 1));
+
 	fsl_qspi_lock_lut(q);
 }
 
@@ -513,6 +523,8 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 		return SEQID_EN4B;
 	case SPINOR_OP_BRWR:
 		return SEQID_BRWR;
+	case SPINOR_OP_READ_1_1_2:
+		return SEQID_DUAL_READ;
 	default:
 		if (cmd == q->nor[0].erase_opcode)
 			return SEQID_SE;
-- 
2.11.0
