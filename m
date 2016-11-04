From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: fsl-espi: don't write ESPI_SPMODE register if the
 mode doesn't change
Date: Fri, 4 Nov 2016 21:01:12 +0100
Message-ID: <f21f9e2d-ae0d-13d4-dfb0-21daacbb3a08@gmail.com>
References: <b54b86a6-aaf9-d4da-187e-3cd40d6aca86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b54b86a6-aaf9-d4da-187e-3cd40d6aca86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There's no need to bother the chip if the mode doesn't change.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1029bd2..edb524f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -249,6 +249,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
+	u32 hw_mode_old = cs->hw_mode;
 
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
@@ -271,8 +272,10 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
-			   cs->hw_mode);
+	/* don't write the mode register if the mode doesn't change */
+	if (cs->hw_mode != hw_mode_old)
+		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
+				   cs->hw_mode);
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
