From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] spi: atmel: use managed resource for gpio chip select
Date: Wed, 21 Sep 2016 09:55:28 +0200
Message-ID: <20160921075528.14452-1-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
To: <linux@meltdown.ru>, Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the managed gpio CS pin request so that we avoid having trouble
in the cleanup code.
In fact, if module was configured with DT, cleanup code released
invalid pin.  Since resource wasn't freed, module cannot be reinserted.

Reported-by: Alexander Morozov <linux@meltdown.ru>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8feac599e9ab..4e3f2345844a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1248,7 +1248,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 			return -ENOMEM;
 
 		if (as->use_cs_gpios) {
-			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
+			ret = devm_gpio_request(&spi->dev,
+						npcs_pin, dev_name(&spi->dev));
 			if (ret) {
 				kfree(asd);
 				return ret;
@@ -1471,13 +1472,11 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
 static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned long) spi->controller_data;
 
 	if (!asd)
 		return;
 
 	spi->controller_state = NULL;
-	gpio_free(gpio);
 	kfree(asd);
 }
 
-- 
2.9.0
