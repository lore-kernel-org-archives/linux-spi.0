From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 08/16] spi: omap-uwire: Remove needless bits_per_word and speed_hz tests
Date: Tue, 15 Sep 2015 16:26:20 +0300
Message-ID: <1442323588-29642-8-git-send-email-jarkko.nikula@linux.intel.com>
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
transfer parameters are not set. This allows to remove two needless tests
from uwire_txrx() and uwire_setup_transfer().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-omap-uwire.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 55576db31549..ce8dbdbce312 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -205,7 +205,7 @@ static void uwire_chipselect(struct spi_device *spi, int value)
 static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	unsigned	len = t->len;
-	unsigned	bits = t->bits_per_word ? : spi->bits_per_word;
+	unsigned	bits = t->bits_per_word;
 	unsigned	bytes;
 	u16		val, w;
 	int		status = 0;
@@ -344,9 +344,10 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	/* assume it's already enabled */
 	rate = clk_get_rate(uwire->ck);
 
-	hz = spi->max_speed_hz;
-	if (t != NULL && t->speed_hz)
+	if (t != NULL)
 		hz = t->speed_hz;
+	else
+		hz = spi->max_speed_hz;
 
 	if (!hz) {
 		pr_debug("%s: zero speed?\n", dev_name(&spi->dev));
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
