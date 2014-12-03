From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: fsl-espi: add (un)prepare_transfer_hardware calls
 to save power if SPI is not in use
Date: Wed, 03 Dec 2014 07:56:19 +0100
Message-ID: <547EB413.8050604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use (un)prepare_transfer_hardware calls to set fsl-espi to
low-power idle if not in use. Reference manual states:

"The eSPI is in a idle state and consumes minimal power.
The eSPI BRG is not functioning and the input clock is disabled"

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e5702c9..d0a73a0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -588,6 +588,38 @@ static void fsl_espi_remove(struct mpc8xxx_spi *mspi)
 	iounmap(mspi->reg_base);
 }
 
+static int fsl_espi_suspend(struct spi_master *master)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi_reg *reg_base;
+	u32 regval;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	reg_base = mpc8xxx_spi->reg_base;
+
+	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval &= ~SPMODE_ENABLE;
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+
+	return 0;
+}
+
+static int fsl_espi_resume(struct spi_master *master)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi_reg *reg_base;
+	u32 regval;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	reg_base = mpc8xxx_spi->reg_base;
+
+	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval |= SPMODE_ENABLE;
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+
+	return 0;
+}
+
 static struct spi_master * fsl_espi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
@@ -614,6 +646,8 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
+	master->prepare_transfer_hardware = fsl_espi_resume;
+	master->unprepare_transfer_hardware = fsl_espi_suspend;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->spi_remove = fsl_espi_remove;
@@ -761,25 +795,15 @@ static int of_fsl_espi_remove(struct platform_device *dev)
 static int of_fsl_espi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
-	u32 regval;
 	int ret;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
-	reg_base = mpc8xxx_spi->reg_base;
-
 	ret = spi_master_suspend(master);
 	if (ret) {
 		dev_warn(dev, "cannot suspend master\n");
 		return ret;
 	}
 
-	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
-	regval &= ~SPMODE_ENABLE;
-	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
-
-	return 0;
+	return fsl_espi_suspend(master);
 }
 
 static int of_fsl_espi_resume(struct device *dev)
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
