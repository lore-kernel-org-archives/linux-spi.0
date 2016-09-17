From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: fsl-espi: remove unused variable in fsl_espi_setup
Date: Sat, 17 Sep 2016 15:42:42 +0200
Message-ID: <a71abf9f-4254-af63-f7eb-1579faaeada3@gmail.com>
References: <1d67ce99-42ea-c816-da35-e64575cca8ff@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d67ce99-42ea-c816-da35-e64575cca8ff-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove an unused variable.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index a7984ae..4f9d9ec 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -361,7 +361,6 @@ out:
 static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	u32 hw_mode;
 	u32 loop_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
 
@@ -379,7 +378,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 
 	pm_runtime_get_sync(mpc8xxx_spi->dev);
 
-	hw_mode = cs->hw_mode; /* Save original settings */
 	cs->hw_mode = fsl_espi_read_reg(mpc8xxx_spi,
 					   ESPI_SPMODEx(spi->chip_select));
 	/* mask out bits we are going to set */
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
