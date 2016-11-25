From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: jcore: Fix module autoload for OF registration" to the spi tree
Date: Fri, 25 Nov 2016 13:10:46 +0000
Message-ID: <E1cAGH8-0005MV-FX@debutante>
References: <1479919031-5112-3-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479919031-5112-3-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: jcore: Fix module autoload for OF registration

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

>From aa12c1ab8bb21c9e83bcc92eb75928170f24e666 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Wed, 23 Nov 2016 13:37:09 -0300
Subject: [PATCH] spi: jcore: Fix module autoload for OF registration

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/spi/spi-jcore.ko | grep alias
alias:          platform:jcore_spi

After this patch:

$ modinfo drivers/spi/spi-jcore.ko | grep alias
alias:          platform:jcore_spi
alias:          of:N*T*Cjcore,spi2C*
alias:          of:N*T*Cjcore,spi2

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-jcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index f8117b80fa22..cebfea5faa4b 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -214,6 +214,7 @@ static const struct of_device_id jcore_spi_of_match[] = {
 	{ .compatible = "jcore,spi2" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, jcore_spi_of_match);
 
 static struct platform_driver jcore_spi_driver = {
 	.probe = jcore_spi_probe,
-- 
2.10.2
