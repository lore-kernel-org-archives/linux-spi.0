From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 1/9] Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
Date: Thu, 27 Sep 2018 00:07:31 +0200
Message-ID: <20180926220739.620-2-lukma@denx.de>
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

This reverts commit 9b2a34906c917e6dacfa08f2eafa5beb8baff5e1, as
it is misleading to have READ_QSPI only when we do plan to use
READ_DUAL_QSPI.

Lets bring back the old naming (explicitly showing the QUAD operation).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 7d9620c7ff6c..f67f3fa5b9c9 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -193,7 +193,7 @@
 #define QUADSPI_LUT_NUM		64
 
 /* SEQID -- we can have 16 seqids at most. */
-#define SEQID_READ		0
+#define SEQID_QUAD_READ		0
 #define SEQID_WREN		1
 #define SEQID_WRDI		2
 #define SEQID_RDSR		3
@@ -396,8 +396,8 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	for (i = 0; i < QUADSPI_LUT_NUM; i++)
 		qspi_writel(q, 0, base + QUADSPI_LUT_BASE + i * 4);
 
-	/* Read */
-	lut_base = SEQID_READ * 4;
+	/* Quad Read */
+	lut_base = SEQID_QUAD_READ * 4;
 
 	qspi_writel(q, LUT0(CMD, PAD1, read_op) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
@@ -478,7 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
-		return SEQID_READ;
+		return SEQID_QUAD_READ;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;
 	case SPINOR_OP_WRDI:
-- 
2.11.0
