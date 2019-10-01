From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: Introduce variable to fix different invalid master Id" to the spi tree
Date: Tue,  1 Oct 2019 18:57:01 +0100 (BST)
Message-ID: <20191001175701.2E5512742A10@ypsilon.sirena.org.uk>
References: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
Cc: broonie@kernel.org, han.xu@nxp.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Suresh Gupta <suresh.gupta@nxp.com>
To: Kuldeep Singh <kuldeep.singh@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-qspi: Introduce variable to fix different invalid master Id

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 16c3e058036a6f5be542962e487d428518edcb45 Mon Sep 17 00:00:00 2001
From: Kuldeep Singh <kuldeep.singh@nxp.com>
Date: Tue, 1 Oct 2019 14:29:16 +0530
Subject: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different
 invalid master Id

Different platforms have different Master with different SourceID on
AHB bus. The 0X0E Master ID is used by cluster 3 in case of LS2088A.
So, patch introduce an invalid master id variable to fix invalid
mastered on different platforms.

Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Link: https://lore.kernel.org/r/1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c02e24c01136..51385b0927e3 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -63,6 +63,11 @@
 #define QUADSPI_IPCR			0x08
 #define QUADSPI_IPCR_SEQID(x)		((x) << 24)
 
+#define QUADSPI_BUF0CR                  0x10
+#define QUADSPI_BUF1CR                  0x14
+#define QUADSPI_BUF2CR                  0x18
+#define QUADSPI_BUFXCR_INVALID_MSTRID   0xe
+
 #define QUADSPI_BUF3CR			0x1c
 #define QUADSPI_BUF3CR_ALLMST_MASK	BIT(31)
 #define QUADSPI_BUF3CR_ADATSZ(x)	((x) << 8)
@@ -184,6 +189,7 @@
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
+	int invalid_mstrid;
 	unsigned int ahb_buf_size;
 	unsigned int quirks;
 	bool little_endian;
@@ -192,6 +198,7 @@ struct fsl_qspi_devtype_data {
 static const struct fsl_qspi_devtype_data vybrid_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_SWAP_ENDIAN,
 	.little_endian = true,
@@ -200,6 +207,7 @@ static const struct fsl_qspi_devtype_data vybrid_data = {
 static const struct fsl_qspi_devtype_data imx6sx_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_4X_INT_CLK | QUADSPI_QUIRK_TKT245618,
 	.little_endian = true,
@@ -208,6 +216,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 static const struct fsl_qspi_devtype_data imx7d_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
 	.little_endian = true,
@@ -216,6 +225,7 @@ static const struct fsl_qspi_devtype_data imx7d_data = {
 static const struct fsl_qspi_devtype_data imx6ul_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
 	.little_endian = true,
@@ -224,6 +234,7 @@ static const struct fsl_qspi_devtype_data imx6ul_data = {
 static const struct fsl_qspi_devtype_data ls1021a_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = 0,
 	.little_endian = false,
@@ -233,6 +244,7 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
 	.ahb_buf_size = SZ_1K,
+	.invalid_mstrid = 0x0,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_BASE_INTERNAL,
 	.little_endian = true,
 };
@@ -615,6 +627,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	void __iomem *base = q->iobase;
 	u32 addr_offset = 0;
 	int err = 0;
+	int invalid_mstrid = q->devtype_data->invalid_mstrid;
 
 	mutex_lock(&q->lock);
 
@@ -638,6 +651,10 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
 		    base + QUADSPI_SPTRCLR);
 
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF0CR);
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF1CR);
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF2CR);
+
 	fsl_qspi_prepare_lut(q, op);
 
 	/*
-- 
2.20.1
