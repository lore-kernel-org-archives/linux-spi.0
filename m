From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/3] drivers: gpio: pcf857x: use subsys_spi_driver()
Date: Mon, 17 Jun 2019 20:40:39 +0200
Message-ID: <1560796840-18207-2-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-max7301.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 647dfbb..30815cf 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -86,21 +86,10 @@ static int max7301_remove(struct spi_device *spi)
 	.remove = max7301_remove,
 	.id_table = max7301_id,
 };
-
-static int __init max7301_init(void)
-{
-	return spi_register_driver(&max7301_driver);
-}
 /* register after spi postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(max7301_init);
-
-static void __exit max7301_exit(void)
-{
-	spi_unregister_driver(&max7301_driver);
-}
-module_exit(max7301_exit);
+subsys_spi_driver(max7301_driver);
 
 MODULE_AUTHOR("Juergen Beisert, Wolfram Sang");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
