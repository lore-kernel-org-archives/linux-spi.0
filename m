From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 1/4] spi: spi-axi: Fix module autoload
Date: Wed, 23 Nov 2016 13:37:08 -0300
Message-ID: <1479919031-5112-2-git-send-email-javier@osg.samsung.com>
References: <1479919031-5112-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479919031-5112-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/spi/spi-axi-spi-engine.ko | grep alias
$

After this patch:

$ modinfo drivers/spi/spi-axi-spi-engine.ko | grep alias
alias:          of:N*T*Cadi,axi-spi-engine-1.00.aC*
alias:          of:N*T*Cadi,axi-spi-engine-1.00.a

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---

 drivers/spi/spi-axi-spi-engine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 2b1456e5e221..319225d7e761 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -574,6 +574,7 @@ static const struct of_device_id spi_engine_match_table[] = {
 	{ .compatible = "adi,axi-spi-engine-1.00.a" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, spi_engine_match_table);
 
 static struct platform_driver spi_engine_driver = {
 	.probe = spi_engine_probe,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
