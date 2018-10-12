From: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Date: Fri, 12 Oct 2018 10:23:18 +0100
Message-ID: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
Cc: Phil Elwell <phil@raspberrypi.org>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The SPI configuration state includes an SPI_NO_CS flag that disables
all CS line manipulation, for applications that want to manage their
own chip selects. However, this flag is ignored by the GPIO CS code
in the SPI framework.

Correct this omission with a trivial patch.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 84dfef4..b1d88fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -729,7 +729,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, !enable);
+		/* Honour the SPI_NO_CS flag */
+		if (!(spi->mode & SPI_NO_CS))
+			gpio_set_value(spi->cs_gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
-- 
2.7.4
