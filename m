From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message" to the spi tree
Date: Wed, 08 Jan 2020 15:59:22 +0000
Message-ID: <applied-20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
References: <20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From e9aa3b851428282d5e5151a49d4bf0bfdcd72bfe Mon Sep 17 00:00:00 2001
From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date: Tue, 7 Jan 2020 09:39:12 +0530
Subject: [PATCH] spi: bcm-qspi: Use platform_get_irq_byname_optional() to
 avoid error message

Use platform_get_irq_byname_optional() instead of platform_get_irq_byname()
to avoid below error message during probe:

[3.265115] bcm_iproc 68c70200.spi: IRQ spi_lr_fullness_reached not found
[3.272121] bcm_iproc 68c70200.spi: IRQ spi_lr_session_aborted not found
[3.284965] bcm_iproc 68c70200.spi: IRQ spi_lr_impatient not found
[3.291344] bcm_iproc 68c70200.spi: IRQ spi_lr_session_done not found
[3.297992] bcm_iproc 68c70200.spi: IRQ mspi_done not found
[3.303742] bcm_iproc 68c70200.spi: IRQ mspi_halted not found

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Link: https://lore.kernel.org/r/20200107040912.16426-1-rayagonda.kokatanur@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
