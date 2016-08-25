From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/23] spi: fsl-espi: change return type of fsl_espi_cpu_bufs
 to void
Date: Thu, 25 Aug 2016 06:44:58 +0200
Message-ID: <40dcd903-fdae-6669-5c35-af4b9e9e953b@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

fsl_espi_cpu_bufs always returns 0, so change the return type to void.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 38eced3..cc09ce6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -195,7 +195,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	fsl_espi_change_mode(spi);
 }
 
-static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
+static void fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
 		unsigned int len)
 {
 	u32 word;
@@ -209,8 +209,6 @@ static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
 	/* transmit word */
 	word = mspi->get_tx(mspi);
 	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
-
-	return 0;
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
@@ -237,9 +235,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	mpc8xxx_spi_write_reg(&reg_base->command,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
-	ret = fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
-	if (ret)
-		return ret;
+	fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
