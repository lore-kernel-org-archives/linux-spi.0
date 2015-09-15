From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 14/16] spi: pxa2xx: Remove two variables from struct chip_data
Date: Tue, 15 Sep 2015 16:26:26 +0300
Message-ID: <1442323588-29642-14-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no need to carry spi->max_speed_hz and spi->bits_per_word from
setup() in "struct chip_data" since pump_transfers() will anyway take the
transfer parameters from "struct spi_transfer". This is since SPI core
validates both bits_per_word and speed_hz transfer parameters and defaults
to spi->bits_per_word and spi->max_speed_hz in case these per transfer
parameters are not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 12 ++----------
 drivers/spi/spi-pxa2xx.h |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a8ef38ebb9c9..40862f589277 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -925,14 +925,8 @@ static void pump_transfers(unsigned long data)
 	cr0 = chip->cr0;
 	if (transfer->speed_hz || transfer->bits_per_word) {
 
-		bits = chip->bits_per_word;
-		speed = chip->speed_hz;
-
-		if (transfer->speed_hz)
-			speed = transfer->speed_hz;
-
-		if (transfer->bits_per_word)
-			bits = transfer->bits_per_word;
+		bits = transfer->bits_per_word;
+		speed = transfer->speed_hz;
 
 		clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
 
@@ -1204,7 +1198,6 @@ static int setup(struct spi_device *spi)
 	}
 
 	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, spi->max_speed_hz);
-	chip->speed_hz = spi->max_speed_hz;
 
 	chip->cr0 = pxa2xx_configure_sscr0(drv_data, clk_div,
 					   spi->bits_per_word);
@@ -1255,7 +1248,6 @@ static int setup(struct spi_device *spi)
 		chip->read = u32_reader;
 		chip->write = u32_writer;
 	}
-	chip->bits_per_word = spi->bits_per_word;
 
 	spi_set_ctldata(spi, chip);
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 0a9b6390a817..0875e985b90d 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -98,8 +98,6 @@ struct chip_data {
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
 	u8 enable_dma;
-	u8 bits_per_word;
-	u32 speed_hz;
 	union {
 		int gpio_cs;
 		unsigned int frm;
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
