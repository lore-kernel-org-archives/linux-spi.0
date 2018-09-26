From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 6/9] mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and QUAD
Date: Thu, 27 Sep 2018 00:07:36 +0200
Message-ID: <20180926220739.620-7-lukma@denx.de>
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

This commit not only provides the DUAL and QUAD read capability for QSPI
controller, but also resets the AHB pointer sequence (as recommended) and
makes sure that AHB - not IP - mode is used for reading SPI-NOR data to
internal buffer.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 0c381cdfb39f..97546fa70b79 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -119,6 +119,10 @@
 #define QUADSPI_FR			0x160
 #define QUADSPI_FR_TFF_MASK		0x1
 
+#define QUADSPI_SPTRCLR                 0x16c
+#define QUADSPI_SPTRCLR_BFPTRC_SHIFT    0
+#define QUADSPI_SPTRCLR_BFPTRC_MASK     (0x1 << QUADSPI_SPTRCLR_BFPTRC_SHIFT)
+
 #define QUADSPI_SFA1AD			0x180
 #define QUADSPI_SFA2AD			0x184
 #define QUADSPI_SFB1AD			0x188
@@ -903,6 +907,22 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 {
 	struct fsl_qspi *q = nor->priv;
 	u8 cmd = nor->read_opcode;
+	int seqid;
+
+	/* Set the actual lut sequence for AHB Read from the considered nor. */
+	seqid = fsl_qspi_get_seqid(q, nor->read_opcode);
+	if (seqid < 0)
+		return seqid;
+
+	qspi_writel(q, seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
+		    q->iobase + QUADSPI_BFGENCR);
+
+	/* Reset the AHB sequence pointer */
+	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC_MASK,
+		    q->iobase + QUADSPI_SPTRCLR);
+
+	/* make sure the Rx buffer is read through AHB, not IP */
+	qspi_writel(q, QUADSPI_RBCT_WMRK_MASK, q->iobase + QUADSPI_RBCT);
 
 	/* if necessary,ioremap buffer before AHB read, */
 	if (!q->ahb_addr) {
-- 
2.11.0
