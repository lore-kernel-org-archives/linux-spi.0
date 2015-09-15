From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 11/16] spi: dw: Remove needless if statements
Date: Tue, 15 Sep 2015 16:26:23 +0300
Message-ID: <1442323588-29642-11-git-send-email-jarkko.nikula@linux.intel.com>
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

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This allows to remove related if
statements as they evaluate always to true and reduce indentation.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 4fbfcdc5cb24..2b5d736465c9 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -309,34 +309,29 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	cr0 = chip->cr0;
 
 	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz) {
-		speed = chip->speed_hz;
+	speed = chip->speed_hz;
+	if ((transfer->speed_hz != speed) || !chip->clk_div) {
+		speed = transfer->speed_hz;
 
-		if ((transfer->speed_hz != speed) || !chip->clk_div) {
-			speed = transfer->speed_hz;
+		/* clk_div doesn't support odd number */
+		clk_div = (dws->max_freq / speed + 1) & 0xfffe;
 
-			/* clk_div doesn't support odd number */
-			clk_div = (dws->max_freq / speed + 1) & 0xfffe;
+		chip->speed_hz = speed;
+		chip->clk_div = clk_div;
 
-			chip->speed_hz = speed;
-			chip->clk_div = clk_div;
-
-			spi_set_clk(dws, chip->clk_div);
-		}
+		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word) {
-		if (transfer->bits_per_word == 8) {
-			dws->n_bytes = 1;
-			dws->dma_width = 1;
-		} else if (transfer->bits_per_word == 16) {
-			dws->n_bytes = 2;
-			dws->dma_width = 2;
-		}
-		cr0 = (transfer->bits_per_word - 1)
-			| (chip->type << SPI_FRF_OFFSET)
-			| (spi->mode << SPI_MODE_OFFSET)
-			| (chip->tmode << SPI_TMOD_OFFSET);
+	if (transfer->bits_per_word == 8) {
+		dws->n_bytes = 1;
+		dws->dma_width = 1;
+	} else if (transfer->bits_per_word == 16) {
+		dws->n_bytes = 2;
+		dws->dma_width = 2;
 	}
+	cr0 = (transfer->bits_per_word - 1)
+		| (chip->type << SPI_FRF_OFFSET)
+		| (spi->mode << SPI_MODE_OFFSET)
+		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
 	 * Adjust transfer mode if necessary. Requires platform dependent
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
