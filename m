From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: Fix wrong transmission when don't use CONT" to the spi tree
Date: Mon,  7 Jan 2019 18:59:37 +0000 (GMT)
Message-ID: <20190107185937.033D01127491@debutante.sirena.org.uk>
References: <20190107074639.6336-5-xiaoning.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107074639.6336-5-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: Fix wrong transmission when don't use CONT

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 6a130448498c151d31f1fb6f3003f5cf37b829e0 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Mon, 7 Jan 2019 07:47:41 +0000
Subject: [PATCH] spi: lpspi: Fix wrong transmission when don't use CONT

Add judgment on SR_MBF and FSR_RXCOUNT.

In PIO mode, if don't use CONT to keep cs selected in one transfer, the
transfer will go wrong. FCIE will be set after one frame transfer
finish. If use CONT, the frame refer to the whole data in one transfer.
If don't use CONT, the frame refer to one byte of whole data. This will
cause the transfer ending early.

This patch add a register reading in isr function, it might lead to a
slight decrease in the max transmission speed in PIO mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ba207931e209..d0b2d551cc43 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -48,6 +48,7 @@
 #define CR_RTF		BIT(8)
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
+#define SR_MBF		BIT(24)
 #define SR_TCF		BIT(10)
 #define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
@@ -61,6 +62,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
+#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -433,6 +435,13 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	if (temp_SR & SR_MBF ||
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		return IRQ_HANDLED;
+	}
+
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 			complete(&fsl_lpspi->xfer_done);
-- 
2.20.1
