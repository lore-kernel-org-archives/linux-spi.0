From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 3/3] drivers: gpio: mc33880: use subsys_spi_driver()
Date: Mon, 17 Jun 2019 20:40:40 +0200
Message-ID: <1560796840-18207-3-git-send-email-info@metux.net>
References: <1560796840-18207-1-git-send-email-info@metux.net>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796840-18207-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_spi_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-mc33880.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
index f8194f7..1b9434c 100644
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -156,21 +156,10 @@ static int mc33880_remove(struct spi_device *spi)
 	.remove		= mc33880_remove,
 };
 
-static int __init mc33880_init(void)
-{
-	return spi_register_driver(&mc33880_driver);
-}
 /* register after spi postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(mc33880_init);
-
-static void __exit mc33880_exit(void)
-{
-	spi_unregister_driver(&mc33880_driver);
-}
-module_exit(mc33880_exit);
+subsys_spi_driver(mc33880_driver);
 
 MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
 MODULE_LICENSE("GPL v2");
-
-- 
1.9.1
