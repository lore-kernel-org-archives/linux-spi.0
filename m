From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/3] include: linux: spi: more helpers for declaring spi drivers
Date: Mon, 17 Jun 2019 20:40:38 +0200
Message-ID: <1560796840-18207-1-git-send-email-info@metux.net>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Add more helper macros for trivial driver init cases, similar to the
already existing module_spi_driver()+friends - now for those which
are initialized at other stages (eg. by subsys_initcall()).

This helps to further reduce driver init boilerplate.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 include/linux/spi/spi.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd2..f55ba34 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -296,6 +296,23 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 	module_driver(__spi_driver, spi_register_driver, \
 			spi_unregister_driver)
 
+/* subsys_spi_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces subsys_initcall() and module_exit()
+ */
+#define subsys_spi_driver(__spi_driver) \
+static int __init __spi_driver##_init(void) \
+{ \
+	return spi_register_driver(&(__spi_driver)); \
+} \
+subsys_initcall(__spi_driver##_init); \
+static void __exit __spi_driver##_exit(void) \
+{ \
+	spi_unregister_driver(&(__spi_driver)); \
+} \
+module_exit(__spi_driver##_exit);
+
 /**
  * struct spi_controller - interface to SPI master or slave controller
  * @dev: device interface to this driver
-- 
1.9.1
