From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 4/4] spi: ath79: Fix module autoload for OF registration
Date: Wed, 23 Nov 2016 13:37:11 -0300
Message-ID: <1479919031-5112-5-git-send-email-javier@osg.samsung.com>
References: <1479919031-5112-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479919031-5112-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

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
2.7.4
