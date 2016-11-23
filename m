From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/4] spi: xlp: Fix module autoload for OF registration
Date: Wed, 23 Nov 2016 13:37:10 -0300
Message-ID: <1479919031-5112-4-git-send-email-javier@osg.samsung.com>
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

$ modinfo drivers/spi/spi-xlp.ko | grep alias
alias:          acpi*:BRCM900D:*

After this patch:

$ modinfo drivers/spi/spi-xlp.ko | grep alias
alias:          acpi*:BRCM900D:*
alias:          of:N*T*Cnetlogic,xlp832-spiC*
alias:          of:N*T*Cnetlogic,xlp832-spi

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
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
2.7.4
