From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/4] spi: jcore: Fix module autoload for OF registration
Date: Wed, 23 Nov 2016 13:37:09 -0300
Message-ID: <1479919031-5112-3-git-send-email-javier@osg.samsung.com>
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

$ modinfo drivers/spi/spi-jcore.ko | grep alias
alias:          platform:jcore_spi

After this patch:

$ modinfo drivers/spi/spi-jcore.ko | grep alias
alias:          platform:jcore_spi
alias:          of:N*T*Cjcore,spi2C*
alias:          of:N*T*Cjcore,spi2

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
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
2.7.4
