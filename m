From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 2/9] mtd: qspi: Provide quirk to read only half of RX buffer (NXP's vybrid)
Date: Thu, 27 Sep 2018 00:07:32 +0200
Message-ID: <20180926220739.620-3-lukma@denx.de>
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

This commit introduces new quirk for the NXP's quadspi driver for vybrid
SoC. It turns out that when reading for example 256B as single bytes:
dd if=/dev/mtd7 of=aaa.img bs=1 count=256

root@nix:~# hexdump aaa.img
0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
0000010 e98e 5265 683c a635 c069 e402 303f d936
0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
0000040 01c9 462d 0a43 f893 0e42 67f1 57f0 787c
0000050 49c0 fb2a e514 e954 1d21 affa bac4 38f1
0000060 1ca5 ec46 77eb a854 285b 8e21 12d7 f377
0000070 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000100


Data got corrupted.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index f67f3fa5b9c9..2ef5bfc41d32 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -41,6 +41,8 @@
 #define QUADSPI_QUIRK_TKT253890		(1 << 2)
 /* Controller cannot wake up from wait mode, TKT245618 */
 #define QUADSPI_QUIRK_TKT245618         (1 << 3)
+/* Controller can only read half a rx fifo through AHB */
+#define QUADSPI_QUIRK_AHB_READ_HALF_FIFO  (1 << 4)
 
 /* The registers */
 #define QUADSPI_MCR			0x00
@@ -230,7 +232,8 @@ static const struct fsl_qspi_devtype_data vybrid_data = {
 	.rxfifo = 128,
 	.txfifo = 64,
 	.ahb_buf_size = 1024,
-	.driver_data = QUADSPI_QUIRK_SWAP_ENDIAN,
+	.driver_data = QUADSPI_QUIRK_SWAP_ENDIAN
+		       | QUADSPI_QUIRK_AHB_READ_HALF_FIFO,
 };
 
 static const struct fsl_qspi_devtype_data imx6sx_data = {
@@ -341,6 +344,11 @@ static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr)
 		return ioread32(addr);
 }
 
+static inline int needs_half_fifo(struct fsl_qspi *q)
+{
+	return q->devtype_data->driver_data & QUADSPI_QUIRK_AHB_READ_HALF_FIFO;
+}
+
 /*
  * An IC bug makes us to re-arrange the 32-bit data.
  * The following chips, such as IMX6SLX, have fixed this bug.
@@ -390,6 +398,10 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	u8 read_op = nor->read_opcode;
 	u8 read_dm = nor->read_dummy;
 
+	/* use only half fifo if controller needs that */
+	if (needs_half_fifo(q))
+		rxfifo /= 2;
+
 	fsl_qspi_unlock_lut(q);
 
 	/* Clear all the LUT table */
@@ -675,6 +687,7 @@ static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	int seqid;
+	u32 buf3cr;
 
 	/* AHB configuration for access buffer 0/1/2 .*/
 	qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF0CR);
@@ -682,12 +695,14 @@ static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 	qspi_writel(q, QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF2CR);
 	/*
 	 * Set ADATSZ with the maximum AHB buffer size to improve the
-	 * read performance.
+	 * read performance, except when the controller should not use
+	 * more than half its RX fifo in AHB reads, in which case read
+	 * size is given in the LUT FSL_READ instructions.
 	 */
-	qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
-			((q->devtype_data->ahb_buf_size / 8)
-			<< QUADSPI_BUF3CR_ADATSZ_SHIFT),
-			base + QUADSPI_BUF3CR);
+	buf3cr = QUADSPI_BUF3CR_ALLMST_MASK
+		| ( (needs_half_fifo(q)? 0 : q->devtype_data->ahb_buf_size / 8)
+		    << QUADSPI_BUF3CR_ADATSZ_SHIFT);
+	writel(buf3cr, base + QUADSPI_BUF3CR);
 
 	/* We only use the buffer3 */
 	qspi_writel(q, 0, base + QUADSPI_BUF0IND);
-- 
2.11.0
