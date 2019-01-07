From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 4/8] spi: lpspi: Fix wrong transmission when don't use CONT
Date: Mon, 7 Jan 2019 07:47:41 +0000
Message-ID: <20190107074639.6336-5-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add judgment on SR_MBF and FSR_RXCOUNT.

In PIO mode, if don't use CONT to keep cs selected in one transfer, the
transfer will go wrong. FCIE will be set after one frame transfer
finish. If use CONT, the frame refer to the whole data in one transfer.
If don't use CONT, the frame refer to one byte of whole data. This will
cause the transfer ending early.

This patch add a register reading in isr function, it might lead to a
slight decrease in the max transmission speed in PIO mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f32a2e0d7ae1..51c85cf0bd9f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -52,6 +52,7 @@
 #define CR_RTF		BIT(8)
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
+#define SR_MBF		BIT(24)
 #define SR_TCF		BIT(10)
 #define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
@@ -65,6 +66,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
+#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -446,6 +448,13 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
)
 		return IRQ_HANDLED;
 	}
=20
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
--=20
2.17.1
