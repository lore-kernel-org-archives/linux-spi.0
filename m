From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 09/15] spi: fsl-espi: merge fsl_espi_bufs and
 fsl_espi_cpu_bufs
Date: Wed, 7 Sep 2016 22:53:01 +0200
Message-ID: <60c463fc-3a46-8787-164b-821efd80fd16@gmail.com>
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

fsl_espi_bufs and fsl_espi_cpu_bufs are very small that we can merge them.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
v3:
- new numbering
---
 drivers/spi/spi-fsl-espi.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8d6a570..190ca5c 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -206,31 +206,15 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	fsl_espi_change_mode(spi);
 }
 
-static void fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
-		unsigned int len)
-{
-	u32 word;
-	struct fsl_espi_reg *reg_base = mspi->reg_base;
-
-	mspi->count = len;
-
-	/* enable rx ints */
-	mpc8xxx_spi_write_reg(&reg_base->mask, SPIM_NE);
-
-	/* transmit word */
-	word = mspi->get_tx(mspi);
-	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
-}
-
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
-	unsigned int len = t->len;
+	u32 word;
 	int ret;
 
 	mpc8xxx_spi->len = t->len;
-	len = roundup(len, 4) / 4;
+	mpc8xxx_spi->count = roundup(t->len, 4) / 4;
 
 	mpc8xxx_spi->tx = t->tx_buf;
 	mpc8xxx_spi->rx = t->rx_buf;
@@ -246,7 +230,12 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	mpc8xxx_spi_write_reg(&reg_base->command,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
-	fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
+	/* enable rx ints */
+	mpc8xxx_spi_write_reg(&reg_base->mask, SPIM_NE);
+
+	/* transmit word */
+	word = mpc8xxx_spi->get_tx(mpc8xxx_spi);
+	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
