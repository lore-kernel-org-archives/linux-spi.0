From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing gpio_request_one
Date: Mon, 27 Jul 2015 13:11:16 +0100
Message-ID: <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <abrestic@chromium.org>,
	Sifan Naeem <sifan.naeem@imgtec.com>,
	"Stable kernel (v4.1)" <stable@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spfi_setup may be called many times bye the spi framework, but
gpio_request_one can only be called once without freeing, repeatedly
calling gpio_request_one will cause an error to be thrown, which causes
the request to spi_setup to be marked as failed.

We can simply use gpio_direction_output to set the direction of the
gpio instead of gpio_request_one to put the gpio in to initial state,
after which the spi framework can control the chipselect line via gpio
using gpio_set_value.

Fixes: 8c2c8c0 ("spi: img-spfi: Control CS lines with GPIO")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Stable kernel (v4.1) <stable@vger.kernel.org>
---
 drivers/spi/spi-img-spfi.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index f27d9d5..a7f3d6a 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -442,13 +442,15 @@ static int img_spfi_setup(struct spi_device *spi)
 {
 	int ret;
 
-	ret = gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
-			       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-			       dev_name(&spi->dev));
-	if (ret)
-		dev_err(&spi->dev, "can't request chipselect gpio %d\n",
-				spi->cs_gpio);
-
+	if (gpio_is_valid(spi->cs_gpio)) {
+		int mode = ((spi->mode & SPI_CS_HIGH) ?
+			     GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
+
+		ret = gpio_direction_output(spi->cs_gpio, mode);
+		if (ret)
+			dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
+				spi->cs_gpio, ret);
+	}
 	return ret;
 }
 
-- 
1.7.9.5
