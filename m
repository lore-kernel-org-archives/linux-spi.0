From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message
Date: Tue,  7 Jan 2020 09:39:12 +0530
Message-ID: <20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To: Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use platform_get_irq_byname_optional() instead of platform_get_irq_byname()
to avoid below error message during probe:

[3.265115] bcm_iproc 68c70200.spi: IRQ spi_lr_fullness_reached not found
[3.272121] bcm_iproc 68c70200.spi: IRQ spi_lr_session_aborted not found
[3.284965] bcm_iproc 68c70200.spi: IRQ spi_lr_impatient not found
[3.291344] bcm_iproc 68c70200.spi: IRQ spi_lr_session_done not found
[3.297992] bcm_iproc 68c70200.spi: IRQ mspi_done not found
[3.303742] bcm_iproc 68c70200.spi: IRQ mspi_halted not found

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 85bad70f59e3..23d295f36c80 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1293,7 +1293,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		name = qspi_irq_tab[val].irq_name;
 		if (qspi_irq_tab[val].irq_source == SINGLE_L2) {
 			/* get the l2 interrupts */
-			irq = platform_get_irq_byname(pdev, name);
+			irq = platform_get_irq_byname_optional(pdev, name);
 		} else if (!num_ints && soc_intc) {
 			/* all mspi, bspi intrs muxed to one L1 intr */
 			irq = platform_get_irq(pdev, 0);
-- 
2.17.1
