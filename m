From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: xlp: Fix module autoload for OF registration" to the spi tree
Date: Fri, 25 Nov 2016 13:10:43 +0000
Message-ID: <E1cAGH5-0005Lj-G3@debutante>
References: <1479919031-5112-4-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479919031-5112-4-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: xlp: Fix module autoload for OF registration

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b87c701b660f60cdb50a8613161b1037535e09b0 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Wed, 23 Nov 2016 13:37:10 -0300
Subject: [PATCH] spi: xlp: Fix module autoload for OF registration

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/spi/spi-xlp.ko | grep alias
alias:          acpi*:BRCM900D:*

After this patch:

$ modinfo drivers/spi/spi-xlp.ko | grep alias
alias:          acpi*:BRCM900D:*
alias:          of:N*T*Cnetlogic,xlp832-spiC*
alias:          of:N*T*Cnetlogic,xlp832-spi

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-xlp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 4071a729eb2f..bea7a93a6046 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -451,6 +451,7 @@ static const struct of_device_id xlp_spi_dt_id[] = {
 	{ .compatible = "netlogic,xlp832-spi" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, xlp_spi_dt_id);
 
 static struct platform_driver xlp_spi_driver = {
 	.probe	= xlp_spi_probe,
-- 
2.10.2
