From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: fix dataloss when SS is inactivated between every words" to the spi tree
Date: Thu, 21 Mar 2019 15:07:38 +0000 (GMT)
Message-ID: <20190321150738.9683711288EC@debutante.sirena.org.uk>
References: <20190321095720.14438-1-xiaoning.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321095720.14438-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: fix dataloss when SS is inactivated between every words

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

>From 69c8a9bcb03222ad3b949064ac05de463c7c9aa3 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Thu, 21 Mar 2019 09:57:12 +0000
Subject: [PATCH] spi: lpspi: fix dataloss when SS is inactivated between every
 words

If we don't use CONT to keep SS activated or use DMA mode without
cs-gpio, SS will be inactivated between every words. The word here
means the data sent once which length can be set as 1/2/4 bytes.

In the isr function, we read the FSR_RXCOUNT just behind the
fsl_lpspi_read_rx_fifo. This causes the value of FSR_RXCOUNT cannot
reflect whether there is still data not sent timely. So do this
judgement by FSR_TXCOUNT.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 391863914043..9e117c4635d8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -62,7 +62,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
-#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
+#define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -452,7 +452,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	}
 
 	if (temp_SR & SR_MBF ||
-	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
 		return IRQ_HANDLED;
-- 
2.20.1
