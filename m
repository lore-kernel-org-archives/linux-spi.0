From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: fix dataloss when SS is inactivated between every
 words
Date: Thu, 21 Mar 2019 09:57:12 +0000
Message-ID: <20190321095720.14438-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If we don't use CONT to keep SS activated or use DMA mode without
cs-gpio, SS will be inactivated between every words. The word here
means the data sent once which length can be set as 1/2/4 bytes.

In the isr function, we read the FSR_RXCOUNT just behind the
fsl_lpspi_read_rx_fifo. This causes the value of FSR_RXCOUNT cannot
reflect whether there is still data not sent timely. So do this
judgement by FSR_TXCOUNT.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4de8eb378752..0252cae0b35b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -77,7 +77,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
-#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
+#define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -765,7 +765,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	}
=20
 	if (temp_SR & SR_MBF ||
-	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
 		return IRQ_HANDLED;
--=20
2.17.1
