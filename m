From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 7/7] spi: atmel: Improve CS0 case support on AT91RM9200
Date: Thu, 17 Oct 2019 16:18:46 +0200
Message-ID: <20191017141846.7523-8-gregory.clement@bootlin.com>
References: <20191017141846.7523-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141846.7523-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Thanks to the recent change in this driver, it is now possible to
prevent using the CS0 with GPIO during setup. It then allows to remove
the special handling of this case in the cs_activate() and
cs_deactivate() functions.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/spi/spi-atmel.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ac5e2ddf9e1b..d88e2aa64839 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -371,7 +371,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod && spi->chip_select != 0)
+		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
@@ -402,7 +402,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
+	else
 		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
@@ -1193,7 +1193,16 @@ static void initialize_native_cs_for_gpio(struct atmel_spi *as)
 	if (!master->cs_gpiods)
 		return; /* No CS GPIO */
 
-	for (i = 0; i < 4; i++)
+	/*
+	 * On the first version of the controller (AT91RM9200), CS0
+	 * can't be used associated with GPIO
+	 */
+	if (atmel_spi_is_v2(as))
+		i = 0;
+	else
+		i = 1;
+
+	for (; i < 4; i++)
 		if (master->cs_gpiods[i])
 			as->native_cs_free |= BIT(i);
 
-- 
2.23.0
