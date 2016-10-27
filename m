From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 04/09] spi: fsl-espi: simplify and inline function
 fsl_espi_change_mode
Date: Thu, 27 Oct 2016 21:26:46 +0200
Message-ID: <ba949086-5269-a88c-c0ec-d19ebc87464c@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The ESPI spec mentions no requirement to turn off the ESPI unit prior
to changing the mode. Most likely the ESPI unit is only turned off to
clear the FIFO's as before this patch series single bytes could
remain in the TX FIFO after transfer end.
Therefore remove disabling / re-enabling the ESPI unit.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 5a7449f..d550685 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -223,26 +223,6 @@ static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 		}
 }
 
-static void fsl_espi_change_mode(struct spi_device *spi)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
-	struct spi_mpc8xxx_cs *cs = spi->controller_state;
-	u32 tmp;
-	unsigned long flags;
-
-	/* Turn off IRQs locally to minimize time that SPI is disabled. */
-	local_irq_save(flags);
-
-	/* Turn off SPI unit prior changing mode */
-	tmp = fsl_espi_read_reg(mspi, ESPI_SPMODE);
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp & ~SPMODE_ENABLE);
-	fsl_espi_write_reg(mspi, ESPI_SPMODEx(spi->chip_select),
-			      cs->hw_mode);
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp);
-
-	local_irq_restore(flags);
-}
-
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -276,7 +256,8 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-	fsl_espi_change_mode(spi);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
+			   cs->hw_mode);
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
