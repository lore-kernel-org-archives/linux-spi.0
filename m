From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: ath79: Fix module autoload for OF registration" to the spi tree
Date: Fri, 25 Nov 2016 13:10:40 +0000
Message-ID: <E1cAGH2-0005Kw-Fe@debutante>
References: <1479919031-5112-5-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479919031-5112-5-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: ath79: Fix module autoload for OF registration

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

>From d7a32394e734a004126b454cf747befb626b93ac Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Wed, 23 Nov 2016 13:37:11 -0300
Subject: [PATCH] spi: ath79: Fix module autoload for OF registration

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/spi/spi-ath79.ko | grep alias
alias:          platform:ath79-spi

After this patch:

$ modinfo drivers/spi/spi-ath79.ko | grep alias
alias:          platform:ath79-spi
alias:          of:N*T*Cqca,ar7100-spiC*
alias:          of:N*T*Cqca,ar7100-spi

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 6165bf21d427..f369174fbd88 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -304,6 +304,7 @@ static const struct of_device_id ath79_spi_of_match[] = {
 	{ .compatible = "qca,ar7100-spi", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ath79_spi_of_match);
 
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
