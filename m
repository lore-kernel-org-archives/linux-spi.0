From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] gpiolib: of: Make of_gpio_spi_cs_get_count static
Date: Sat, 30 Nov 2019 09:28:28 +0800
Message-ID: <20191130012828.14504-1-yuehaibing@huawei.com>
References: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
To: <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix sparse warning:

drivers/gpio/gpiolib-of.c:35:5: warning:
 symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: This is caused by commit 71b8f600b034 ("gpio: Handle counting of Freescale chipselects"),
	should be applied to spi tree.
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 610c6622f62d..b696e4598a24 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -32,7 +32,7 @@
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 {
 	struct device_node *np = dev->of_node;
 
-- 
2.20.1
